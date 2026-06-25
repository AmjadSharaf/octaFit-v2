import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/avatar_widget.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/stat_card.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class FighterProfileScreen extends StatelessWidget {
  const FighterProfileScreen({super.key, this.fighterName});

  final String? fighterName;

  static const _fightHistory = [
    ('W', 'Marcus Chen', 'TKO', 'R2 3:42', 'Dec 2025'),
    ('W', 'Jake Rivera', 'Decision', '3 Rounds', 'Oct 2025'),
    ('L', 'Kevin Tan', 'Submission', 'R1 4:15', 'Aug 2025'),
    ('W', 'Ryan Park', 'KO', 'R3 1:08', 'Jun 2025'),
    ('W', 'Tom Harris', 'Decision', '3 Rounds', 'Apr 2025'),
  ];

  @override
  Widget build(BuildContext context) {
    final name = fighterName ?? 'Alex Johnson';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Fighter Profile', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    glow: GlassGlow.purple,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const AvatarWidget(size: 72, initials: 'AJ', glow: true),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      name,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const BadgeWidget(
                                    label: 'PRO',
                                    color: BadgeColor.purple,
                                  ),
                                ],
                              ),
                              Text(
                                'Welterweight · 77 kg',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: subColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '12-3-0 · 8 Finishes',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: const Icon(Icons.emoji_events_rounded),
                          label: 'Wins',
                          value: '12',
                          color: AppColors.green,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatCard(
                          icon: const Icon(Icons.close_rounded),
                          label: 'Losses',
                          value: '3',
                          color: AppColors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatCard(
                          icon: const Icon(Icons.flash_on_rounded),
                          label: 'KOs',
                          value: '5',
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SectionHeader(title: 'Fighter Stats'),
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _StatRow(
                          label: 'Reach',
                          value: '188 cm',
                          textColor: textColor,
                          subColor: subColor,
                        ),
                        _StatRow(
                          label: 'Stance',
                          value: 'Orthodox',
                          textColor: textColor,
                          subColor: subColor,
                        ),
                        _StatRow(
                          label: 'Avg Fight Time',
                          value: '8:24',
                          textColor: textColor,
                          subColor: subColor,
                        ),
                        _StatRow(
                          label: 'Sig. Strikes/min',
                          value: '4.2',
                          textColor: textColor,
                          subColor: subColor,
                        ),
                        _StatRow(
                          label: 'Takedown Acc.',
                          value: '68%',
                          textColor: textColor,
                          subColor: subColor,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  const SectionHeader(title: 'Fight Record'),
                  ..._fightHistory.map(
                    (fight) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _FightCard(
                        result: fight.$1,
                        opponent: fight.$2,
                        method: fight.$3,
                        detail: fight.$4,
                        date: fight.$5,
                        textColor: textColor,
                        subColor: subColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.textColor,
    required this.subColor,
    this.isLast = false,
  });

  final String label;
  final String value;
  final Color textColor;
  final Color subColor;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(fontSize: 13, color: subColor),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FightCard extends StatelessWidget {
  const _FightCard({
    required this.result,
    required this.opponent,
    required this.method,
    required this.detail,
    required this.date,
    required this.textColor,
    required this.subColor,
  });

  final String result;
  final String opponent;
  final String method;
  final String detail;
  final String date;
  final Color textColor;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    final isWin = result == 'W';
    final resultColor = isWin ? AppColors.green : AppColors.red;

    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: resultColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              result,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: resultColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  opponent,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                Text(
                  '$method · $detail',
                  style: GoogleFonts.inter(fontSize: 12, color: subColor),
                ),
              ],
            ),
          ),
          Text(
            date,
            style: GoogleFonts.inter(fontSize: 11, color: subColor),
          ),
        ],
      ),
    );
  }
}
