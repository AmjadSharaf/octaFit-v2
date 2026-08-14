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
import 'package:octafitv2/shared/custom_text.dart';
import 'package:octafitv2/shared/custom_txtfield.dart';

import '../../../../shared/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose;
    _emailController.dispose;
    _passwordController.dispose;
    _password2Controller.dispose;
    _phoneController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OctaScreen(
      showOrbs: true,
      scrollable: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Gap(15),
              CustomText(text: "Create Account"),
              Gap(8),
              CustomText(text: "Join OctaFit and start your transformation"),
              Gap(32),
              CustomTxtfield(
                hint: "Full Name ",
                lable: "Full Name ",
                isPassword: false,
                controller: _nameController,
                iconperfex: const Icon(Icons.person_outline_rounded),
              ),
              Gap(16),
              CustomTxtfield(
                hint: "you@example.com",
                isPassword: false,
                lable: "Email",
                controller: _emailController,
                iconperfex: const Icon(Icons.email_outlined),
              ),
              Gap(16),
              CustomTxtfield(
                hint: "09xxxxxxxx",
                isPassword: false,
                controller: _phoneController,
                iconperfex: const Icon(Icons.phone),
                lable: "N",
              ),
              Gap(16),
              CustomTxtfield(
                hint: "***********",
                isPassword: true,
                controller: _passwordController,
                iconperfex: Icon(Icons.password),
                lable: "password",
              ),
              Gap(16),
              CustomTxtfield(
                hint: "***********",
                isPassword: true,
                controller: _password2Controller,
                iconperfex: Icon(Icons.password),
                lable: "password",
              ),
              Gap(32),
              CustomButton(
                text: "Create Account",
                onTap: () => context.go(AppRouters.welcome),
                color: AppColors.chipInactive,
              ),
              Gap(16),
              Center(
                child: TextButton(
                  onPressed: () => context.go(AppRouters.login),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.gray,
                      ),
                      children: const [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Sign In',
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
          );
        },
      ),
    );
  }
}
