import 'package:equatable/equatable.dart';

enum SplashStatus { loading, authenticated, unauthenticated }

class SplashState extends Equatable {
  final SplashStatus status;
  final bool hasSeenOnboarding;

  const SplashState({
    this.status = SplashStatus.loading,
    this.hasSeenOnboarding = false,
  });

  SplashState copyWith({
    SplashStatus? status,
    bool? hasSeenOnboarding,
  }) {
    return SplashState(
      status: status ?? this.status,
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }

  @override
  List<Object?> get props => [status, hasSeenOnboarding];
}