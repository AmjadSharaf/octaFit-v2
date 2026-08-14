import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';
import 'package:octafitv2/core/widgets/scale_press.dart';


/// Primary CTA button with gradient variants and scale press animation.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = PrimaryButtonVariant.blue,
    this.icon,
    this.isLoading = false,
    this.fullWidth = true,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  final String label;
  final VoidCallback? onPressed;
  final PrimaryButtonVariant variant;
  final Widget? icon;
  final bool isLoading;
  final bool fullWidth;
  final EdgeInsetsGeometry padding;

  bool get _disabled => onPressed == null || isLoading;

  LinearGradient? get _gradient => switch (variant) {
        PrimaryButtonVariant.blue => AppColors.gradBlue,
        PrimaryButtonVariant.purple => AppColors.gradPurple,
        PrimaryButtonVariant.gradient => AppColors.gradBoth,
        PrimaryButtonVariant.glass => null,
      };

  List<BoxShadow> get _shadow => _disabled
      ? const []
      : switch (variant) {
          PrimaryButtonVariant.blue => AppColors.buttonBlueShadow,
          PrimaryButtonVariant.purple => AppColors.buttonPurpleShadow,
          PrimaryButtonVariant.gradient => AppColors.buttonBlueShadow,
          PrimaryButtonVariant.glass => const [],
        };

  @override
  Widget build(BuildContext context) {
    final gradient = _gradient;
    final bgColor = _disabled
        ? AppColors.chipInactive
        : variant == PrimaryButtonVariant.glass
            ? AppColors.chipInactive
            : null;

    final textColor =
        _disabled ? AppColors.dimGray : AppColors.white;

    Widget content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: textColor,
            ),
          ),
          const SizedBox(width: 10),
        ] else if (icon != null) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: textColor,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );

    final button = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: fullWidth ? double.infinity : null,
      padding: padding,
      decoration: BoxDecoration(
        gradient: _disabled ? null : gradient,
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: _shadow,
      ),
      child: content,
    );

    return ScalePressWrapper(
      enabled: !_disabled,
      onTap: _disabled ? null : onPressed,
      child: button,
    );
  }
}
