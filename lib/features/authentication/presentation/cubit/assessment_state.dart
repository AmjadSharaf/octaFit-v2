part of 'assessment_cubit.dart';

class AssessmentState extends Equatable {
  const AssessmentState({
    this.name = '',
    this.gender = '',
    this.age = 25,
    this.avatarIndex = 0,
    this.height = 175,
    this.weight = 75,
    this.bodyFat = 18,
    this.targetWeight = 72,
    this.useMetric = true,
    this.fitnessLevel = '',
    this.primaryGoal = '',
    this.trainingDays = 4,
    this.sessionDuration = 60,
    this.injuries = const [],
    this.dietType = '',
    this.allergies = const [],
    this.coachingStyle = '',
    this.notificationFrequency = 'Daily',
  });

  final String name;
  final String gender;
  final int age;
  final int avatarIndex;
  final double height;
  final double weight;
  final double bodyFat;
  final double targetWeight;
  final bool useMetric;
  final String fitnessLevel;
  final String primaryGoal;
  final int trainingDays;
  final int sessionDuration;
  final List<String> injuries;
  final String dietType;
  final List<String> allergies;
  final String coachingStyle;
  final String notificationFrequency;

  double get bmi {
    final heightM = useMetric ? height / 100 : height * 0.0254;
    final weightKg = useMetric ? weight : weight * 0.453592;
    if (heightM <= 0) return 0;
    return weightKg / (heightM * heightM);
  }

  AssessmentState copyWith({
    String? name,
    String? gender,
    int? age,
    int? avatarIndex,
    double? height,
    double? weight,
    double? bodyFat,
    double? targetWeight,
    bool? useMetric,
    String? fitnessLevel,
    String? primaryGoal,
    int? trainingDays,
    int? sessionDuration,
    List<String>? injuries,
    String? dietType,
    List<String>? allergies,
    String? coachingStyle,
    String? notificationFrequency,
  }) {
    return AssessmentState(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bodyFat: bodyFat ?? this.bodyFat,
      targetWeight: targetWeight ?? this.targetWeight,
      useMetric: useMetric ?? this.useMetric,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      trainingDays: trainingDays ?? this.trainingDays,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      injuries: injuries ?? this.injuries,
      dietType: dietType ?? this.dietType,
      allergies: allergies ?? this.allergies,
      coachingStyle: coachingStyle ?? this.coachingStyle,
      notificationFrequency:
          notificationFrequency ?? this.notificationFrequency,
    );
  }

  @override
  List<Object?> get props => [
        name,
        gender,
        age,
        avatarIndex,
        height,
        weight,
        bodyFat,
        targetWeight,
        useMetric,
        fitnessLevel,
        primaryGoal,
        trainingDays,
        sessionDuration,
        injuries,
        dietType,
        allergies,
        coachingStyle,
        notificationFrequency,
      ];
}
