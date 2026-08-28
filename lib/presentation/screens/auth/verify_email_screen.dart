// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:octafit/core/constants/app_colors.dart';
// import 'package:octafit/core/routing/app_routes.dart';
// import 'package:octafit/core/widgets/octa_screen.dart';
// import 'package:octafit/core/widgets/primary_button.dart';

// class VerifyEmailScreen extends StatefulWidget {
//   const VerifyEmailScreen({super.key});

//   @override
//   State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
// }

// class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
//   final _focusNodes = List.generate(6, (_) => FocusNode());
//   final _controllers = List.generate(6, (_) => TextEditingController());
//   Timer? _resendTimer;
//   String _otp = '';
//   int _resendSeconds = 60;

//   @override
//   void initState() {
//     super.initState();
//     _startResendTimer();
//   }

//   void _startResendTimer() {
//     _resendTimer?.cancel();
//     setState(() => _resendSeconds = 60);
//     _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_resendSeconds <= 1) {
//         timer.cancel();
//         setState(() => _resendSeconds = 0);
//       } else {
//         setState(() => _resendSeconds--);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _resendTimer?.cancel();
//     for (final node in _focusNodes) {
//       node.dispose();
//     }
//     for (final controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   void _syncOtp() {
//     setState(() {
//       _otp = _controllers.map((c) => c.text).join();
//     });
//   }

//   void _onDigitChanged(int index, String value) {
//     if (value.length > 1) {
//       _controllers[index].text = value.substring(value.length - 1);
//       _controllers[index].selection = const TextSelection.collapsed(offset: 1);
//     }
//     _syncOtp();
//     if (value.isNotEmpty && index < 5) {
//       _focusNodes[index + 1].requestFocus();
//     }
//     if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final canResend = _resendSeconds == 0;

//     return OctaScreen(
//       showOrbs: true,
//       scrollable: true,
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           Text(
//             'Verify Your Email',
//             style: GoogleFonts.spaceGrotesk(
//               fontSize: 28,
//               fontWeight: FontWeight.w700,
//               color: AppColors.white,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Enter the 6-digit code we sent to your email address.',
//             style: GoogleFonts.inter(fontSize: 14, color: AppColors.gray),
//           ),
//           const SizedBox(height: 40),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(6, (index) {
//               return _OtpBox(
//                 controller: _controllers[index],
//                 focusNode: _focusNodes[index],
//                 onChanged: (value) => _onDigitChanged(index, value),
//               );
//             }),
//           ),
//           const SizedBox(height: 32),
//           Center(
//             child: canResend
//                 ? TextButton(
//                     onPressed: () {
//                       for (final c in _controllers) {
//                         c.clear();
//                       }
//                       setState(() => _otp = '');
//                       _focusNodes.first.requestFocus();
//                       _startResendTimer();
//                     },
//                     child: Text(
//                       'Resend Code',
//                       style: GoogleFonts.inter(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.blue,
//                       ),
//                     ),
//                   )
//                 : Text(
//                     'Resend code in ${_resendSeconds}s',
//                     style: GoogleFonts.inter(
//                       fontSize: 14,
//                       color: AppColors.gray,
//                     ),
//                   ),
//           ),
//           const SizedBox(height: 32),
//           PrimaryButton(
//             label: 'Continue',
//             variant: PrimaryButtonVariant.blue,
//             onPressed: _otp.length == 6
//                 ? () => context.go(AppRoutes.createPassword)
//                 : null,
//           ),
//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
// }

// class _OtpBox extends StatelessWidget {
//   const _OtpBox({
//     required this.controller,
//     required this.focusNode,
//     required this.onChanged,
//   });

//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final ValueChanged<String> onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 48,
//       height: 56,
//       child: TextField(
//         controller: controller,
//         focusNode: focusNode,
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         style: GoogleFonts.spaceGrotesk(
//           fontSize: 22,
//           fontWeight: FontWeight.w700,
//           color: AppColors.white,
//         ),
//         cursorColor: AppColors.blue,
//         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//         decoration: InputDecoration(
//           counterText: '',
//           filled: true,
//           fillColor: AppColors.inputFill,
//           contentPadding: EdgeInsets.zero,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.glassBorder),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.glassBorder),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.blue, width: 2),
//           ),
//         ),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
