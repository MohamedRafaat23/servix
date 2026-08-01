import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_button.dart';
import 'package:servix/core/widgets/app_text_field.dart';
import 'package:servix/features/auth/presentation/bloc/forget_password_bloc/forgetpassword_bloc.dart';
import 'package:servix/features/auth/presentation/bloc/forget_password_bloc/forgetPassword_event.dart';
import 'package:servix/features/auth/presentation/bloc/forget_password_bloc/forgetPassword_state.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ForgetPasswordBloc>(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<ForgetPasswordBloc>();
          return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
            listener: (context, state) {
              if (state.status == ForgetPasswordStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage ?? AppStrings.unknownError,
                    ),
                  ),
                );
              }
              if (state.status == ForgetPasswordStatus.otpSent) {
                context.goNamed(
                  AppRoutesNames.otpScreen,
                  pathParameters: {
                    'flow': OtpVerifyType.forgetPassword.nameStr,
                  },
                  queryParameters: {
                    'email': state.email ?? '',
                    'phone': state.phone ?? '',
                  },
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(),
              body: SafeArea(
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
                    child: Form(
                      key: bloc.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20.height),
                          Text(
                            AppStrings.forgotPassword,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.height),
                          AppTextField(
                            title: AppStrings.emailAddress,
                            hint: AppStrings.enterYourEmailOrNumber,
                            controller: bloc.identifierController,
                            textInputType: TextInputType.emailAddress,
                            prefexIcon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return AppStrings.invalidEmailOrNumber;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 60.height),
                          BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                            buildWhen: (previous, current) =>
                                previous.status != current.status,
                            builder: (context, state) {
                              return AppButton(
                                text: AppStrings.send,
                                isLoading:
                                    state.status ==
                                    ForgetPasswordStatus.sendingOtp,
                                onTap: () {
                                  if (bloc.formKey.currentState?.validate() ??
                                      false) {
                                    bloc.add(
                                      ForgetPasswordRequested(
                                        emailOrPhone:
                                            bloc.identifierController.text,
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
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
