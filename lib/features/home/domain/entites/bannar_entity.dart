// lib/features/home/domain/entities/banner_entity.dart
class BannerEntity {
  final String id;
  final String discountText;
  final String title;
  final String description;
  final String imageAsset;

  const BannerEntity({
    required this.id,
    required this.discountText,
    required this.title,
    required this.description,
    required this.imageAsset,
  });
}