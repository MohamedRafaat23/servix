import 'package:equatable/equatable.dart';

enum OtpStatus { initial, verifying, verified, resending, resent, failure }

const int otpCountdownSeconds = 152; // 02:32, matching the design

class OtpState extends Equatable {
  final OtpStatus status;
  final String? token; // access token (register flow) or reset token (forget-password flow)
  final String? errorMessage;
  final int secondsLeft;

  const OtpState({
    this.status = OtpStatus.initial,
    this.token,
    this.errorMessage,
    this.secondsLeft = otpCountdownSeconds,
  });

  bool get canResend => secondsLeft == 0;

  String get formattedTime {
    final minutes = (secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  OtpState copyWith({OtpStatus? status, String? token, String? errorMessage, int? secondsLeft}) {
    return OtpState(
      status: status ?? this.status,
      token: token ?? this.token,
      errorMessage: errorMessage,
      secondsLeft: secondsLeft ?? this.secondsLeft,
    );
  }

  @override
  List<Object?> get props => [status, token, errorMessage, secondsLeft];
}