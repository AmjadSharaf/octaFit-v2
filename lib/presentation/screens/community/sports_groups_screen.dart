import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/chip_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class _SportsGroup {
  const _SportsGroup({
    required this.id,
    required this.name,
    required this.icon,
    required this.category,
    required this.members,
    required this.description,
    required this.joined,
  });

  final String id;
  final String name;
  final String icon;
  final String category;
  final int members;
  final String description;
  final bool joined;
}

const _sportsGroups = <_SportsGroup>[
  _SportsGroup(
    id: 'g1',
    name: 'OctaFit Runners',
    icon: '🏃',
    category: 'Cardio',
    members: 3420,
    description: 'Daily runs, race prep & recovery tips',
    joined: true,
  ),
  _SportsGroup(
    id: 'g2',
    name: 'Iron Lifters Club',
    icon: '🏋️',
    category: 'Strength',
    members: 5180,
    description: 'Powerlifting, hypertrophy & PR celebrations',
    joined: true,
  ),
  _SportsGroup(
    id: 'g3',
    name: 'MMA Fighters United',
    icon: '🥊',
    category: 'MMA',
    members: 1890,
    description: 'Striking drills, sparring & fight camp logs',
    joined: false,
  ),
  _SportsGroup(
    id: 'g4',
    name: 'Yoga & Mobility',
    icon: '🧘',
    category: 'Recovery',
    members: 2760,
    description: 'Flexibility, breathwork & injury prevention',
    joined: false,
  ),
  _SportsGroup(
    id: 'g5',
    name: 'Home Workout Heroes',
    icon: '🏠',
    category: 'Home',
    members: 4210,
    description: 'No-equipment workouts & bodyweight progress',
    joined: false,
  ),
];

class SportsGroupsScreen extends StatefulWidget {
  const SportsGroupsScreen({super.key});

  static const _filters = ['All', 'Strength', 'Cardio', 'MMA', 'Recovery', 'Home'];

  @override
  State<SportsGroupsScreen> createState() => _SportsGroupsScreenState();
}

class _SportsGroupsScreenState extends State<SportsGroupsScreen> {
  String _filter = 'All';
  final Set<String> _joined = {'g1', 'g2'};

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    final filtered = _filter == 'All'
        ? _sportsGroups
        : _sportsGroups.where((g) => g.category == _filter).toList();

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(
            title: 'Sports Groups',
            subtitle: 'Train together, grow together',
            showBack: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: SportsGroupsScreen._filters
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
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final group = filtered[index];
                final isJoined = _joined.contains(group.id);
                return GlassCard(
                  glow: isJoined ? GlassGlow.blue : GlassGlow.none,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(group.icon, style: const TextStyle(fontSize: 36)),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        group.name,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                    if (isJoined) ...[
                                      const SizedBox(width: 8),
                                      const BadgeWidget(
                                        label: 'JOINED',
                                        color: BadgeColor.green,
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  '${_formatMembers(group.members)} members · ${group.category}',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: subColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        group.description,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: subColor,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 14),
                      PrimaryButton(
                        label: isJoined ? 'Leave Group' : 'Join Group',
                        variant: isJoined
                            ? PrimaryButtonVariant.glass
                            : PrimaryButtonVariant.blue,
                        onPressed: () {
                          setState(() {
                            if (_joined.contains(group.id)) {
                              _joined.remove(group.id);
                            } else {
                              _joined.add(group.id);
                            }
                          });
                        },
                      ),
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

  static String _formatMembers(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return '$count';
  }
}
