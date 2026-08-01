part of 'app_controller_bloc.dart';

sealed class AppControllerEvent extends Equatable {
  const AppControllerEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends AppControllerEvent {
  const ToggleThemeEvent();
}

class ResetNotificationCountEvent extends AppControllerEvent {
  final bool isReset;
  const ResetNotificationCountEvent({this.isReset = false});
  @override
  List<Object> get props => [isReset];
}

class SetThemeEvent extends AppControllerEvent {
  final bool isDarkMode;
  const SetThemeEvent(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];
}

class GetNotificationCountEvent extends AppControllerEvent {
  const GetNotificationCountEvent();
}

class RefreshGuestStatusEvent extends AppControllerEvent {
  const RefreshGuestStatusEvent();
}
