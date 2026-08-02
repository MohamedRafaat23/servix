import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';
import 'package:servix/features/profile/domain/entites/profile_entity.dart';
import 'package:servix/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase implements UseCase<ProfileEntity, NoParams> {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) async {
    return await repository.getProfile();
  }
}
