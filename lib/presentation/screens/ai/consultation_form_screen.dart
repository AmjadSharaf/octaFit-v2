import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class ConsultationFormScreen extends StatefulWidget {
  const ConsultationFormScreen({super.key});

  @override
  State<ConsultationFormScreen> createState() => _ConsultationFormScreenState();
}

class _ConsultationFormScreenState extends State<ConsultationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _symptomsController = TextEditingController();
  final _historyController = TextEditingController();
  String _urgency = 'Routine';
  bool _submitted = false;

  static const _urgencyOptions = ['Routine', 'Soon', 'Urgent'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _symptomsController.dispose();
    _historyController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitted = true);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bg3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Request Submitted',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        content: Text(
          'A licensed physiotherapist will review your case within 24 hours. You\'ll receive a notification when your consultation is ready.',
          style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Got it',
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w700,
                color: AppColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.lightText;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return OctaScreen(
      showOrbs: true,
      safeArea: false,
      body: Column(
        children: [
          const OctaTopBar(title: 'Consultation Request', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlassCard(
                      glow: GlassGlow.purple,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Request a virtual consultation with a licensed physiotherapist.',
                        style: GoogleFonts.inter(fontSize: 13, color: subColor, height: 1.4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _FormField(
                      label: 'Full Name',
                      controller: _nameController,
                      hint: 'Alex Johnson',
                      textColor: textColor,
                      subColor: subColor,
                      validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 14),
                    _FormField(
                      label: 'Email',
                      controller: _emailController,
                      hint: 'alex@email.com',
                      keyboardType: TextInputType.emailAddress,
                      textColor: textColor,
                      subColor: subColor,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Required';
                        if (!v.contains('@')) return 'Invalid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Urgency',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: _urgencyOptions.map((option) {
                        final selected = _urgency == option;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: option != _urgencyOptions.last ? 8 : 0,
                            ),
                            child: GestureDetector(
                              onTap: () => setState(() => _urgency = option),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  gradient: selected ? AppColors.gradPurple : null,
                                  color: selected ? null : (isDark ? AppColors.chipInactive : AppColors.lightInputFill),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  option,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: selected ? AppColors.white : subColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),
                    _FormField(
                      label: 'Current Symptoms',
                      controller: _symptomsController,
                      hint: 'Describe pain, location, and triggers...',
                      textColor: textColor,
                      subColor: subColor,
                      maxLines: 3,
                      validator: (v) => v == null || v.trim().length < 10 ? 'Please describe symptoms' : null,
                    ),
                    const SizedBox(height: 14),
                    _FormField(
                      label: 'Injury History',
                      controller: _historyController,
                      hint: 'Past injuries, surgeries, or conditions...',
                      textColor: textColor,
                      subColor: subColor,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: _submitted ? 'Submitted' : 'Submit Request',
                      variant: PrimaryButtonVariant.purple,
                      icon: Icon(
                        _submitted ? Icons.check_rounded : Icons.send_rounded,
                        color: AppColors.white,
                        size: 20,
                      ),
                      onPressed: _submitted ? null : _submit,
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

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.controller,
    required this.hint,
    required this.textColor,
    required this.subColor,
    this.validator,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final Color textColor;
  final Color subColor;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        GlassCard(
          borderRadius: 12,
          padding: EdgeInsets.zero,
          child: TextFormField(
            controller: controller,
            validator: validator,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(fontSize: 14, color: textColor),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(fontSize: 14, color: subColor),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: InputBorder.none,
              filled: true,
              fillColor: isDark ? AppColors.inputFill : AppColors.lightInputFill,
            ),
          ),
        ),
      ],
    );
  }
}
