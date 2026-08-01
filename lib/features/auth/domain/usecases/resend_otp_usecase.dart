import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';

import '../repositories/auth_repository.dart';

class ResendOtpUseCase implements UseCase<bool, ResendOtpParams> {
  final AuthRepository repository;
  ResendOtpUseCase(this.repository);
 
  @override
  Future<Either<Failure, bool>> call(ResendOtpParams params) {
    return repository.resendOtp(email: params.email, phone: params.phone);
  }
}
 
class ResendOtpParams extends Equatable {
  final String email;
  final String phone;
 
  const ResendOtpParams({required this.email, required this.phone});
 
  @override
  List<Object?> get props => [email, phone];
}