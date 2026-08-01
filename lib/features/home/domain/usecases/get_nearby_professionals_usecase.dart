// lib/features/home/domain/usecases/get_nearby_professionals_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';
import '../repositories/home_repository.dart';

class GetNearbyProfessionalsUseCase {
  final HomeRepository repository;
  GetNearbyProfessionalsUseCase(this.repository);

  Future<Either<Failure, List<ProfessionalEntity>>> call() {
    return repository.getNearbyProfessionals();
  }
}