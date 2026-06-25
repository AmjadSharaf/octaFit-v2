import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/avatar_widget.dart';
import 'package:octafit/core/widgets/input_field.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _bioCtrl;
  late final TextEditingController _goalCtrl;
  late final TextEditingController _ageCtrl;
  late final TextEditingController _weightCtrl;
  late final TextEditingController _heightCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: 'Alex Johnson');
    _usernameCtrl = TextEditingController(text: 'alex_octafit');
    _bioCtrl = TextEditingController(
      text: 'Building the best version of myself with OctaFit',
    );
    _goalCtrl = TextEditingController(text: 'Build Muscle');
    _ageCtrl = TextEditingController(text: '28');
    _weightCtrl = TextEditingController(text: '82');
    _heightCtrl = TextEditingController(text: '178');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _bioCtrl.dispose();
    _goalCtrl.dispose();
    _ageCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Edit Profile', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                children: [
                  const Center(
                    child: AvatarWidget(size: 88, initials: 'AJ', glow: true),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Change Photo',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputField(label: 'Full Name', controller: _nameCtrl),
                  const SizedBox(height: 16),
                  InputField(label: 'Username', controller: _usernameCtrl),
                  const SizedBox(height: 16),
                  InputField(
                    label: 'Bio',
                    controller: _bioCtrl,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  InputField(label: 'Fitness Goal', controller: _goalCtrl),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          label: 'Age',
                          controller: _ageCtrl,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InputField(
                          label: 'Weight (kg)',
                          controller: _weightCtrl,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InputField(
                          label: 'Height (cm)',
                          controller: _heightCtrl,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Save Changes',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Profile updated',
                            style: GoogleFonts.inter(color: textColor),
                          ),
                        ),
                      );
                      context.pop();
                    },
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
