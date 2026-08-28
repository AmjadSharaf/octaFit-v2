// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:octafit/core/constants/app_colors.dart';
// import 'package:octafit/core/widgets/badge_widget.dart';
// import 'package:octafit/core/widgets/glass_card.dart';
// import 'package:octafit/core/widgets/octa_screen.dart';
// import 'package:octafit/core/widgets/progress_ring.dart';
// import 'package:octafit/core/widgets/section_header.dart';
// import 'package:octafit/core/widgets/top_bar.dart';

// class NutritionScreen extends StatefulWidget {
//   const NutritionScreen({super.key});

//   @override
//   State<NutritionScreen> createState() => _NutritionScreenState();
// }

// class _NutritionScreenState extends State<NutritionScreen> {
//   static const _calorieTarget = 2400;
//   static const _caloriesConsumed = 1680;

//   static const _macros = [
//     (name: 'Protein', current: 142, target: 195, color: AppColors.blue),
//     (name: 'Carbs', current: 180, target: 260, color: AppColors.purple),
//     (name: 'Fat', current: 52, target: 70, color: AppColors.orange),
//   ];

//   final _meals = <({String name, String time, int calories, String items})>[
//     (name: 'Breakfast', time: '7:30 AM', calories: 520, items: 'Oats, eggs, banana'),
//     (name: 'Lunch', time: '12:45 PM', calories: 680, items: 'Chicken bowl, rice, greens'),
//     (name: 'Snack', time: '3:30 PM', calories: 280, items: 'Greek yogurt, almonds'),
//     (name: 'Pre-Workout', time: '5:00 PM', calories: 200, items: 'Rice cakes, whey shake'),
//   ];

//   void _logMeal() {
//     setState(() {
//       _meals.add((
//         name: 'Logged Meal',
//         time: 'Just now',
//         calories: 350,
//         items: 'Custom entry — tap to edit',
//       ));
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Meal logged', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
//         backgroundColor: AppColors.bg3,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final textColor = isDark ? AppColors.white : AppColors.lightText;
//     final subColor = isDark ? AppColors.gray : AppColors.lightGray;
//     final calorieProgress = (_caloriesConsumed / _calorieTarget * 100).clamp(0.0, 100.0);

//     return OctaScreen(
//       showOrbs: true,
//       safeArea: false,
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _logMeal,
//         backgroundColor: AppColors.blue,
//         icon: const Icon(Icons.add_rounded, color: AppColors.white),
//         label: Text(
//           'Log Meal',
//           style: GoogleFonts.spaceGrotesk(
//             fontWeight: FontWeight.w700,
//             color: AppColors.white,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           const OctaTopBar(title: 'Nutrition', showBack: true),
//           Expanded(
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.fromLTRB(20, 0, 20, 88),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GlassCard(
//                     glow: GlassGlow.blue,
//                     padding: const EdgeInsets.all(24),
//                     child: Row(
//                       children: [
//                         ProgressRing(
//                           value: calorieProgress,
//                           size: 110,
//                           strokeWidth: 8,
//                           color: AppColors.green,
//                           center: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 '$_caloriesConsumed',
//                                 style: GoogleFonts.spaceGrotesk(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w700,
//                                   color: textColor,
//                                 ),
//                               ),
//                               Text(
//                                 '/ $_calorieTarget kcal',
//                                 style: GoogleFonts.inter(fontSize: 11, color: subColor),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 20),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Calories Today',
//                                 style: GoogleFonts.spaceGrotesk(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w700,
//                                   color: textColor,
//                                 ),
//                               ),
//                               const SizedBox(height: 6),
//                               Text(
//                                 '${_calorieTarget - _caloriesConsumed} kcal remaining',
//                                 style: GoogleFonts.inter(fontSize: 13, color: subColor),
//                               ),
//                               const SizedBox(height: 8),
//                               const BadgeWidget(label: 'Hypertrophy Phase', color: BadgeColor.purple),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SectionHeader(title: 'Macros'),
//                   ..._macros.map(
//                     (macro) => Padding(
//                       padding: const EdgeInsets.only(bottom: 12),
//                       child: _MacroBar(
//                         name: macro.name,
//                         current: macro.current,
//                         target: macro.target,
//                         color: macro.color,
//                         textColor: textColor,
//                         subColor: subColor,
//                       ),
//                     ),
//                   ),
//                   const SectionHeader(title: 'Meals'),
//                   ..._meals.map(
//                     (meal) => Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: GlassCard(
//                         padding: const EdgeInsets.all(16),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 44,
//                               height: 44,
//                               decoration: BoxDecoration(
//                                 color: AppColors.blue.withValues(alpha: 0.15),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: const Icon(Icons.restaurant_rounded, color: AppColors.blue, size: 22),
//                             ),
//                             const SizedBox(width: 14),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     meal.name,
//                                     style: GoogleFonts.spaceGrotesk(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w700,
//                                       color: textColor,
//                                     ),
//                                   ),
//                                   Text(
//                                     '${meal.time} · ${meal.items}',
//                                     style: GoogleFonts.inter(fontSize: 12, color: subColor),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Text(
//                               '${meal.calories}',
//                               style: GoogleFonts.spaceGrotesk(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: textColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _MacroBar extends StatelessWidget {
//   const _MacroBar({
//     required this.name,
//     required this.current,
//     required this.target,
//     required this.color,
//     required this.textColor,
//     required this.subColor,
//   });

//   final String name;
//   final int current;
//   final int target;
//   final Color color;
//   final Color textColor;
//   final Color subColor;

//   @override
//   Widget build(BuildContext context) {
//     final progress = (current / target).clamp(0.0, 1.0);

//     return GlassCard(
//       padding: const EdgeInsets.all(14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 name,
//                 style: GoogleFonts.spaceGrotesk(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: textColor,
//                 ),
//               ),
//               const Spacer(),
//               Text(
//                 '$current / ${target}g',
//                 style: GoogleFonts.inter(fontSize: 12, color: subColor),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: LinearProgressIndicator(
//               value: progress,
//               minHeight: 8,
//               backgroundColor: color.withValues(alpha: 0.15),
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Soon")),
    );
  }
}
