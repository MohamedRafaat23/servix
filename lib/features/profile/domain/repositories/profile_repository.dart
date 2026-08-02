import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/features/profile/domain/entites/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    required String email,
    String? avatarUrl,
  });
  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<Either<Failure, List<String>>> getSavedAddresses();
  Future<Either<Failure, List<String>>> addSavedAddress(String address);
  Future<Either<Failure, List<String>>> deleteSavedAddress(int index);
  Future<Either<Failure, ProfileEntity>> toggleNotifications(bool enabled);
  Future<Either<Failure, ProfileEntity>> toggleNightMode(bool enabled);
}
