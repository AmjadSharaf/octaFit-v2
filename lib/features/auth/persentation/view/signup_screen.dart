import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafitv2/core/constants/app_colors.dart';
import 'package:octafitv2/core/routing/app_routers.dart';
import 'package:octafitv2/core/widgets/octa_screen.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onRegister() {
    // Basic validation since CustomTxtfield doesn't expose a validator param
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الاسم مطلوب', style: TextStyle(color: Colors.white)),
        ),
      );
      return;
    }
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('البريد مطلوب', style: TextStyle(color: Colors.white)),
        ),
      );
      return;
    }
    if (!_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('بريد غير صالح', style: TextStyle(color: Colors.white)),
        ),
      );
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرقم مطلوب', style: TextStyle(color: Colors.white)),
        ),
      );
      return;
    }
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'كلمة المرور مطلوبة',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '6 أحرف على الأقل',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    if (_passwordController.text != _password2Controller.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'كلمتا المرور غير متطابقتين',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    context.read<AuthCubit>().register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
      passwordConfirmation: _password2Controller.text,
    );
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
            context.go(AppRouters.home);
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
                const Gap(15),
                const CustomText(text: "Create Account"),
                const Gap(8),
                const CustomText(
                  text: "Join OctaFit and start your transformation",
                ),
                const Gap(32),
                CustomTxtfield(
                  hint: "Full Name",
                  lable: "Full Name",
                  isPassword: false,
                  controller: _nameController,
                  iconperfex: const Icon(Icons.person_outline_rounded),
                ),
                const Gap(16),
                CustomTxtfield(
                  hint: "you@example.com",
                  isPassword: false,
                  lable: "Email",
                  controller: _emailController,
                  iconperfex: const Icon(Icons.email_outlined),
                ),
                const Gap(16),
                CustomTxtfield(
                  hint: "09xxxxxxxx",
                  isPassword: false,
                  controller: _phoneController,
                  iconperfex: const Icon(Icons.phone),
                  lable: "Phone Number",
                ),
                const Gap(16),
                CustomTxtfield(
                  hint: "***********",
                  isPassword: true,
                  controller: _passwordController,
                  iconperfex: const Icon(Icons.password),
                  lable: "Password",
                ),
                const Gap(16),
                CustomTxtfield(
                  hint: "***********",
                  isPassword: true,
                  controller: _password2Controller,
                  iconperfex: const Icon(Icons.password),
                  lable: "Confirm Password",
                  // confirmation validation handled on submit
                ),
                const Gap(32),
                CustomButton(
                  text: "Create Account",
                  onTap: _onRegister,
                  color: AppColors.chipInactive,
                ),
                const Gap(16),
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
            ),
          );
        },
      ),
    );
  }
}
