import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/routing/app_routes.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/input_field.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/authentication/presentation/cubit/auth_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    await context.read<AuthCubit>().forgotPassword(
          email: _emailController.text.trim(),
        );
    if (!mounted) return;
    final state = context.read<AuthCubit>().state;
    if (state.status == AuthStatus.passwordResetSent ||
        state.errorMessage == null) {
      setState(() => _sent = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              const OctaTopBar(title: 'Reset Password', showBack: true),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot your password?',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Enter your email and we'll send you a reset link.",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.gray,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (_sent)
                        GlassCard(
                          glow: GlassGlow.blue,
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.green,
                                size: 28,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Reset link sent! Check your inbox.',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else ...[
                        InputField(
                          label: 'Email',
                          hint: 'you@example.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        if (state.errorMessage != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            state.errorMessage!,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.red,
                            ),
                          ),
                        ],
                        const SizedBox(height: 32),
                        PrimaryButton(
                          label: 'Send Reset Link',
                          isLoading: state.isLoading,
                          onPressed:
                              state.isLoading ? null : _handleReset,
                        ),
                      ],
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () => context.go(AppRoutes.login),
                          child: Text(
                            'Back to Sign In',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blue,
                            ),
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
      },
    );
  }
}
