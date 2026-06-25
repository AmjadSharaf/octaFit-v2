import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/input_field.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';

enum PasswordStrength { weak, medium, strong }

PasswordStrength passwordStrength(String password) {
  if (password.length < 6) return PasswordStrength.weak;
  if (password.length < 10) return PasswordStrength.medium;
  return PasswordStrength.strong;
}

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool get _canContinue {
    final password = _passwordController.text;
    final confirm = _confirmController.text;
    return password.length >= 6 && password == confirm;
  }

  @override
  Widget build(BuildContext context) {
    final strength = passwordStrength(_passwordController.text);

    return OctaScreen(
      showOrbs: true,
      scrollable: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'Create Password',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose a strong password to secure your account.',
            style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray),
          ),
          const SizedBox(height: 32),
          InputField(
            label: 'Password',
            hint: '••••••••',
            controller: _passwordController,
            obscureText: _obscurePassword,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.gray,
                size: 20,
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          _StrengthMeter(strength: strength),
          const SizedBox(height: 16),
          InputField(
            label: 'Confirm Password',
            hint: '••••••••',
            controller: _confirmController,
            obscureText: _obscureConfirm,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.gray,
                size: 20,
              ),
              onPressed: () {
                setState(() => _obscureConfirm = !_obscureConfirm);
              },
            ),
            onChanged: (_) => setState(() {}),
          ),
          if (_confirmController.text.isNotEmpty &&
              _passwordController.text != _confirmController.text) ...[
            const SizedBox(height: 8),
            Text(
              'Passwords do not match',
              style: GoogleFonts.inter(fontSize: 13, color: AppColors.red),
            ),
          ],
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Continue',
            variant: PrimaryButtonVariant.gradient,
            onPressed: _canContinue
                ? () => context.go(AppRoutes.assessment1)
                : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _StrengthMeter extends StatelessWidget {
  const _StrengthMeter({required this.strength});

  final PasswordStrength strength;

  @override
  Widget build(BuildContext context) {
    final (label, color, filledBars) = switch (strength) {
      PasswordStrength.weak => ('Weak', AppColors.red, 1),
      PasswordStrength.medium => ('Medium', AppColors.orange, 2),
      PasswordStrength.strong => ('Strong', AppColors.green, 3),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(3, (i) {
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
                decoration: BoxDecoration(
                  color: i < filledBars ? color : AppColors.glassBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

