import 'package:equatable/equatable.dart';
import 'package:servix/features/home/domain/entites/professional_entity.dart';

enum FavoriteStatus { initial, loading, success, failure }

class FavoriteState extends Equatable {
  final FavoriteStatus status;
  final List<ProfessionalEntity> favorites;
  final String? errorMessage;

  const FavoriteState({
    this.status = FavoriteStatus.initial,
    this.favorites = const [],
    this.errorMessage,
  });

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<ProfessionalEntity>? favorites,
    String? errorMessage,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, favorites, errorMessage];
}
