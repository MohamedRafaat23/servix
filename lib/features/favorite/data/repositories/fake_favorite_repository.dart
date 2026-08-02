import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

class FakeFavoriteRepository implements FavoriteRepository {
  static const _delay = Duration(milliseconds: 400);

  final List<ProfessionalEntity> _favoriteProfessionals = [
    const ProfessionalEntity(
      id: '1',
      name: 'Michael Reed',
      profession: 'Master Plumber',
      imageAsset: AppImages.frame1,
      rating: 4.8,
      jobsCount: 1240,
      pricePerHour: 65,
      distanceMiles: 0.8,
      experiance: 8,
    ),
    const ProfessionalEntity(
      id: '2',
      name: 'Maicil Rashil',
      profession: 'Certified HVAC',
      imageAsset: AppImages.frame2,
      rating: 4.9,
      jobsCount: 670,
      pricePerHour: 70,
      distanceMiles: 1.5,
      experiance: 6,
    ),
    const ProfessionalEntity(
      id: '3',
      name: 'Sara Johnson',
      profession: 'Certified HVAC',
      imageAsset: AppImages.frame2,
      rating: 4.9,
      jobsCount: 670,
      pricePerHour: 70,
      distanceMiles: 1.5,
      experiance: 5,
    ),
  ];

  @override
  Future<Either<Failure, List<ProfessionalEntity>>> getFavorites() async {
    await Future.delayed(_delay);
    return Right(List.from(_favoriteProfessionals));
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(
    ProfessionalEntity professional,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _favoriteProfessionals.indexWhere(
      (item) => item.id == professional.id,
    );
    if (index != -1) {
      _favoriteProfessionals.removeAt(index);
    } else {
      _favoriteProfessionals.add(professional);
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String professionalId) async {
    return Right(
      _favoriteProfessionals.any((item) => item.id == professionalId),
    );
  }
}
