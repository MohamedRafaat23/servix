import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_banners_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_nearby_professionals_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetNearbyProfessionalsUseCase getNearbyProfessionalsUseCase;
  final GetBannersUseCase getBannersUseCase;
  final bannerPageController = PageController();
  Timer? _bannerTimer;
  static const _bannerInterval = Duration(seconds: 4);

  HomeBloc(
    this.getCategoriesUseCase,
    this.getNearbyProfessionalsUseCase,
    this.getBannersUseCase,
  ) : super(const HomeState()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeSearchQueryChanged>(_onSearchQueryChanged);
    on<HomeBannerPageChanged>(_onBannerPageChanged);
    on<HomeBannerAutoAdvanced>(_onBannerAutoAdvanced);
  }

  Future<void> _onSearchQueryChanged(HomeSearchQueryChanged event, Emitter<HomeState> emit) async {
    emit(state.copyWith(searchQuery: event.query));
  }

  Future<void> _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final categoriesResult = await getCategoriesUseCase();
    final professionalsResult = await getNearbyProfessionalsUseCase();
    final bannersResult = await getBannersUseCase();

    categoriesResult.fold(
      (failure) => emit(state.copyWith(status: HomeStatus.failure, errorMessage: failure.message)),
      (categories) {
        professionalsResult.fold(
          (failure) => emit(state.copyWith(status: HomeStatus.failure, errorMessage: failure.message)),
          (professionals) {
            bannersResult.fold(
              (failure) => emit(state.copyWith(status: HomeStatus.failure, errorMessage: failure.message)),
              (banners) {
                emit(state.copyWith(
                  status: HomeStatus.success,
                  categories: categories,
                  professionals: professionals,
                  banners: banners,
                ));
                _startBannerAutoScroll();
              },
            );
          },
        );
      },
    );
  }

  void _startBannerAutoScroll() {
    _bannerTimer?.cancel();
    if (state.banners.length <= 1) return;

    _bannerTimer = Timer.periodic(_bannerInterval, (_) {
      add(const HomeBannerAutoAdvanced());
    });
  }

  void _onBannerPageChanged(HomeBannerPageChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentBannerIndex: event.index));
  }

  void _onBannerAutoAdvanced(HomeBannerAutoAdvanced event, Emitter<HomeState> emit) {
    if (state.banners.isEmpty) return;

    final nextIndex = (state.currentBannerIndex + 1) % state.banners.length;

    if (bannerPageController.hasClients) {
      bannerPageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }

    emit(state.copyWith(currentBannerIndex: nextIndex));
  }

  @override
  Future<void> close() {
    _bannerTimer?.cancel();
    bannerPageController.dispose();
    return super.close();
  }
}