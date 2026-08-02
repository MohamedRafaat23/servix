import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {
  const HomeStarted();
}

class HomeSearchQueryChanged extends HomeEvent {
  final String query;
  const HomeSearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
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
