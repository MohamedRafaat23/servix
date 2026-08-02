import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';
import 'package:servix/features/profile/domain/entites/profile_entity.dart';
import 'package:servix/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileParams extends Equatable {
  final String name;
  final String email;
  final String? avatarUrl;

  const UpdateProfileParams({
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [name, email, avatarUrl];
}

class UpdateProfileUseCase implements UseCase<ProfileEntity, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(
      name: params.name,
      email: params.email,
      avatarUrl: params.avatarUrl,
    );
  }
}
