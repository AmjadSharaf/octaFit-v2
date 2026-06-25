import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/settings/presentation/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;
        final textColor = isDark ? AppColors.white : AppColors.lightText;
        final subColor = isDark ? AppColors.gray : AppColors.lightGray;

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              const OctaTopBar(title: 'Settings', showBack: true),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  children: [
                    _SectionLabel('Appearance'),
                    GlassCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Dark Mode',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        subtitle: Text(
                          isDark
                              ? 'Dark theme enabled'
                              : 'Light theme enabled',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: subColor,
                          ),
                        ),
                        secondary: Icon(
                          isDark
                              ? Icons.dark_mode_rounded
                              : Icons.light_mode_rounded,
                          color: AppColors.blue,
                        ),
                        value: isDark,
                        activeThumbColor: AppColors.blue,
                        onChanged: (_) =>
                            context.read<SettingsCubit>().toggleTheme(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _SectionLabel('Account'),
                    _SettingsTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Edit Profile',
                      subColor: subColor,
                      textColor: textColor,
                      onTap: () => context.push(AppRoutes.editProfile),
                    ),
                    _SettingsTile(
                      icon: Icons.star_outline_rounded,
                      title: 'Membership',
                      subColor: subColor,
                      textColor: textColor,
                      onTap: () => context.push(AppRoutes.membership),
                    ),
                    _SettingsTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subColor: subColor,
                      textColor: textColor,
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    _SectionLabel('Support'),
                    _SettingsTile(
                      icon: Icons.help_outline_rounded,
                      title: 'Help Center',
                      subColor: subColor,
                      textColor: textColor,
                      onTap: () {},
                    ),
                    _SettingsTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      subColor: subColor,
                      textColor: textColor,
                      onTap: () {},
                    ),
                    _SettingsTile(
                      icon: Icons.logout_rounded,
                      title: 'Sign Out',
                      subColor: AppColors.red,
                      textColor: AppColors.red,
                      onTap: () => context.go(AppRoutes.login),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: isDark ? AppColors.gray : AppColors.lightGray,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.textColor,
    required this.subColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color textColor;
  final Color subColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor == AppColors.red
                  ? AppColors.red
                  : AppColors.blue,
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: subColor, size: 22),
          ],
        ),
      ),
    );
  }
}
