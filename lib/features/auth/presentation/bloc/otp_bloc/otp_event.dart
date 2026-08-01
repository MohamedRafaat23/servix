import 'package:equatable/equatable.dart';
import 'package:servix/core/utils/constants/app_enums.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();
  @override
  List<Object?> get props => [];
}

class OtpSubmitted extends OtpEvent {
  final String email;
  final String phone;
  final String otp;
  final OtpVerifyType verifyType;

  const OtpSubmitted({
    required this.email,
    required this.phone,
    required this.otp,
    required this.verifyType,
  });

  @override
  List<Object?> get props => [email, phone, otp, verifyType];
}

class OtpResendRequested extends OtpEvent {
  final String email;
  final String phone;

  const OtpResendRequested({required this.email, required this.phone});

  @override
  List<Object?> get props => [email, phone];
}

/// Starts (or restarts, after a resend) the countdown shown on the OTP screen.
class OtpTimerStarted extends OtpEvent {
  const OtpTimerStarted();
}

/// Internal — fired once a second by the Bloc's own Timer.
class OtpTimerTicked extends OtpEvent {
  const OtpTimerTicked();
}