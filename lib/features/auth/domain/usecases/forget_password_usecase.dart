import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';
import 'package:servix/features/auth/domain/repositories/auth_repository.dart';

class ForgetPasswordUseCase implements UseCase<bool, ForgetPasswordParams> {
  final AuthRepository repository;
  ForgetPasswordUseCase(this.repository);
 
  @override
  Future<Either<Failure, bool>> call(ForgetPasswordParams params) {
    return repository.forgetPassword(email: params.email, phone: params.phone);
  }
}
 
class ForgetPasswordParams extends Equatable {
  final String email;
  final String phone;
 
  const ForgetPasswordParams({required this.email, this.phone = ''});
 
  @override
  List<Object?> get props => [email, phone];
}
 