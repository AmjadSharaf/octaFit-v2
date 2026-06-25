import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/community/domain/entities/post_entity.dart';
import 'package:octafit/features/community/domain/repositories/community_repository.dart';

part 'community_state.dart';

const _defaultAchievements = <AchievementEntry>[
  AchievementEntry(id: 'a1', title: 'Iron Warrior', description: 'Complete 100 workouts', icon: '\u{1F3C6}', unlocked: true, progress: 100),
  AchievementEntry(id: 'a2', title: 'Streak Master', description: '14-day workout streak', icon: '\u{1F525}', unlocked: true, progress: 100),
  AchievementEntry(id: 'a3', title: 'PR Hunter', description: 'Set 20 personal records', icon: '\u{1F4C8}', unlocked: true, progress: 100),
  AchievementEntry(id: 'a4', title: 'Community Star', description: 'Get 1000 likes on posts', icon: '\u2B50', unlocked: false, progress: 67),
  AchievementEntry(id: 'a5', title: 'AI Pioneer', description: 'Use AI Coach 50 times', icon: '\u{1F916}', unlocked: false, progress: 84),
  AchievementEntry(id: 'a6', title: 'Marathon Ready', description: 'Run 42km total', icon: '\u{1F3C3}', unlocked: false, progress: 45),
];

const _defaultChallenges = <ChallengeEntry>[
  ChallengeEntry(id: 'c1', title: '100 Pushup Challenge', participants: 2847, daysLeft: 5, icon: '\u{1F4AA}', joined: true),
  ChallengeEntry(id: 'c2', title: '30-Day Plank', participants: 1923, daysLeft: 12, icon: '\u{1F9D8}', joined: false),
  ChallengeEntry(id: 'c3', title: 'Squat Every Day', participants: 3456, daysLeft: 8, icon: '\u{1F3CB}', joined: true),
  ChallengeEntry(id: 'c4', title: '10K Steps Daily', participants: 5621, daysLeft: 20, icon: '\u{1F45F}', joined: false),
];

const _defaultLeaderboard = <LeaderboardEntry>[
  LeaderboardEntry(rank: 1, name: 'Marcus Chen', initials: 'MC', points: 12450, badge: '\u{1F947}'),
  LeaderboardEntry(rank: 2, name: 'Sarah Kim', initials: 'SK', points: 11200, badge: '\u{1F948}'),
  LeaderboardEntry(rank: 3, name: 'Alex Johnson', initials: 'AJ', points: 9870, badge: '\u{1F949}', isMe: true),
  LeaderboardEntry(rank: 4, name: 'Jake Rivera', initials: 'JR', points: 8900),
  LeaderboardEntry(rank: 5, name: 'Lisa Martinez', initials: 'LM', points: 7650),
];

class AchievementEntry extends Equatable {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool unlocked;
  final int progress;
  const AchievementEntry({required this.id, required this.title, required this.description, required this.icon, required this.unlocked, required this.progress});
  @override List<Object?> get props => [id, title, description, icon, unlocked, progress];
}

class ChallengeEntry extends Equatable {
  final String id;
  final String title;
  final int participants;
  final int daysLeft;
  final String icon;
  final bool joined;
  const ChallengeEntry({required this.id, required this.title, required this.participants, required this.daysLeft, required this.icon, required this.joined});
  ChallengeEntry copyWith({bool? joined, int? participants}) => ChallengeEntry(id: id, title: title, participants: participants ?? this.participants, daysLeft: daysLeft, icon: icon, joined: joined ?? this.joined);
  @override List<Object?> get props => [id, title, participants, daysLeft, icon, joined];
}

class LeaderboardEntry extends Equatable {
  final int rank;
  final String name;
  final String initials;
  final int points;
  final String badge;
  final bool isMe;
  const LeaderboardEntry({required this.rank, required this.name, required this.initials, required this.points, this.badge = '', this.isMe = false});
  @override List<Object?> get props => [rank, name, initials, points, badge, isMe];
}

class CommunityCubit extends Cubit<CommunityState> {
  final CommunityRepository _repository;

  CommunityCubit({required CommunityRepository repository})
      : _repository = repository,
        super(const CommunityState());

  Future<void> loadPosts() async {
    emit(state.copyWith(status: CommunityStatus.loading));
    final result = await _repository.getPosts(page: state.page);
    if (result is Left<Failure, List<PostEntity>>) {
      emit(state.copyWith(
        status: CommunityStatus.error,
        errorMessage: result.value.message,
      ));
    } else if (result is Right<Failure, List<PostEntity>>) {
      emit(state.copyWith(
        status: CommunityStatus.loaded,
        posts: result.value,
      ));
    }
  }

  Future<void> refreshPosts() async {
    emit(state.copyWith(status: CommunityStatus.refreshing));
    await loadPosts();
  }

  Future<void> loadMorePosts() async {
    if (!state.hasMore || state.isLoading) return;
    emit(state.copyWith(page: state.page + 1));
    final result = await _repository.getPosts(page: state.page);
    if (result is Right<Failure, List<PostEntity>>) {
      emit(state.copyWith(
        status: CommunityStatus.loaded,
        posts: [...state.posts, ...result.value],
      ));
    }
  }

  Future<void> toggleLike(String postId) async {
    final post = state.posts.firstWhere((p) => p.id == postId);
    final result = post.isLiked
        ? await _repository.unlikePost(postId)
        : await _repository.likePost(postId);
    if (result is Right<Failure, PostEntity>) {
      final updatedPosts = state.posts.map((p) {
        return p.id == postId ? result.value : p;
      }).toList();
      emit(state.copyWith(posts: updatedPosts));
    }
  }

  Future<void> createPost({required String content, List<String>? mediaUrls}) async {
    final result = await _repository.createPost(content: content, mediaUrls: mediaUrls);
    if (result is Right<Failure, PostEntity>) {
      emit(state.copyWith(posts: [result.value, ...state.posts]));
    }
  }

  void setPosts(List<PostEntity> posts) {
    emit(state.copyWith(
      status: CommunityStatus.loaded,
      posts: posts,
    ));
  }

  void toggleChallengeJoin(String challengeId) {
    final updated = state.challenges.map((c) {
      if (c.id != challengeId) return c;
      return c.copyWith(
        joined: !c.joined,
        participants: c.joined ? c.participants - 1 : c.participants + 1,
      );
    }).toList();
    emit(state.copyWith(challenges: updated));
  }

  void reset() {
    emit(const CommunityState());
  }
}
