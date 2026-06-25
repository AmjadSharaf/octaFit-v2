part of 'digital_athlete_cubit.dart';

enum DigitalAthleteStatus {
  idle,
  loading,
  dataReady,
  predictionsReady,
  error,
}

class DigitalAthleteState extends Equatable {
  final DigitalAthleteStatus status;
  final AthleteData? athleteData;
  final AthletePredictions? predictions;
  final String? errorMessage;

  const DigitalAthleteState({
    this.status = DigitalAthleteStatus.idle,
    this.athleteData,
    this.predictions,
    this.errorMessage,
  });

  bool get isLoading => status == DigitalAthleteStatus.loading;

  DigitalAthleteState copyWith({
    DigitalAthleteStatus? status,
    AthleteData? athleteData,
    AthletePredictions? predictions,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DigitalAthleteState(
      status: status ?? this.status,
      athleteData: athleteData ?? this.athleteData,
      predictions: predictions ?? this.predictions,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        athleteData,
        predictions,
        errorMessage,
      ];
}
