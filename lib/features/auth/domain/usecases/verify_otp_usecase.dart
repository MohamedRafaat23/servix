import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';
import 'package:servix/core/utils/constants/app_enums.dart';

import '../repositories/auth_repository.dart';

class VerifyOtpUseCase implements UseCase<String, VerifyOtpParams> {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);
 
  @override
  Future<Either<Failure, String>> call(VerifyOtpParams params) {
    return repository.verifyOtp(
      email: params.email,
      phone: params.phone,
      otp: params.otp,
      verifyType: params.verifyType,
    );
  }
}
 
class VerifyOtpParams extends Equatable {
  final String email;
  final String phone;
  final String otp;
   final OtpVerifyType verifyType;

  const VerifyOtpParams({
    required this.email,
    required this.phone,
    required this.otp,
    required this.verifyType,
  });
 
  @override
  List<Object?> get props => [email, phone, otp, verifyType];
}