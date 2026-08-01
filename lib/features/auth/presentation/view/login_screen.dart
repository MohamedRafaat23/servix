import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_button.dart';
import 'package:servix/core/widgets/app_text_field.dart';
import 'package:servix/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:servix/features/auth/presentation/bloc/login_bloc/login_event.dart';
import 'package:servix/features/auth/presentation/bloc/login_bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: Builder(
        //Builder create new context to access the bloc instance
        builder: (context) {
          final bloc = context.read<LoginBloc>();
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage ?? AppStrings.unknownError,
                    ),
                  ),
                );
              }
              if (state.status == LoginStatus.success) {
                context.goNamed(AppRoutesNames.navbar);
              }
            },
            child: Scaffold(
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
                        key: bloc.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 40.height),
                            Text(
                              AppStrings.login,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(22),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30.height),
                            AppTextField(
                              title: AppStrings.emailAddress,
                              hint: AppStrings.emailAddress,
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
                            SizedBox(height: 12.height),
                            //password
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.obscurePassword != current.obscurePassword,
                              builder: (context, state) {
                                return AppTextField(
                                  title: AppStrings.password,
                                  hint: AppStrings.enterYourPassword,
                                  controller: bloc.passwordController,
                                  obscureText: state.obscurePassword,
                                  prefexIcon: Icons.lock_outline,
                                  suffixIcon: state.obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  onTapSuffixIcon: () => bloc.add(
                                    const LoginObscurePasswordToggled(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.length < 8) {
                                      return AppStrings.passwordMinLength;
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  context.goNamed(AppRoutesNames.forgotPassword);
                                },
                                child: Text(
                                  AppStrings.forgotPassword,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(13),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.height),
                            //login
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.status != current.status,
                              builder: (context, state) {
                                return AppButton(
                                  text: AppStrings.login,
                                  isLoading: state.status == LoginStatus.loading,
                                  onTap: () {
                                    if (bloc.formKey.currentState?.validate() ??
                                        false) {
                                      bloc.add(
                                        LoginSubmitted(
                                          emailOrPhone: bloc
                                              .identifierController.text,
                                          password:
                                              bloc.passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 16.height),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.dontHaveAccount,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(13),
                                  ),
                                ),
                                //Register 
                                TextButton(
                                  onPressed: () {
                                    context.goNamed(AppRoutesNames.register);
                                  },
                                  child: Text(
                                    AppStrings.signUp,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(13),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
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
          );
        },
      ),
    );
  }
}