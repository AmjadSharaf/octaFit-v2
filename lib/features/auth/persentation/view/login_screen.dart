import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';
import 'package:octafitv2/core/routing/app_routers.dart';
import 'package:octafitv2/core/widgets/octa_screen.dart';
import 'package:octafitv2/shared/custom_button.dart';
import 'package:octafitv2/shared/custom_text.dart';
import 'package:octafitv2/shared/custom_txtfield.dart';

import '../../../../core/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OctaScreen(
      body: Column(
        children: [
          CustomText(text: "Welcome Back"),
          Gap(16),
          CustomText(text: "Sign in to continue your fitness journey"),
          Gap(32),
          CustomTxtfield(
            hint: "you@example.com",
            isPassword: false,
            controller: _emailController,
            iconperfex: Icon(Icons.email_outlined),
            lable: "Email",
          ),
          Gap(16),
          CustomTxtfield(
            hint: "**********",
            isPassword: true,
            controller: _passwordController,
            iconperfex: Icon(Icons.email_outlined),
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
              onPressed: () => context.go(AppRouters.signup),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray),
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
  }
}
