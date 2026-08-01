import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return repository.login(email: params.email, phone: params.phone, password: params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String phone;
  final String password;

  const LoginParams({required this.email, required this.phone, required this.password});

  @override
  List<Object?> get props => [email, phone, password];
}