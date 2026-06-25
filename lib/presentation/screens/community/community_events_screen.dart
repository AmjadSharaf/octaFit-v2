import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class _CommunityEvent {
  const _CommunityEvent({
    required this.id,
    required this.title,
    required this.icon,
    required this.date,
    required this.time,
    required this.location,
    required this.attendees,
    required this.type,
    required this.isPast,
  });

  final String id;
  final String title;
  final String icon;
  final String date;
  final String time;
  final String location;
  final int attendees;
  final String type;
  final bool isPast;
}

const _communityEvents = <_CommunityEvent>[
  _CommunityEvent(
    id: 'e1',
    title: 'OctaFit 5K Community Run',
    icon: '🏃',
    date: 'Jun 15, 2026',
    time: '7:00 AM',
    location: 'Golden Gate Park',
    attendees: 342,
    type: 'Cardio',
    isPast: false,
  ),
  _CommunityEvent(
    id: 'e2',
    title: 'Open Gym Meetup',
    icon: '🏋️',
    date: 'Jun 18, 2026',
    time: '6:00 PM',
    location: 'OctaFit SF Studio',
    attendees: 128,
    type: 'Strength',
    isPast: false,
  ),
  _CommunityEvent(
    id: 'e3',
    title: 'MMA Sparring Night',
    icon: '🥊',
    date: 'Jun 22, 2026',
    time: '7:30 PM',
    location: 'Fight Lab Arena',
    attendees: 64,
    type: 'MMA',
    isPast: false,
  ),
  _CommunityEvent(
    id: 'e4',
    title: 'Yoga in the Park',
    icon: '🧘',
    date: 'Jun 25, 2026',
    time: '8:00 AM',
    location: 'Dolores Park',
    attendees: 210,
    type: 'Recovery',
    isPast: false,
  ),
  _CommunityEvent(
    id: 'e5',
    title: 'Spring Fitness Challenge Finals',
    icon: '🏆',
    date: 'May 30, 2026',
    time: '2:00 PM',
    location: 'OctaFit HQ',
    attendees: 520,
    type: 'Competition',
    isPast: true,
  ),
];

class CommunityEventsScreen extends StatefulWidget {
  const CommunityEventsScreen({super.key});

  @override
  State<CommunityEventsScreen> createState() => _CommunityEventsScreenState();
}

class _CommunityEventsScreenState extends State<CommunityEventsScreen> {
  String _filter = 'Upcoming';
  final Set<String> _rsvp = {'e1'};

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    final filtered = switch (_filter) {
      'Past' => _communityEvents.where((e) => e.isPast).toList(),
      _ => _communityEvents.where((e) => !e.isPast).toList(),
    };

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(
            title: 'Events',
            subtitle: 'Community meetups & competitions',
            showBack: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: ['Upcoming', 'Past']
                  .map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChipWidget(
                        label: f,
                        active: _filter == f,
                        onTap: () => setState(() => _filter = f),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'No $_filter events',
                      style: GoogleFonts.inter(fontSize: 14, color: subColor),
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final event = filtered[index];
                      final isRsvpd = _rsvp.contains(event.id);
                      return GlassCard(
                        glow: isRsvpd ? GlassGlow.blue : GlassGlow.none,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  event.icon,
                                  style: const TextStyle(fontSize: 36),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      BadgeWidget(
                                        label: event.type.toUpperCase(),
                                        color: BadgeColor.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            _EventDetailRow(
                              icon: Icons.calendar_today_rounded,
                              label: '${event.date} · ${event.time}',
                              subColor: subColor,
                            ),
                            const SizedBox(height: 6),
                            _EventDetailRow(
                              icon: Icons.location_on_rounded,
                              label: event.location,
                              subColor: subColor,
                            ),
                            const SizedBox(height: 6),
                            _EventDetailRow(
                              icon: Icons.people_rounded,
                              label: '${event.attendees} attending',
                              subColor: subColor,
                            ),
                            if (!event.isPast) ...[
                              const SizedBox(height: 14),
                              PrimaryButton(
                                label: isRsvpd ? 'Cancel RSVP' : 'RSVP',
                                variant: isRsvpd
                                    ? PrimaryButtonVariant.glass
                                    : PrimaryButtonVariant.blue,
                                onPressed: () {
                                  setState(() {
                                    if (_rsvp.contains(event.id)) {
                                      _rsvp.remove(event.id);
                                    } else {
                                      _rsvp.add(event.id);
                                    }
                                  });
                                },
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EventDetailRow extends StatelessWidget {
  const _EventDetailRow({
    required this.icon,
    required this.label,
    required this.subColor,
  });

  final IconData icon;
  final String label;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: subColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(fontSize: 13, color: subColor),
          ),
        ),
      ],
    );
  }
}
