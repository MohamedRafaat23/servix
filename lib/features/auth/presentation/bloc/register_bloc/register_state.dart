import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final UserEntity? user;
  final String? errorMessage;
    final bool obscurePassword;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.user,
    this.errorMessage,this.obscurePassword = true,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    UserEntity? user,
    String? errorMessage,
   bool? obscurePassword,

  }) {
    return RegisterState(
      status: status ?? this.status,
      obscurePassword: obscurePassword??this.obscurePassword,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage,obscurePassword];
}
