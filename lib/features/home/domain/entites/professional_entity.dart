import 'review_entity.dart';

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
  final String? about;
  final List<String>? skills;
  final List<ReviewEntity>? reviews;
  final int serviceAreaCount;

  const ProfessionalEntity({
    required this.id,
    required this.name,
    required this.profession,
    required this.imageAsset,
    required this.rating,
    required this.jobsCount,
    required this.pricePerHour,
    required this.distanceMiles,
    required this.experiance,
    this.about,
    this.skills,
    this.reviews,
    this.serviceAreaCount = 24,
  });
}
