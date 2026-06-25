import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/di/injection.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/notifications/domain/entities/notification_entity.dart';
import 'package:octafit/features/notifications/presentation/cubit/notifications_cubit.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _cubit = getIt<NotificationsCubit>();
  NotificationsState? _state;

  @override
  void initState() {
    super.initState();
    _cubit.stream.listen((s) {
      if (mounted) setState(() => _state = s);
    });
    _cubit.loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Notifications', showBack: true),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final s = _state;
    if (s == null || s.status == NotificationsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (s.notifications.isEmpty) {
      return Center(
        child: Text(
          'No notifications yet',
          style: GoogleFonts.inter(color: AppColors.gray),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: s.notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) =>
          _NotificationTile(notification: s.notifications[index]),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassCard(
      glow: notification.unread ? GlassGlow.blue : GlassGlow.none,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: notification.unread
                  ? AppColors.glassBlue
                  : AppColors.chipInactive,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              notification.icon,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppColors.white : AppColors.lightText,
                        ),
                      ),
                    ),
                    if (notification.unread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.body,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.gray,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notification.time,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.dimGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
