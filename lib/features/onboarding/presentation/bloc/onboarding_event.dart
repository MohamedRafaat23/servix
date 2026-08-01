import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
  @override
  List<Object?> get props => [];
}

class OnboardingPageChanged extends OnboardingEvent {
  final int index;
  const OnboardingPageChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class OnboardingNextPageRequested extends OnboardingEvent {
  const OnboardingNextPageRequested();
}

class OnboardingCompleted extends OnboardingEvent {
  const OnboardingCompleted();
}