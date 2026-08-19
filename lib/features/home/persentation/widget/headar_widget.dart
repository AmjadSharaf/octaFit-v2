import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';
import 'package:octafitv2/core/widgets/avatar_widget.dart';
import 'package:octafitv2/core/widgets/scale_press.dart';
import 'package:octafitv2/features/home/persentation/widget/IconBtn_widget.dart';

class HeadarWidget extends StatelessWidget {
  final String name;
  final String initials;
  final int streak;
  final VoidCallback onSearch;
  final VoidCallback onNotifications;
  final bool loading;
  const HeadarWidget({
    super.key,
    required this.name,
    required this.initials,
    required this.streak,
    required this.onSearch,
    required this.onNotifications,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const SizedBox(height: 56);
    }
    return Row(
      children: [
        AvatarWidget(initials: initials, size: 30, glow: true),
        Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // ← لا يتجاوز الارتفاع
            children: [
              Text(
                'Good morning, $name \u{1F44B}',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
                maxLines: 1, // ← سطر واحد فقط
                overflow: TextOverflow.ellipsis, // ← نقاط (...) إذا طال
                softWrap: false,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.local_fire_department_rounded,
                    size: 14,
                    color: AppColors.orange,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    // ← بدل ما يتجاوز
                    child: Text(
                      '$streak day streak',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.gray,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ScalePressWrapper(
          onTap: onSearch,
          child: const IconbtnWidget(icon: Icons.search_rounded),
        ),
        const SizedBox(width: 8),
        ScalePressWrapper(
          onTap: onNotifications,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const IconbtnWidget(icon: Icons.notifications_outlined),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
