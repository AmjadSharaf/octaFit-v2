import 'package:dartz/dartz.dart';
import 'package:octafitv2/core/error/failure.dart';

import 'package:octafitv2/features/home/domain/Entities/home_data.dart';

abstract class HomeRepository {
  Future<Either<Failure, DashboardData>> loadDashboard();
}

class MockHomeRepository implements HomeRepository {
  @override
  Future<Either<Failure, DashboardData>> loadDashboard() async {
    return Right(DashboardData(
      user: HomeUserSummary(
        id: '1', name: 'Alex Rivera', username: '@alex_fit',
        initials: 'AR', bio: 'MMA athlete & fitness enthusiast',
        goal: 'Build explosive power & endurance',
        level: 'Intermediate', age: 28, weight: 78.5, height: 178,
        isPro: false, workouts: 47, streak: 12, followers: 128, prs: 8,
      ),
      weeklyStats: const WeeklyStats(calories: 12400, workouts: 5, hours: 8.5),
      programs: [
        DashboardProgramSummary(
          id: 'p1', title: 'MMA Conditioning', subtitle: 'Full body power',
          icon: '🥊', category: 'MMA', level: 'Intermediate',
          duration: '8 weeks', workouts: 24, rating: 4.8, progress: 60,
        ),
        DashboardProgramSummary(
          id: 'p2', title: 'Strength Foundations', subtitle: 'Build raw strength',
          icon: '🏋️', category: 'Strength', level: 'Beginner',
          duration: '12 weeks', workouts: 36, rating: 4.9, progress: 20,
        ),
      ],
      posts: [
        DashboardPostSummary(
          id: '1', user: 'John Doe', avatar: 'JD', time: '2h ago',
          content: 'Great workout today!', likes: 15, comments: 3, icon: '🏋️',
        ),
        DashboardPostSummary(
          id: '2', user: 'Jane Smith', avatar: 'JS', time: '4h ago',
          content: 'New PR on deadlift!', likes: 28, comments: 7, icon: '💪',
        ),
      ],
      aiInsight: 'Your recovery score is at 87% today. I suggest a moderate intensity session.',
    ));
  }
}
