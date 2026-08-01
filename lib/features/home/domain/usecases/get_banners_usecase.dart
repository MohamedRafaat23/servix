// lib/features/home/domain/usecases/get_banners_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/features/home/domain/entites/bannar_entity.dart';
import '../repositories/home_repository.dart';

class GetBannersUseCase {
  final HomeRepository repository;
  GetBannersUseCase(this.repository);

  Future<Either<Failure, List<BannerEntity>>> call() {
    return repository.getBanners();
  }
}