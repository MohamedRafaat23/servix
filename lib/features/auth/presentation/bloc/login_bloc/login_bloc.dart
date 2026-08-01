import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import 'package:servix/core/utils/functions/callback_token.dart';
import 'package:servix/core/utils/functions/identifier_helper.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final formKey = GlobalKey<FormState>();
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();
  LoginBloc(this.loginUseCase) : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginObscurePasswordToggled>(_onObscurePasswordToggled);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));

    final split = splitIdentifier(event.emailOrPhone);

    final result = await loginUseCase(
      LoginParams(email: split.email, phone: split.phone, password: event.password),
    );

    await result.fold(
      (failure) async => emit(state.copyWith(status: LoginStatus.failure, errorMessage: failure.message)),
      (user) async {
        final local = sl<HandleMulticallLocal>();
        await local.saveLocalData(data: user.accessToken, keyType: LocalEnumKey.accessToken);
        await local.saveLocalData(data: user.refreshToken, keyType: LocalEnumKey.refreshToken);
        await local.saveLocalData(data: user.id, keyType: LocalEnumKey.userId);
        await local.saveLocalData(data: user.name, keyType: LocalEnumKey.fullName);
        emit(state.copyWith(status: LoginStatus.success, user: user));
      },
    );
  }
  // visabilty of password
  void _onObscurePasswordToggled(LoginObscurePasswordToggled event, Emitter<LoginState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
  @override
  Future <void>close() {
    identifierController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
