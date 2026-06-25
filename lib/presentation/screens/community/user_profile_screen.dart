import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/avatar_widget.dart';
import 'package:octafit/core/widgets/badge_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/stat_card.dart';
import 'package:octafit/core/widgets/top_bar.dart';
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, this.username});

  final String? username;

  static const _userPosts = [
    ('🏋️', 'New deadlift PR — 200kg!', '142'),
    ('💪', 'Week 6 hypertrophy complete', '89'),
    ('🔥', '14-day streak milestone', '54'),
    ('🥊', 'MMA sparring session done', '67'),
    ('🏃', '10K run in 48 minutes', '43'),
    ('💯', '100 pushup challenge done', '201'),
  ];

  @override
  Widget build(BuildContext context) {
    final displayName = username ?? 'Marcus Chen';
    final initials = displayName
        .split(' ')
        .map((w) => w.isNotEmpty ? w[0] : '')
        .take(2)
        .join()
        .toUpperCase();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;
    final isMe = displayName == 'Alex Johnson';

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Profile', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AvatarWidget(size: 72, initials: initials, glow: isMe),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    displayName,
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
                              '@${displayName.toLowerCase().replaceAll(' ', '_')}',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: subColor,
                              ),
                            ),
                            Text(
                              'Build Muscle · Advanced',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: const Icon(Icons.fitness_center_rounded),
                          label: 'Workouts',
                          value: '186',
                          color: AppColors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatCard(
                          icon: const Icon(Icons.people_rounded),
                          label: 'Followers',
                          value: '2.4k',
                          color: AppColors.purple,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatCard(
                          icon: const Icon(Icons.favorite_rounded),
                          label: 'Likes',
                          value: '8.2k',
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                  if (!isMe) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            label: 'Follow',
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: PrimaryButton(
                            label: 'Message',
                            variant: PrimaryButtonVariant.glass,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SectionHeader(title: 'Posts'),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: _userPosts.length,
                    itemBuilder: (context, index) {
                      final post = _userPosts[index];
                      return GlassCard(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.$1,
                              style: const TextStyle(fontSize: 28),
                            ),
                            const Spacer(),
                            Text(
                              post.$2,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: textColor,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.favorite_rounded,
                                  size: 14,
                                  color: AppColors.red,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  post.$3,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: subColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
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
