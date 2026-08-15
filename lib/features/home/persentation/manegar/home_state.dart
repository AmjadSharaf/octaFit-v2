import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;

  const HomeState({this.status = HomeStatus.initial});
HomeState copyWith({HomeStatus? status}) {
    return HomeState(status: status ?? this.status);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [status];
}
