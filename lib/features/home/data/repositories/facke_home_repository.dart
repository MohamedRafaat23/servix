// lib/features/home/data/repositories/fake_home_repository.dart
import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/features/home/domain/entites/bannar_entity.dart';
import 'package:servix/features/home/domain/entites/category_entity.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

import '../../domain/repositories/home_repository.dart';

/// Fake implementation used during UI-only development.
/// Swap to a real implementation in service_locator.dart once the API is ready.
class FakeHomeRepository implements HomeRepository {
  static const _delay = Duration(milliseconds: 700);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    await Future.delayed(_delay);
    return const Right([
      CategoryEntity(id: '1', name: 'Plumbing', imageAsset: AppImages.plumbing),
      CategoryEntity(id: '2', name: 'Electrical', imageAsset:  AppImages.electrical),
      CategoryEntity(id: '3', name: 'Blacksmith', imageAsset:  AppImages.blacksmith),
      CategoryEntity(id: '4', name: 'Carpentry', imageAsset:  AppImages.carpentry),
      CategoryEntity(id: '5', name: 'Mechanical', imageAsset:  AppImages.mechanical),
      CategoryEntity(id: '6', name: 'Construction', imageAsset:  AppImages.construction),
    ]);
  }

  @override
  Future<Either<Failure, List<ProfessionalEntity>>> getNearbyProfessionals() async {
    await Future.delayed(_delay);
    return const Right([
      ProfessionalEntity(
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
      ProfessionalEntity(
        id: '2',
        name: 'Sara Youssef',
        profession: 'Electrician',
        imageAsset:  AppImages.frame2,
        rating: 4.6,
        jobsCount: 860,
        pricePerHour: 55,
        distanceMiles: 1.4, 
        experiance: 8,
      ),
      
    ]);
  }

  @override
Future<Either<Failure, List<BannerEntity>>> getBanners() async {
  await Future.delayed(_delay);
  return const Right([
    BannerEntity(
      id: '1',
      discountText: '50% OFF',
      title: 'Professional Home Cleaning',
      description: 'Book now and enjoy a sparkling clean home for less.',
      imageAsset: 'assets/images/banners/cleaning.png',
    ),
    BannerEntity(
      id: '2',
      discountText: '30% OFF',
      title: 'Plumbing Emergency Fix',
      description: 'Fast response plumbers available 24/7.',
      imageAsset: 'assets/images/banners/plumbing.png',
    ),
    BannerEntity(
      id: '3',
      discountText: 'NEW',
      title: 'Home Electrical Checkup',
      description: 'Book a full safety inspection at a great price.',
      imageAsset: 'assets/images/banners/electrical.png',
    ),
  ]);
}
}