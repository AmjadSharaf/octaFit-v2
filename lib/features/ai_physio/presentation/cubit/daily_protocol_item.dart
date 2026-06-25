import 'package:equatable/equatable.dart';

class DailyProtocolItem extends Equatable {
  final String day;
  final String focus;
  final List<String> exercises;
  final String duration;

  const DailyProtocolItem({
    required this.day,
    required this.focus,
    required this.exercises,
    required this.duration,
  });

  @override
  List<Object?> get props => [day, focus, exercises, duration];
}
