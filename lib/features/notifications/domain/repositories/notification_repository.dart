import 'package:octafit/core/utils/either.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();
}

class MockNotificationRepository implements NotificationRepository {
  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    return Right([
      NotificationEntity(id: 'n0', icon: '💪', title: 'Workout Reminder',
          body: 'Time for your evening session!', time: 'Just now', unread: true),
      NotificationEntity(id: 'n1', icon: '🏆', title: 'New Achievement',
          body: 'You unlocked "Week Warrior"!', time: '1h ago', unread: true),
      NotificationEntity(id: 'n2', icon: '👤', title: 'New Follower',
          body: 'Sarah J. started following you', time: '3h ago', unread: false),
    ]);
  }
}
