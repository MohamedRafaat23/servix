// lib/features/home/domain/entities/professional_entity.dart
class ProfessionalEntity {
  final String id;
  final String name;
  final String profession;
  final String imageAsset;
  final double rating;
  final int jobsCount;
  final double pricePerHour;
  final double distanceMiles;
  final int experiance;

  const ProfessionalEntity({
    required this.experiance,
    required this.id,
    required this.name,
    required this.profession,
    required this.imageAsset,
    required this.rating,
    required this.jobsCount,
    required this.pricePerHour,
    required this.distanceMiles,
  });
}