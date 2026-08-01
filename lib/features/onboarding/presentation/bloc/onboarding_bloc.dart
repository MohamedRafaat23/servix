import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/storage_keys.dart';
import 'package:servix/core/utils/functions/preference_utils.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final PreferenceUtils preferenceUtils;
  final PageController pageController = PageController();

  OnboardingBloc(this.preferenceUtils) : super(const OnboardingState()) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingNextPageRequested>(_onNextPageRequested);
    on<OnboardingCompleted>(_onCompleted);
  }

  void _onPageChanged(OnboardingPageChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentPage: event.index));
  }

  void _onNextPageRequested(OnboardingNextPageRequested event, Emitter<OnboardingState> emit) {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _onCompleted(OnboardingCompleted event, Emitter<OnboardingState> emit) async {
    await preferenceUtils.setBool(StorageKeys.onBoarding, true);
    emit(state.copyWith(isCompleted: true));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}