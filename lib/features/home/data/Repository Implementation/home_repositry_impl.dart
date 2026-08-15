// features/home/data/repository_impl/home_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:octafitv2/features/home/domain/Repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<void> getHomeData() {
    // TODO: implement getHomeData
    throw UnimplementedError();
  }
  // أضف الـ dependencies اللي يحتاجها
  // final HomeRemoteDataSource remoteDataSource;
  
  // HomeRepositoryImpl({required this.remoteDataSource});
  
  // @override
  // Future<Either<Failure, DashboardData>> loadDashboard() async {
  //   // منطق جلب البيانات
  // }
}