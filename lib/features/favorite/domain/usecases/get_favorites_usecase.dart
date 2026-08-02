import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

class GetFavoritesUseCase {
  final FavoriteRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<Either<Failure, List<ProfessionalEntity>>> call() async {
    return await repository.getFavorites();
  }
}
