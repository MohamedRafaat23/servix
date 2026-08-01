import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_button.dart';
import 'package:servix/core/widgets/app_text_field.dart';
import 'package:servix/features/auth/presentation/bloc/forget_password_bloc/forgetpassword_bloc.dart';
import 'package:servix/features/auth/presentation/bloc/forget_password_bloc/forgetPassword_event.dart';
import 'package:servix/features/auth/presentation/bloc/forget_password_bloc/forgetPassword_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key, required this.resetToken});

  final String resetToken;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ForgetPasswordBloc>(),
      child: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) {
          if (state.status == ForgetPasswordStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? AppStrings.unknownError)),
            );
          }
          if (state.status == ForgetPasswordStatus.resetSuccess) {
            context.goNamed(AppRoutesNames.login);
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20.height),
                        Text(
                          AppStrings.resetPassword,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.height),
                        AppTextField(
                          title: AppStrings.newPassword,
                          hint: AppStrings.enterYourNewPassword,
                          controller: _passwordController,
                          obscureText: true,
                          prefexIcon: Icons.lock_outline,
                          validator: (v) => (v == null || v.length < 8)
                              ? AppStrings.passwordMinLength
                              : null,
                        ),
                        SizedBox(height: 12.height),
                        AppTextField(
                          title: AppStrings.confirmPassword,
                          hint: AppStrings.newPassword,
                          controller: _confirmPasswordController,
                          obscureText: true,
                          prefexIcon: Icons.lock_outline,
                          validator: (v) => (v != _passwordController.text)
                              ? AppStrings.passwordsMustMatch
                              : null,
                        ),
                        SizedBox(height: 24.height),
                        BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return AppButton(
                              text: AppStrings.submit,
                              isLoading:
                                  state.status == ForgetPasswordStatus.resetting,
                              onTap: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  context.read<ForgetPasswordBloc>().add(
                                        ResetPasswordSubmitted(
                                          resetToken: resetToken,
                                          newPassword: _passwordController.text,
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
        ),
      ),
    );
  }
}