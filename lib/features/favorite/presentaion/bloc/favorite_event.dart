import 'package:equatable/equatable.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesFetchRequested extends FavoriteEvent {
  const FavoritesFetchRequested();
}

class FavoriteToggleRequested extends FavoriteEvent {
  final ProfessionalEntity professional;

  const FavoriteToggleRequested(this.professional);

  @override
  List<Object?> get props => [professional];
}
