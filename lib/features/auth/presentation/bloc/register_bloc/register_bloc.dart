import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import 'package:servix/core/utils/functions/callback_token.dart';

import '../../../domain/usecases/register_usecase.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  //inject usecase to bloc
  final RegisterUsecase registerUsecase;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final streetController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  RegisterBloc(this.registerUsecase) : super(const RegisterState()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RegisterObscurePasswordToggled>(_onObscurePasswordToggled);

  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading, errorMessage: null));

    final result = await registerUsecase(
      RegisterParams(
        name: event.name,
        phone: event.phone,
        email: event.email,
        password: event.password,
        city: event.city,
        country: event.country,
        streetAdress: event.streetAdress,
      ),
    );

    await result.fold(
      (failure) async => emit(state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: failure.message,
      )),
      (user) async {
        final local = sl<HandleMulticallLocal>();
        await local.saveLocalData(data: user.accessToken, keyType: LocalEnumKey.accessToken);
        await local.saveLocalData(data: user.refreshToken, keyType: LocalEnumKey.refreshToken);
        await local.saveLocalData(data: user.id, keyType: LocalEnumKey.userId);
        emit(state.copyWith(status: RegisterStatus.success, user: user));
      },
    );
  }
   // visabilty of password
  void _onObscurePasswordToggled(RegisterObscurePasswordToggled event, Emitter<RegisterState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
  Future<void> close() async {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    cityController.dispose();
    countryController.dispose();
    streetController.dispose();
    return super.close();
  }
}