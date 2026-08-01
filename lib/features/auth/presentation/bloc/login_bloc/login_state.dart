import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final bool obscurePassword;

  const LoginState({
    this.status = LoginStatus.initial,
    this.user,
    this.errorMessage,
    this.obscurePassword = true,
  });

  LoginState copyWith({
    LoginStatus? status,
    UserEntity? user,
    String? errorMessage,
    bool? obscurePassword,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage, obscurePassword];
}