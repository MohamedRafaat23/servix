import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import '../../../domain/usecases/resend_otp_usecase.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final String email;
  final String phone;
  final OtpVerifyType verifyType;
  final ResendOtpUseCase resendOtpUseCase;
    final otpController = TextEditingController();

  Timer? _timer;

  OtpBloc(
    this.verifyOtpUseCase,
    this.resendOtpUseCase, {
    required this.email,
    required this.phone,
    required this.verifyType,
  }) : super(const OtpState()) {
    on<OtpSubmitted>(_onOtpSubmitted);
    on<OtpResendRequested>(_onOtpResendRequested);
    on<OtpTimerStarted>(_onTimerStarted);
    on<OtpTimerTicked>(_onTimerTicked);

    add(const OtpTimerStarted());
  }

  void _onTimerStarted(OtpTimerStarted event, Emitter<OtpState> emit) {
    _timer?.cancel();
    emit(state.copyWith(secondsLeft: otpCountdownSeconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => add(const OtpTimerTicked()));
  }

  void _onTimerTicked(OtpTimerTicked event, Emitter<OtpState> emit) {
    if (state.secondsLeft == 0) {
      _timer?.cancel();
      return;
    }
    emit(state.copyWith(secondsLeft: state.secondsLeft - 1));
  }

  Future<void> _onOtpSubmitted(OtpSubmitted event, Emitter<OtpState> emit) async {
    emit(state.copyWith(status: OtpStatus.verifying));

    final result = await verifyOtpUseCase(
      VerifyOtpParams(
        email: event.email,
        phone: event.phone,
        otp: event.otp,
        verifyType: event.verifyType,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(status: OtpStatus.failure, errorMessage: failure.message)),
      (token) => emit(state.copyWith(status: OtpStatus.verified, token: token)),
    );
  }

  Future<void> _onOtpResendRequested(OtpResendRequested event, Emitter<OtpState> emit) async {
    emit(state.copyWith(status: OtpStatus.resending));

    final result = await resendOtpUseCase(
      ResendOtpParams(email: event.email, phone: event.phone),
    );

    result.fold(
      (failure) => emit(state.copyWith(status: OtpStatus.failure, errorMessage: failure.message)),
      (_) {
        emit(state.copyWith(status: OtpStatus.resent));
        add(const OtpTimerStarted());
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    otpController.dispose();
    return super.close();
  }
}