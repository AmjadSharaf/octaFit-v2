import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String icon;
  final String title;
  final String body;
  final String time;
  final bool unread;

  const NotificationEntity({
    required this.id,
    required this.icon,
    required this.title,
    required this.body,
    required this.time,
    required this.unread,
  });

  NotificationEntity copyWith({bool? unread}) {
    return NotificationEntity(
      id: id, icon: icon, title: title, body: body, time: time,
      unread: unread ?? this.unread,
    );
  }

  @override
  List<Object?> get props => [id, icon, title, body, time, unread];
}
