import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'assessment_state.dart';

class AssessmentCubit extends Cubit<AssessmentState> {
  AssessmentCubit() : super(const AssessmentState());

  void setName(String value) => emit(state.copyWith(name: value));
  void setGender(String value) => emit(state.copyWith(gender: value));
  void setAge(int value) => emit(state.copyWith(age: value));
  void setAvatarIndex(int value) => emit(state.copyWith(avatarIndex: value));
  void setHeight(double value) => emit(state.copyWith(height: value));
  void setWeight(double value) => emit(state.copyWith(weight: value));
  void setBodyFat(double value) => emit(state.copyWith(bodyFat: value));
  void setTargetWeight(double value) =>
      emit(state.copyWith(targetWeight: value));
  void setUseMetric(bool value) => emit(state.copyWith(useMetric: value));
  void setFitnessLevel(String value) =>
      emit(state.copyWith(fitnessLevel: value));
  void setPrimaryGoal(String value) =>
      emit(state.copyWith(primaryGoal: value));
  void setTrainingDays(int value) =>
      emit(state.copyWith(trainingDays: value));
  void setSessionDuration(int value) =>
      emit(state.copyWith(sessionDuration: value));
  void setDietType(String value) => emit(state.copyWith(dietType: value));
  void setCoachingStyle(String value) =>
      emit(state.copyWith(coachingStyle: value));
  void setNotificationFrequency(String value) =>
      emit(state.copyWith(notificationFrequency: value));

  void toggleInjury(String injury) {
    final list = List<String>.from(state.injuries);
    if (list.contains(injury)) {
      list.remove(injury);
    } else {
      list.add(injury);
    }
    emit(state.copyWith(injuries: list));
  }

  void toggleAllergy(String allergy) {
    final list = List<String>.from(state.allergies);
    if (list.contains(allergy)) {
      list.remove(allergy);
    } else {
      list.add(allergy);
    }
    emit(state.copyWith(allergies: list));
  }

  void reset() => emit(const AssessmentState());
}
