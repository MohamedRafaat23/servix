import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/forget_password_usecase.dart';
import '../../../domain/usecases/reset_password_usecase.dart';
import 'forgetPassword_event.dart';
import 'forgetPassword_state.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final formKey = GlobalKey<FormState>();
  final identifierController = TextEditingController();
  ForgetPasswordBloc(
    this.forgetPasswordUseCase,
    this.resetPasswordUseCase,
  ) : super(const ForgetPasswordState()) {
    on<ForgetPasswordRequested>(_onForgetPasswordRequested);
    on<ResetPasswordSubmitted>(_onResetPasswordSubmitted);
  }

  Future<void> _onForgetPasswordRequested(
    ForgetPasswordRequested event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    final identifier = event.emailOrPhone.trim();
    final split = _splitIdentifier(identifier);

    emit(state.copyWith(
      status: ForgetPasswordStatus.sendingOtp,
      errorMessage: null,
    ));

    final result = await forgetPasswordUseCase(
      ForgetPasswordParams(email: split.email, phone: split.phone),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: ForgetPasswordStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        status: ForgetPasswordStatus.otpSent,
        email: split.email,
        phone: split.phone,
      )),
    );
  }

  Future<void> _onResetPasswordSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(state.copyWith(
      status: ForgetPasswordStatus.resetting,
      errorMessage: null,
    ));

    final result = await resetPasswordUseCase(
      ResetPasswordParams(
        resetToken: event.resetToken,
        newPassword: event.newPassword,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: ForgetPasswordStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: ForgetPasswordStatus.resetSuccess)),
    );
  }

  _Identifier _splitIdentifier(String identifier) {
    if (identifier.contains('@')) {
      return _Identifier(email: identifier, phone: '');
    }
    return _Identifier(email: '', phone: identifier);
  }
  @override
Future<void> close() {
  identifierController.dispose();
  return super.close();
}
}

class _Identifier {
  final String email;
  final String phone;
  _Identifier({required this.email, required this.phone});
}


