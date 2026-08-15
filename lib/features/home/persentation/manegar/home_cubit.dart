import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octafitv2/features/home/domain/Repositories/home_repository.dart';
import 'package:octafitv2/features/home/persentation/manegar/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit({required HomeRepository repository})
    : _repository = repository,
      super(const HomeState());
}
