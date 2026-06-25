import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octafit/core/errors/failure.dart';
import 'package:octafit/core/utils/either.dart';
import 'package:octafit/features/notifications/domain/entities/notification_entity.dart';
import 'package:octafit/features/notifications/domain/repositories/notification_repository.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationRepository _repository;

  NotificationsCubit({required NotificationRepository repository})
      : _repository = repository,
        super(const NotificationsState());

  Future<void> loadNotifications() async {
    emit(state.copyWith(status: NotificationsStatus.loading));
    final result = await _repository.getNotifications();
    if (result is Right<Failure, List<NotificationEntity>>) {
      emit(state.copyWith(
        status: NotificationsStatus.loaded,
        notifications: result.value,
      ));
    }
  }

  void setNotifications(List<NotificationEntity> notifications) {
    emit(state.copyWith(
      status: NotificationsStatus.loaded,
      notifications: notifications,
    ));
  }

  void markAsRead(String id) {
    emit(state.copyWith(
      notifications: state.notifications.map((n) {
        if (n.id == id) return n.copyWith(unread: false);
        return n;
      }).toList(),
    ));
  }

  void markAllAsRead() {
    emit(state.copyWith(
      notifications: state.notifications
          .map((n) => n.copyWith(unread: false))
          .toList(),
    ));
  }
}
