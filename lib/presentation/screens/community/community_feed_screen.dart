import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octafit/core/constants/app_colors.dart';
import 'package:octafit/core/widgets/avatar_widget.dart';
import 'package:octafit/core/widgets/bottom_nav_bar.dart';
import 'package:octafit/core/widgets/glass_card.dart';
import 'package:octafit/core/widgets/octa_screen.dart';
import 'package:octafit/core/widgets/section_header.dart';
import 'package:octafit/core/widgets/top_bar.dart';
import 'package:octafit/features/community/domain/entities/post_entity.dart';
import 'package:octafit/features/community/presentation/cubit/community_cubit.dart';

const _stories = ['You', 'Marcus', 'Sarah', 'Jake', 'Lisa', 'Kevin'];

class CommunityFeedScreen extends StatelessWidget {
  const CommunityFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        if (state.status == CommunityStatus.initial) {
          context.read<CommunityCubit>().loadPosts();
        }

        final posts = state.posts;

        return OctaScreen(
          showOrbs: true,
          safeArea: false,
          body: Column(
            children: [
              OctaTopBar(
                title: 'Community',
                trailing: const Icon(Icons.add_circle_outline_rounded),
                onTrailingTap: () => context.push(AppRoutes.createPost),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _stories.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 14),
                          itemBuilder: (context, index) {
                            final name = _stories[index];
                            final isYou = name == 'You';
                            return Column(
                              children: [
                                AvatarWidget(
                                  size: 56,
                                  initials: name.substring(0, isYou ? 1 : 2),
                                  glow: isYou,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  name,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: isYou
                                        ? AppColors.blue
                                        : AppColors.gray,
                                    fontWeight: isYou
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SectionHeader(
                        title: 'Feed',
                        actionLabel: 'Leaderboard',
                        onAction: () =>
                            context.push(AppRoutes.leaderboard),
                      ),
                      ...posts.map(
                        (post) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _PostCard(
                            post: post,
                            onLike: () => context
                                .read<CommunityCubit>()
                                .toggleLike(post.id),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.post,
    required this.onLike,
  });

  final PostEntity post;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarWidget(size: 40, initials: post.userAvatar),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userName,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      post.time,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
              Text(post.icon ?? '', style: const TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post.content,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.white,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              GestureDetector(
                onTap: onLike,
                child: Row(
                  children: [
                    Icon(
                      post.isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 20,
                      color: post.isLiked ? AppColors.red : AppColors.gray,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${post.likes}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: post.isLiked ? AppColors.red : AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Icon(
                Icons.chat_bubble_outline_rounded,
                size: 20,
                color: AppColors.gray,
              ),
              const SizedBox(width: 6),
              Text(
                '${post.comments}',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
