import 'package:equatable/equatable.dart';

class MedicalTestItemModel extends Equatable {
  const MedicalTestItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.averageFee,
  });

  final int id;
  final String title;
  final String description;
  final String averageFee;

  @override
  List<Object?> get props => [id, title, description, averageFee];
}
