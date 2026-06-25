import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';

enum _TrackingStatus { completed, active, pending }

class _TrackingStep {
  const _TrackingStep({
    required this.title,
    required this.subtitle,
    required this.status,
    this.date,
  });

  final String title;
  final String subtitle;
  final _TrackingStatus status;
  final String? date;
}

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key, this.orderId});

  final String? orderId;

  static const _steps = [
    _TrackingStep(
      title: 'Order Placed',
      subtitle: 'Your order has been confirmed',
      status: _TrackingStatus.completed,
      date: 'Jun 10, 2026',
    ),
    _TrackingStep(
      title: 'Processing',
      subtitle: 'Items are being prepared',
      status: _TrackingStatus.completed,
      date: 'Jun 10, 2026',
    ),
    _TrackingStep(
      title: 'Shipped',
      subtitle: 'Package left the warehouse',
      status: _TrackingStatus.completed,
      date: 'Jun 11, 2026',
    ),
    _TrackingStep(
      title: 'Out for Delivery',
      subtitle: 'Arriving today by 8 PM',
      status: _TrackingStatus.active,
      date: 'Jun 12, 2026',
    ),
    _TrackingStep(
      title: 'Delivered',
      subtitle: 'Package delivered to your door',
      status: _TrackingStatus.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final displayOrderId = orderId ?? 'OCT-48291';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Track Order', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    glow: GlassGlow.blue,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order #$displayOrderId',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Whey Protein Pro · Pre-Workout X5',
                          style: GoogleFonts.inter(fontSize: 13, color: subColor),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.local_shipping_rounded,
                              color: AppColors.blue,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Estimated delivery: Today by 8 PM',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SectionHeader(title: 'Delivery Timeline'),
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: _steps.asMap().entries.map((entry) {
                        final index = entry.key;
                        final step = entry.value;
                        final isLast = index == _steps.length - 1;
                        return _TimelineStep(
                          step: step,
                          isLast: isLast,
                          textColor: textColor,
                          subColor: subColor,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipping Address',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Alex Johnson\n42 Fitness Ave, Apt 12\nSan Francisco, CA 94102',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: subColor,
                            height: 1.5,
                          ),
                        ),
                      ],
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

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.step,
    required this.isLast,
    required this.textColor,
    required this.subColor,
  });

  final _TrackingStep step;
  final bool isLast;
  final Color textColor;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (step.status) {
      _TrackingStatus.completed => (
          Icons.check_circle_rounded,
          AppColors.green,
        ),
      _TrackingStatus.active => (
          Icons.local_shipping_rounded,
          AppColors.blue,
        ),
      _TrackingStatus.pending => (
          Icons.radio_button_unchecked_rounded,
          AppColors.dimGray,
        ),
    };

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(icon, color: color, size: 24),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: step.status == _TrackingStatus.completed
                        ? AppColors.green.withValues(alpha: 0.4)
                        : AppColors.glassBorder,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: step.status == _TrackingStatus.pending
                          ? subColor
                          : textColor,
                    ),
                  ),
                  Text(
                    step.subtitle,
                    style: GoogleFonts.inter(fontSize: 12, color: subColor),
                  ),
                  if (step.date != null)
                    Text(
                      step.date!,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.dimGray,
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
