import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String phone,
    required String password,
  });
 
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String city,
    required String country,
    required String streetAdress,
  });
 
  /// [verifyType] picks the right endpoint/flow: register, forgetPassword,
  /// updatemail, or activeAccount.
   Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String phone,
    required String otp,
    required OtpVerifyType verifyType,
  });
 
  Future<Either<Failure, bool>> resendOtp({
    required String email,
    required dynamic phone,
  });
 
  Future<Either<Failure, bool>> forgetPassword({
    required String email,
    String phone = '',
  });
 
  Future<Either<Failure, bool>> resetPassword({
    required String resetToken,
    required String newPassword,
  });
}