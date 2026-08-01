import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase implements UseCase<bool, ResetPasswordParams> {
  final AuthRepository repository;
  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(ResetPasswordParams params) {
    return repository.resetPassword(
      resetToken: params.resetToken,
      newPassword: params.newPassword,
    );
  }
}

class ResetPasswordParams extends Equatable {
  final String resetToken;
  final String newPassword;

  const ResetPasswordParams({required this.resetToken, required this.newPassword});

  @override
  List<Object?> get props => [resetToken, newPassword];
}