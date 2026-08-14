import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';


/// Styled text input — matches OctaUI InputField.
class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.maxLines = 1,
    this.enabled = true,
    this.textInputAction,
    this.onSubmitted,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final _focusNode = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() => _focused = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final labelColor = isDark ? AppColors.gray : AppColors.lightGray;
    final fillColor = isDark ? AppColors.inputFill : AppColors.lightInputFill;
    final borderColor = _focused
        ? AppColors.blue
        : (isDark ? AppColors.glassBorder : AppColors.lightBorder);
    final textColor = isDark ? AppColors.white : AppColors.lightText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: labelColor,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onSubmitted,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: textColor,
          ),
          cursorColor: AppColors.blue,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 15,
              color: labelColor,
            ),
            filled: true,
            fillColor: fillColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: widget.prefixIcon != null ? 48 : 16,
              vertical: 14,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: IconTheme(
                      data: IconThemeData(color: labelColor, size: 20),
                      child: widget.prefixIcon!,
                    ),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 0),
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.blue),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: borderColor.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
