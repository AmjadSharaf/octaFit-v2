part of 'community_cubit.dart';

enum CommunityStatus {
  initial,
  loading,
  loaded,
  refreshing,
  error,
}

class CommunityState extends Equatable {
  final CommunityStatus status;
  final List<PostEntity> posts;
  final List<AchievementEntry> achievements;
  final List<ChallengeEntry> challenges;
  final List<LeaderboardEntry> leaderboard;
  final int page;
  final bool hasMore;
  final String? errorMessage;

  const CommunityState({
    this.status = CommunityStatus.initial,
    this.posts = const [],
    this.achievements = _defaultAchievements,
    this.challenges = _defaultChallenges,
    this.leaderboard = _defaultLeaderboard,
    this.page = 1,
    this.hasMore = true,
    this.errorMessage,
  });

  bool get isLoading => status == CommunityStatus.loading ||
      status == CommunityStatus.refreshing;

  CommunityState copyWith({
    CommunityStatus? status,
    List<PostEntity>? posts,
    List<AchievementEntry>? achievements,
    List<ChallengeEntry>? challenges,
    List<LeaderboardEntry>? leaderboard,
    int? page,
    bool? hasMore,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CommunityState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      achievements: achievements ?? this.achievements,
      challenges: challenges ?? this.challenges,
      leaderboard: leaderboard ?? this.leaderboard,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        posts,
        achievements,
        challenges,
        leaderboard,
        page,
        hasMore,
        errorMessage,
      ];
}
