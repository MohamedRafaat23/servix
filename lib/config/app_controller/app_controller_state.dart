part of 'app_controller_bloc.dart';

class AppControllerState extends Equatable {
  final bool isDarkMode;
  final int notificationsCount;
  final bool isGuest;
  const AppControllerState({
    this.isDarkMode = false,
    this.notificationsCount = 0,
    this.isGuest = false,
  });

  AppControllerState copyWith({
    bool? isDarkMode,
    int? notificationsCount,
    bool? isGuest,
  }) {
    return AppControllerState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsCount: notificationsCount ?? this.notificationsCount,
      isGuest: isGuest ?? this.isGuest,
    );
  }

  @override
  List<Object> get props => [isDarkMode, notificationsCount, isGuest];
}
