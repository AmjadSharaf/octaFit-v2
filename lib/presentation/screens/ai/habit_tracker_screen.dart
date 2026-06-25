import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/stat_card.dart';
import 'package:octafit/core/widgets/top_bar.dart';

class HabitTrackerScreen extends StatefulWidget {
  const HabitTrackerScreen({super.key});

  @override
  State<HabitTrackerScreen> createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  final _habits = <({String name, String icon, bool done})>[
    (name: 'Drink 3L water', icon: '💧', done: true),
    (name: '8 hours sleep', icon: '😴', done: true),
    (name: '10k steps', icon: '🚶', done: false),
    (name: 'Stretch 10 min', icon: '🧘', done: true),
    (name: 'Log meals', icon: '🥗', done: false),
  ];

  static const _heatmap = [
    [0.2, 0.6, 1.0, 0.8, 0.4, 0.0, 0.3],
    [0.5, 0.7, 0.9, 1.0, 0.6, 0.2, 0.4],
    [0.8, 1.0, 0.6, 0.9, 0.7, 0.5, 0.8],
    [1.0, 0.8, 0.7, 0.5, 0.9, 0.6, 1.0],
  ];

  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  void _toggleHabit(int index) {
    setState(() {
      final h = _habits[index];
      _habits[index] = (name: h.name, icon: h.icon, done: !h.done);
    });
  }

  int get _streak => 12;
  int get _completedToday => _habits.where((h) => h.done).length;

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
          const OctaTopBar(title: 'Habit Tracker', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: const Icon(Icons.local_fire_department_rounded),
                          label: 'Current Streak',
                          value: '$_streak',
                          unit: ' days',
                          color: AppColors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: const Icon(Icons.check_circle_outline_rounded),
                          label: 'Today',
                          value: '$_completedToday',
                          unit: '/ ${_habits.length}',
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                  const SectionHeader(title: 'Daily Habits'),
                  ...List.generate(_habits.length, (index) {
                    final habit = _habits[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassCard(
                        onTap: () => _toggleHabit(index),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Text(habit.icon, style: const TextStyle(fontSize: 24)),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                habit.name,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: habit.done ? subColor : textColor,
                                  decoration: habit.done ? TextDecoration.lineThrough : null,
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                gradient: habit.done ? AppColors.gradGreenCyan : null,
                                color: habit.done ? null : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: habit.done ? Colors.transparent : AppColors.glassBorder,
                                ),
                              ),
                              child: habit.done
                                  ? const Icon(Icons.check_rounded, color: AppColors.bg, size: 18)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SectionHeader(title: 'Weekly Heatmap'),
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _dayLabels
                              .map(
                                (d) => Text(
                                  d,
                                  style: GoogleFonts.inter(fontSize: 11, color: subColor),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 10),
                        ..._heatmap.map(
                          (week) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: week.map((intensity) {
                                return Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: intensity == 0
                                        ? (isDark ? AppColors.chipInactive : AppColors.lightInputFill)
                                        : AppColors.green.withValues(alpha: 0.2 + intensity * 0.8),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Darker = more habits completed',
                          style: GoogleFonts.inter(fontSize: 11, color: subColor),
                        ),
                      ],
                    ),
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
