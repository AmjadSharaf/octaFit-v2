import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/avatar_widget.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/primary_button.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/community/presentation/cubit/community_cubit.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _publish() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<CommunityCubit>().createPost(content: text, mediaUrls: null);
    context.pop();
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
          const OctaTopBar(title: 'Create Post', showBack: true),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const AvatarWidget(size: 44, initials: 'AJ', glow: true),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alex Johnson',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          Text(
                            'Share with the community',
                            style: GoogleFonts.inter(fontSize: 12, color: subColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GlassCard(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        expands: true,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: textColor,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          hintText: 'What did you accomplish today?',
                          hintStyle: GoogleFonts.inter(color: subColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _AttachBtn(icon: Icons.image_rounded, label: 'Photo'),
                      const SizedBox(width: 12),
                      _AttachBtn(icon: Icons.fitness_center_rounded, label: 'Workout'),
                      const SizedBox(width: 12),
                      _AttachBtn(icon: Icons.emoji_events_rounded, label: 'PR'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: 'Publish Post',
                    variant: PrimaryButtonVariant.gradient,
                    onPressed: _publish,
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

class _AttachBtn extends StatelessWidget {
  const _AttachBtn({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subColor = isDark ? AppColors.gray : AppColors.lightGray;

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: 10,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.blue),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: subColor,
            ),
          ),
        ],
      ),
    );
  }
}
