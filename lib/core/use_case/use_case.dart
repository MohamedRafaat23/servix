import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:servix/core/errors/failure.dart';

/// Every UseCase in every feature extends this.
/// [Type] is the success return type, [Params] is the input type.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use this when a UseCase doesn't need any parameters (e.g. GetProfileUseCase).
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}