import 'package:dartz/dartz.dart';
import 'package:servix/core/errors/failure.dart';
import 'package:servix/core/network/api_consumer.dart';
import 'package:servix/core/network/end_points.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer apiConsumer;
  AuthRepositoryImpl(this.apiConsumer);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String phone,
    required String password,
  }) async {
    final result = await apiConsumer.auth(
      EndPoints.login,
      body: {'email': email, 'phone': phone, 'password': password},
    );

    return result.fold(
      (errorMap) => Left(ServerFailure(errorMap['message']?.toString() ?? 'فشل تسجيل الدخول')),
      (apiModel) => Right(UserModel.fromJson(apiModel.response)),
    );
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
    final result = await apiConsumer.auth(
      EndPoints.signUp,
      body: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'city': city,
        'country': country,
        'streetAdress': streetAdress,
      },
    );

    return result.fold(
      (errorMap) => Left(ServerFailure(errorMap['message']?.toString() ?? 'فشل إنشاء الحساب')),
      (apiModel) => Right(UserModel.fromJson(apiModel.response)),
    );
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String phone,
    required String otp,
    required OtpVerifyType verifyType,
  }) async {
    final endpoint = verifyType == OtpVerifyType.forgetPassword
        ? EndPoints.forgetOtp
        : EndPoints.verifyOtp;

    // Use phone as identifier when available, otherwise fallback to email.
    final identifier = phone.isNotEmpty ? phone : email;

    final result = await apiConsumer.auth(
      endpoint,
      body: {'identifier': identifier, 'otp': otp},
    );

    return result.fold(
      (errorMap) => Left(ServerFailure(errorMap['message']?.toString() ?? 'كود التحقق غير صحيح')),
      (apiModel) {
        // Registration flow returns tokens; forget-password flow returns a reset token.
        final token = verifyType == OtpVerifyType.forgetPassword
            ? apiModel.response['reset_token']?.toString() ?? ''
            : apiModel.response['access']?.toString() ?? '';
        return Right(token);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> resendOtp({
    required String email,
    required dynamic phone,
  }) async {
    final result = await apiConsumer.auth(
      EndPoints.resentOtp,
      body: {'email': email, 'phone': phone},
    );

    return result.fold(
      (errorMap) => Left(ServerFailure(errorMap['message']?.toString() ?? 'تعذر إعادة إرسال الكود')),
      (_) => const Right(true),
    );
  }

  @override
  Future<Either<Failure, bool>> forgetPassword({
    required String email,
    String phone = '',
  }) async {
    final identifier = phone.isNotEmpty ? phone : email;
    final result = await apiConsumer.auth(
      EndPoints.forgetPasswordEndPoint,
      body: {'identifier': identifier},
    );

    return result.fold(
      (errorMap) => Left(ServerFailure(errorMap['message']?.toString() ?? 'تعذر إرسال كود إعادة التعيين')),
      (_) => const Right(true),
    );
  }

  @override
  Future<Either<Failure, bool>> resetPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    final result = await apiConsumer.auth(
      EndPoints.resetPassword,
      body: {'reset_token': resetToken, 'password': newPassword},
    );

    return result.fold(
      (errorMap) => Left(ServerFailure(errorMap['message']?.toString() ?? 'فشل تغيير كلمة المرور')),
      (_) => const Right(true),
    );
  }
}