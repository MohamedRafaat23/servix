
import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ForgetPasswordRequested extends ForgetPasswordEvent {
  final String emailOrPhone;

  const ForgetPasswordRequested({required this.emailOrPhone});

  @override
  List<Object?> get props => [emailOrPhone];
}

class ResetPasswordSubmitted extends ForgetPasswordEvent {
  final String resetToken;
  final String newPassword;

  const ResetPasswordSubmitted({
    required this.resetToken,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [resetToken, newPassword];
}
