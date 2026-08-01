import 'package:equatable/equatable.dart';

enum ForgetPasswordStatus {
  initial,
  sendingOtp,
  otpSent,
  resetting,
  resetSuccess,
  failure,
}

class ForgetPasswordState extends Equatable {
  final ForgetPasswordStatus status;
  final String? errorMessage;
  final String? email;
  final String? phone;

  const ForgetPasswordState({
    this.status = ForgetPasswordStatus.initial,
    this.errorMessage,
    this.email,
    this.phone,
  });

  ForgetPasswordState copyWith({
    ForgetPasswordStatus? status,
    String? errorMessage,
    String? email,
    String? phone,
  }) {
    return ForgetPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage??this.errorMessage,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, email, phone];
}
