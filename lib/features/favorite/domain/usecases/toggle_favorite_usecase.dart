import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

class ToggleFavoriteUseCase {
  final FavoriteRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call(ProfessionalEntity professional) async {
    return await repository.toggleFavorite(professional);
  }
}
