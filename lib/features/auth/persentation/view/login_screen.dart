import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';
import 'package:octafitv2/core/routing/app_routers.dart';
import 'package:octafitv2/core/widgets/octa_screen.dart';
import 'package:octafitv2/core/widgets/primary_button.dart';
import 'package:octafitv2/features/auth/persentation/manegar/auth_cubit.dart';
import 'package:octafitv2/features/auth/persentation/manegar/auth_state.dart';
import 'package:octafitv2/shared/custom_button.dart';
import 'package:octafitv2/shared/custom_text.dart';
import 'package:octafitv2/shared/custom_txtfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().login(
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OctaScreen(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthAuthenticated) {
            context.go(AppRouters.welcome);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Form(
            key: _formKey,
            child: Column(
              children: [
                const CustomText(text: "Welcome Back"),
                const Gap(16),
                const CustomText(
                  text: "Sign in to continue your fitness journey",
                ),
                const Gap(32),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'you@example.com',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'البريد مطلوب';
                    if (!v.contains('@')) return 'بريد غير صالح';
                    return null;
                  },
                ),
                const Gap(16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: '**********',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'كلمة المرور مطلوبة';
                    if (v.length < 6) return '6 أحرف على الأقل';
                    return null;
                  },
                ),
                const Gap(32),
                CustomButton(
                  text: "Sign In", // ✅ تعديل النص
                  onTap: _onLogin, // ✅ الربط بالـ Cubit
                  color: AppColors.chipInactive,
                ),
                const Gap(16),
                Center(
                  child: TextButton(
                    onPressed: () => context.go(AppRouters.signup),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.gray,
                        ),
                        children: const [
                          TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
