import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';
import 'package:servix/features/auth/domain/entities/user_entity.dart';
import 'package:servix/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase extends UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;
  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) {
    return repository.register(name: params.name, phone: params.phone, email: params.email, password: params.password, country: params.country, city: params.city, streetAdress: params.streetAdress);
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String country;
  final String city;
  final String streetAdress;

  const RegisterParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.country,
    required this.city,
    required this.streetAdress,
  });

  @override
  List<Object?> get props => [name, phone, email, password];
}
