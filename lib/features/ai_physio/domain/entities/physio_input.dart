import 'package:equatable/equatable.dart';

enum PainLocation {
  neck,
  shoulder,
  elbow,
  wrist,
  upperBack,
  lowerBack,
  hip,
  knee,
  ankle,
  foot,
  chest,
  abdomen,
}

enum PainType {
  sharp,
  dull,
  throbbing,
  burning,
  stabbing,
  aching,
  tingling,
  numbness,
}

enum PainSeverity {
  mild,
  moderate,
  severe,
  verySevere,
}

class PhysioInput extends Equatable {
  final PainLocation painLocation;
  final PainType painType;
  final int durationDays;
  final PainSeverity severity;
  final String? injuryImagePath;
  final List<String>? aggravatingFactors;
  final List<String>? relievingFactors;
  final String? previousInjuries;
  final String? activityLevel;

  const PhysioInput({
    required this.painLocation,
    required this.painType,
    required this.durationDays,
    required this.severity,
    this.injuryImagePath,
    this.aggravatingFactors,
    this.relievingFactors,
    this.previousInjuries,
    this.activityLevel,
  });

  PhysioInput copyWith({
    PainLocation? painLocation,
    PainType? painType,
    int? durationDays,
    PainSeverity? severity,
    String? injuryImagePath,
    List<String>? aggravatingFactors,
    List<String>? relievingFactors,
    String? previousInjuries,
    String? activityLevel,
  }) {
    return PhysioInput(
      painLocation: painLocation ?? this.painLocation,
      painType: painType ?? this.painType,
      durationDays: durationDays ?? this.durationDays,
      severity: severity ?? this.severity,
      injuryImagePath: injuryImagePath ?? this.injuryImagePath,
      aggravatingFactors: aggravatingFactors ?? this.aggravatingFactors,
      relievingFactors: relievingFactors ?? this.relievingFactors,
      previousInjuries: previousInjuries ?? this.previousInjuries,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  @override
  List<Object?> get props => [
        painLocation,
        painType,
        durationDays,
        severity,
        injuryImagePath,
        aggravatingFactors,
        relievingFactors,
        previousInjuries,
        activityLevel,
      ];
}
