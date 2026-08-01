import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {
  const HomeStarted();
}

class HomeBannerPageChanged extends HomeEvent {
  final int index;
  const HomeBannerPageChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class HomeBannerAutoAdvanced extends HomeEvent {
  const HomeBannerAutoAdvanced();
}