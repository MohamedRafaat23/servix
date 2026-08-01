
import 'package:equatable/equatable.dart';
import 'package:servix/features/home/domain/entites/bannar_entity.dart';
import 'package:servix/features/home/domain/entites/category_entity.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';
enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<CategoryEntity> categories;
  final List<ProfessionalEntity> professionals;
  final List<BannerEntity> banners; 
  final String? errorMessage;
  final int currentBannerIndex;
  const HomeState({
    this.currentBannerIndex = 0,
    this.status = HomeStatus.initial,
    this.categories = const [],
    this.professionals = const [],
    this.banners = const [], 
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
     int? currentBannerIndex,
    List<CategoryEntity>? categories,
    List<ProfessionalEntity>? professionals,
    List<BannerEntity>? banners, 
    String? errorMessage,
    
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      professionals: professionals ?? this.professionals,
      banners: banners ?? this.banners, 
      errorMessage: errorMessage,
       currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex
    );
  }

  @override
  List<Object?> get props => [status, categories, professionals, banners, errorMessage,currentBannerIndex];
}