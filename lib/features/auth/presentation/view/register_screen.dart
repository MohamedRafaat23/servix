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
import 'package:servix/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:servix/features/auth/presentation/bloc/register_bloc/register_event.dart';
import 'package:servix/features/auth/presentation/bloc/register_bloc/register_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterBloc>(),
      child: Builder(
        //Builder create new context to access the bloc instance
        builder: (context) {
          final bloc = context.read<RegisterBloc>();
          return BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state.status == RegisterStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage ?? AppStrings.unknownError)),
                );
              }
              if (state.status == RegisterStatus.success) {
                context.goNamed(
                  AppRoutesNames.otpScreen,
                  pathParameters: {
                    'flow': OtpVerifyType.register.nameStr,
                  },
                  queryParameters: {
                    'email': bloc.emailController.text,
                    'phone': bloc.phoneController.text,
                  },
                );
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
                        key: bloc.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 10.height),
                            Text(
                              AppStrings.signUp,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(22),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 24.height),
                            AppTextField(
                              title: AppStrings.fullName,
                              hint: AppStrings.fullName,
                              controller: bloc.nameController,
                              prefexIcon: Icons.person_outline,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? AppStrings.nameRequired
                                  : null,
                            ),
                            SizedBox(height: 12.height),
                            AppTextField(
                              title: AppStrings.emailAddress,
                              hint: AppStrings.enterYourEmail,
                              controller: bloc.emailController,
                              textInputType: TextInputType.emailAddress,
                              prefexIcon: Icons.email_outlined,
                              validator: (v) => (v == null || !v.contains('@'))
                                  ? AppStrings.invalidEmail
                                  : null,
                            ),
                            SizedBox(height: 12.height),
                            AppTextField(
                              title: AppStrings.phoneNumber,
                              hint: AppStrings.phoneNumber,
                              controller: bloc.phoneController,
                              textInputType: TextInputType.phone,
                              prefexIcon: Icons.phone_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? AppStrings.phoneRequired
                                  : null,
                            ),
                            SizedBox(height: 12.height),
                            BlocBuilder<RegisterBloc, RegisterState>(
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
                                    const RegisterObscurePasswordToggled(),
                                  ),
                                  validator: (v) => (v == null || v.length < 8)
                                      ? AppStrings.passwordMinLength
                                      : null,
                                );
                              },
                            ),
                            SizedBox(height: 12.height),
                            BlocBuilder<RegisterBloc, RegisterState>(
                              buildWhen: (previous, current) =>
                                  previous.obscurePassword != current.obscurePassword,
                              builder: (context, state) {
                                return AppTextField(
                                  title: AppStrings.confirmPassword,
                                  hint: AppStrings.enterYourPassword,
                                  controller: bloc.confirmPasswordController,
                                  obscureText: state.obscurePassword,
                                  prefexIcon: Icons.lock_outline,
                                  suffixIcon: state.obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  onTapSuffixIcon: () => bloc.add(
                                    const RegisterObscurePasswordToggled(),
                                  ),
                                  validator: (v) => (v != bloc.passwordController.text)
                                      ? AppStrings.passwordsMustMatch
                                      : null,
                                );
                              },
                            ),
                            SizedBox(height: 12.height),
                            AppTextField(
                              title: AppStrings.city,
                              hint: AppStrings.country,
                              controller: bloc.cityController,
                              prefexIcon: Icons.location_city_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? AppStrings.cityRequired
                                  : null,
                            ),
                            SizedBox(height: 12.height),
                            AppTextField(
                              title: AppStrings.country,
                              hint: AppStrings.city,
                              controller: bloc.countryController,
                              prefexIcon: Icons.public_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? AppStrings.countryRequired
                                  : null,
                            ),
                            SizedBox(height: 12.height),
                            AppTextField(
                              title: AppStrings.streetAddress,
                              hint: AppStrings.streetAddress,
                              controller: bloc.streetController,
                              prefexIcon: Icons.home_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? AppStrings.streetAddressRequired
                                  : null,
                            ),
                            SizedBox(height: 24.height),
                            BlocBuilder<RegisterBloc, RegisterState>(
                              buildWhen: (previous, current) =>
                                  previous.status != current.status,
                              builder: (context, state) {
                                return AppButton(
                                  text: AppStrings.signUp,
                                  isLoading: state.status == RegisterStatus.loading,
                                  onTap: () {
                                    if (bloc.formKey.currentState?.validate() ?? false) {
                                      bloc.add(
                                        RegisterSubmitted(
                                          name: bloc.nameController.text,
                                          phone: bloc.phoneController.text,
                                          email: bloc.emailController.text,
                                          password: bloc.passwordController.text,
                                          city: bloc.cityController.text,
                                          country: bloc.countryController.text,
                                          streetAdress: bloc.streetController.text,
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
                                  AppStrings.alreadyHaveAccount,
                                  style: TextStyle(fontSize: context.responsiveFontScale(13)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.goNamed(AppRoutesNames.login);
                                  },
                                  child: Text(
                                    AppStrings.login,
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