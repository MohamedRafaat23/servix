// home_repository.dart
import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/features/home/domain/entites/bannar_entity.dart';
import 'package:servix/features/home/domain/entites/category_entity.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<ProfessionalEntity>>> getNearbyProfessionals();
  Future<Either<Failure, List<BannerEntity>>> getBanners(); 
}