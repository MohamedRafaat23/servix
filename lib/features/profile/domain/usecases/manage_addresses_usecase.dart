import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/use_case/use_case.dart';
import 'package:servix/features/profile/domain/repositories/profile_repository.dart';

class GetSavedAddressesUseCase implements UseCase<List<String>, NoParams> {
  final ProfileRepository repository;

  GetSavedAddressesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.getSavedAddresses();
  }
}

class AddSavedAddressUseCase implements UseCase<List<String>, String> {
  final ProfileRepository repository;

  AddSavedAddressUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(String address) async {
    return await repository.addSavedAddress(address);
  }
}

class DeleteSavedAddressUseCase implements UseCase<List<String>, int> {
  final ProfileRepository repository;

  DeleteSavedAddressUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(int index) async {
    return await repository.deleteSavedAddress(index);
  }
}
