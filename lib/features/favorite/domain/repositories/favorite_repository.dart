import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<ProfessionalEntity>>> getFavorites();
  Future<Either<Failure, void>> toggleFavorite(ProfessionalEntity professional);
  Future<Either<Failure, bool>> isFavorite(String professionalId);
}
