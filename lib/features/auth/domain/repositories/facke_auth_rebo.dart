import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import 'package:servix/features/auth/data/models/user_model.dart';
import 'package:servix/features/auth/domain/entities/user_entity.dart';
import 'package:servix/features/auth/domain/repositories/auth_repository.dart';

/// Fake implementation used during UI-only development, before the real
/// API is ready. Always returns success after a short simulated delay.
/// Swap back to [AuthRepositoryImpl] in service_locator.dart once the
/// backend is ready — no other code (UseCases, Blocs, Screens) needs to change.
class FakeAuthRepository implements AuthRepository {
  static const _delay = Duration(seconds: 1);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(_delay);
    return Right(_fakeUser(email: email, phone: phone));
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String city,
    required String country,
    required String streetAdress,
  }) async {
    await Future.delayed(_delay);
    return Right(_fakeUser(email: email, phone: phone, name: name));
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String phone,
    required String otp,
    required OtpVerifyType verifyType,
  }) async {
    await Future.delayed(_delay);
    return const Right('fake_reset_token');
  }

  @override
  Future<Either<Failure, bool>> resendOtp({
    required String email,
    required dynamic phone,
  }) async {
    await Future.delayed(_delay);
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> forgetPassword({
    required String email,
    String phone = '',
  }) async {
    await Future.delayed(_delay);
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> resetPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    await Future.delayed(_delay);
    return const Right(true);
  }

  //fack user model to use in fack api
  UserModel _fakeUser({
  String email = 'test@test.com',
  String phone = '01000000000',
  String name = 'Test User',
}) {
  return UserModel(
    id: '1',
    name: name,
    email: email,
    phone: phone,
    accessToken: 'fake_access_token',
    refreshToken: 'fake_refresh_token',
    isVerified: true,
  );
}
}