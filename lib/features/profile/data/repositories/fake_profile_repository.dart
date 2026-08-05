import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/features/profile/domain/entites/profile_entity.dart';
import 'package:servix/features/profile/domain/repositories/profile_repository.dart';

class FakeProfileRepository implements ProfileRepository {
  static const _delay = Duration(milliseconds: 300);

  ProfileEntity _profile = const ProfileEntity(
    id: 'user_101',
    name: 'Khaled Ali',
    email: 'Alikhaled33@gmail.com',
    phone: '+966 50 123 4567',
    avatarUrl: null,
    savedAddresses: [
      'Olaya District - Riyadh',
      'Olaya District - Riyadh',
    ],
    notificationsEnabled: false,
    nightModeEnabled: true,
    language: "en",
  );

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    await Future.delayed(_delay);
    return Right(_profile);
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    required String email,
    String? avatarUrl,
  }) async {
    await Future.delayed(_delay);
    _profile = _profile.copyWith(
      name: name,
      email: email,
      avatarUrl: avatarUrl ?? _profile.avatarUrl,
    );
    return Right(_profile);
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await Future.delayed(_delay);
    if (oldPassword.isEmpty) {
      return Left(ServerFailure('Old password is incorrect'));
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<String>>> getSavedAddresses() async {
    await Future.delayed(_delay);
    return Right(List.from(_profile.savedAddresses));
  }

  @override
  Future<Either<Failure, List<String>>> addSavedAddress(String address) async {
    await Future.delayed(_delay);
    final updatedList = List<String>.from(_profile.savedAddresses)..add(address);
    _profile = _profile.copyWith(savedAddresses: updatedList);
    return Right(updatedList);
  }

  @override
  Future<Either<Failure, List<String>>> deleteSavedAddress(int index) async {
    await Future.delayed(_delay);
    if (index >= 0 && index < _profile.savedAddresses.length) {
      final updatedList = List<String>.from(_profile.savedAddresses)..removeAt(index);
      _profile = _profile.copyWith(savedAddresses: updatedList);
      return Right(updatedList);
    }
    return Right(_profile.savedAddresses);
  }
  
  @override
  Future<Either<Failure, ProfileEntity>> toggleNotifications(bool enabled) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _profile = _profile.copyWith(notificationsEnabled: enabled);
    return Right(_profile);
  }

  @override
  Future<Either<Failure, ProfileEntity>> toggleNightMode(bool enabled) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _profile = _profile.copyWith(nightModeEnabled: enabled);
    return Right(_profile);
  }
  
  @override
  Future<Either<Failure, ProfileEntity>> changeLanguage(bool enabled) async {
    await Future.delayed(const Duration(milliseconds: 150));
    // In the fake repo, interpret the boolean as choosing between English and Arabic
    final language = enabled ? 'en' : 'ar';
    _profile = _profile.copyWith(language: language);
    return Right(_profile);
  }
}
