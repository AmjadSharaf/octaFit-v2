import 'package:equatable/equatable.dart';

class ExerciseEntity extends Equatable {
  final String id;
  final String name;
  final String muscle;
  final String equipment;
  final int sets;
  final String reps;
  final String rest;

  const ExerciseEntity({
    required this.id,
    required this.name,
    required this.muscle,
    required this.equipment,
    required this.sets,
    required this.reps,
    required this.rest,
  });

  @override
  List<Object?> get props => [id, name, muscle, equipment, sets, reps, rest];
}
