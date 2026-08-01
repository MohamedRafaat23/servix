import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/utils/functions/router_handler.dart';
import 'package:servix/core/widgets/app_button.dart';
import 'package:servix/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:servix/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:servix/features/auth/presentation/bloc/otp_bloc/otp_bloc.dart';
import 'package:servix/features/auth/presentation/bloc/otp_bloc/otp_event.dart';
import 'package:servix/features/auth/presentation/bloc/otp_bloc/otp_state.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final String phone;
  final OtpVerifyType verifyType;

  const OtpScreen({
    super.key,
    required this.email,
    required this.phone,
    required this.verifyType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpBloc(
        sl<VerifyOtpUseCase>(),
        sl<ResendOtpUseCase>(),
        email: email,
        phone: phone,
        verifyType: verifyType,
      ),
      child: Builder(
        builder: (context) {
          final bloc = context.read<OtpBloc>();
          return BlocListener<OtpBloc, OtpState>(
            listener: (context, state) {
              if (state.status == OtpStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? AppStrings.somethingWentWrong),
                  ),
                );
              }
              if (state.status == OtpStatus.resent) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppStrings.resendCode)),
                );
              }
              if (state.status == OtpStatus.verified) {
                if (bloc.verifyType == OtpVerifyType.forgetPassword) {
                  RouterHandler.navigate(
                    context,
                    AppRoutesNames.resetPassword,
                    routerType: RouterType.goName,
                    queryParameters: {'resetToken': state.token ?? ''},
                  );
                } else {
                  RouterHandler.navigate(
                    context,
                    AppRoutesNames.navbar,
                    routerType: RouterType.goAndPopAll,
                  );
                }
              }
            },
            child: Scaffold(
              appBar: AppBar(),
              body: SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.byDevice(
                        mobilePortrait: double.infinity,
                        mobileLandscape: 500.width,
                        tablet: 480.width,
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.height),
                          Text(
                            AppStrings.otpVerification,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.height),
                          Container(
                            width: 64.width,
                            height: 64.width,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF358BE0),
                            ),
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 30.width,
                            ),
                          ),
                          SizedBox(height: 16.height),
                          Text(
                            AppStrings.otpSentMessage(
                              bloc.email.isNotEmpty ? bloc.email : bloc.phone,
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: context.responsiveFontScale(14)),
                          ),
                          SizedBox(height: 8.height),
                          BlocBuilder<OtpBloc, OtpState>(
                            buildWhen: (previous, current) =>
                                previous.secondsLeft != current.secondsLeft,
                            builder: (context, state) {
                              return Text(
                                state.formattedTime,
                                style: TextStyle(
                                  color: const Color(0xFF358BE0),
                                  fontSize: context.responsiveFontScale(14),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20.height),
                          Pinput(
                            length: 5,
                            controller: bloc.otpController,
                            defaultPinTheme: PinTheme(
                              width: 48.width,
                              height: 48.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              width: 48.width,
                              height: 48.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFF358BE0)),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.height),
                          BlocBuilder<OtpBloc, OtpState>(
                            buildWhen: (previous, current) =>
                                previous.secondsLeft != current.secondsLeft,
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.dontReceiveCode,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(13),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: state.canResend
                                        ? () => bloc.add(
                                              OtpResendRequested(
                                                email: bloc.email,
                                                phone: bloc.phone,
                                              ),
                                            )
                                        : null,
                                    child: Text(
                                      AppStrings.resendCode,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: context.responsiveFontScale(13),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 20.height),
                          BlocBuilder<OtpBloc, OtpState>(
                            buildWhen: (previous, current) =>
                                previous.status != current.status,
                            builder: (context, state) {
                              return AppButton(
                                text: AppStrings.verifyOtp,
                                isLoading: state.status == OtpStatus.verifying,
                                onTap: () {
                                  if (bloc.otpController.text.length == 5) {
                                    bloc.add(
                                      OtpSubmitted(
                                        email: bloc.email,
                                        phone: bloc.phone,
                                        otp: bloc.otpController.text,
                                        verifyType: bloc.verifyType,
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20.height),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}