class BookServiceEntity {
  final String providerId;
  final String serviceId;
  final String country;
  final String city;
  final String area;
  final String streetName;
  final String buildingNumber;
  final String floorNumber;
  final String apartmentNumber;
  final bool saveInformation;

  const BookServiceEntity({
    required this.providerId,
    required this.serviceId,
    required this.country,
    required this.city,
    required this.area,
    required this.streetName,
    required this.buildingNumber,
    required this.floorNumber,
    required this.apartmentNumber,
    this.saveInformation = false,
  });
}