part of 'home_cubit.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final HomeUserSummary? user;
  final int weeklyCalories;
  final int weeklyWorkouts;
  final double weeklyHours;
  final List<DashboardProgramSummary> programs;
  final List<DashboardPostSummary> posts;
  final String aiInsight;
  final String? selectedProgramId;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.user,
    this.weeklyCalories = 0,
    this.weeklyWorkouts = 0,
    this.weeklyHours = 0,
    this.programs = const [],
    this.posts = const [],
    this.aiInsight =
        'Your recovery score is at 87% today. I suggest a moderate intensity '
        'session — perfect for skill work and technique refinement.',
    this.selectedProgramId,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    HomeUserSummary? user,
    int? weeklyCalories,
    int? weeklyWorkouts,
    double? weeklyHours,
    List<DashboardProgramSummary>? programs,
    List<DashboardPostSummary>? posts,
    String? aiInsight,
    String? selectedProgramId,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
      weeklyCalories: weeklyCalories ?? this.weeklyCalories,
      weeklyWorkouts: weeklyWorkouts ?? this.weeklyWorkouts,
      weeklyHours: weeklyHours ?? this.weeklyHours,
      programs: programs ?? this.programs,
      posts: posts ?? this.posts,
      aiInsight: aiInsight ?? this.aiInsight,
      selectedProgramId: selectedProgramId ?? this.selectedProgramId,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        weeklyCalories,
        weeklyWorkouts,
        weeklyHours,
        programs,
        posts,
        aiInsight,
        selectedProgramId,
        errorMessage,
      ];
}
