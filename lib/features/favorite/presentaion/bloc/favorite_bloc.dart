import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/features/favorite/domain/usecases/get_favorites_usecase.dart';
import 'package:servix/features/favorite/domain/usecases/toggle_favorite_usecase.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoriteBloc({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoriteState()) {
    on<FavoritesFetchRequested>(_onFavoritesFetchRequested);
    on<FavoriteToggleRequested>(_onFavoriteToggleRequested);
  }

  Future<void> _onFavoritesFetchRequested(
    FavoritesFetchRequested event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final result = await getFavoritesUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FavoriteStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (favorites) => emit(
        state.copyWith(
          status: FavoriteStatus.success,
          favorites: favorites,
        ),
      ),
    );
  }

  Future<void> _onFavoriteToggleRequested(
    FavoriteToggleRequested event,
    Emitter<FavoriteState> emit,
  ) async {
    // Optimistic removal / update
    final currentFavorites = List<dynamic>.from(state.favorites);
    final exists = currentFavorites.any((item) => item.id == event.professional.id);

    List<dynamic> updatedFavorites;
    if (exists) {
      updatedFavorites = currentFavorites.where((item) => item.id != event.professional.id).toList();
    } else {
      updatedFavorites = [...currentFavorites, event.professional];
    }

    emit(state.copyWith(
      favorites: updatedFavorites.cast(),
    ));

    final result = await toggleFavoriteUseCase(event.professional);
    result.fold(
      (failure) {
        // Revert on failure
        emit(state.copyWith(
          favorites: currentFavorites.cast(),
          errorMessage: failure.message,
        ));
      },
      (_) {},
    );
  }
}
