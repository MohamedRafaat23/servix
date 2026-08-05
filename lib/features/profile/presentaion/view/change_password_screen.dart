import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/core/widgets/app_text_field.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';
import 'package:servix/features/profile/presentaion/view/widgets/profile_appbar.dart';
import 'widgets/profile_feedback_listener.dart';
import 'widgets/profile_save_button.dart';
import 'widgets/profile_widgets.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  void _save(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    if (!bloc.changePasswordFormKey.currentState!.validate()) return;
    bloc.add(
      ChangeUserPasswordEvent(
        oldPassword: bloc.oldPassCtrl.text,
        newPassword: bloc.newPassCtrl.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          bloc.oldPassCtrl.clear();
          bloc.newPassCtrl.clear();
          bloc.confirmPassCtrl.clear();
        }
        showProfileFeedback(
          context,
          successMessage: state.successMessage,
          errorMessage: state.errorMessage,
        );
      },
      child: Scaffold(
        appBar:  ProfileAppBar(title: AppStrings.changePassword),
        body: AppBackground(
          child: Form(
            key: bloc.changePasswordFormKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 24.height,
                    ),
                    child: Column(
                      children: [
                         ProfileFieldLabel(label: AppStrings.oldPassword),
                        SizedBox(height: 8.height),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          buildWhen: (p, c) => p.obscureOldPassword != c.obscureOldPassword,
                          builder: (context, state) {
                            return AppTextField(
                              controller: bloc.oldPassCtrl,
                              hint: AppStrings.enterYourOldPassword,
                              prefexIcon: Icons.lock_outline,
                              obscureText: state.obscureOldPassword,
                              suffixIconWidget: IconButton(
                                icon: Icon(
                                  state.obscureOldPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: colorScheme.onSurface.withValues(alpha: .65),
                                  size: 20,
                                ),
                                onPressed: () => bloc.add(
                                  const ChangePasswordObscureToggled(PasswordFieldType.old),
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) return AppStrings.oldpasswordIsRequired;
                                return null;
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.height),
                         ProfileFieldLabel(label:AppStrings.newPassword,),
                        SizedBox(height: 8.height),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          buildWhen: (p, c) => p.obscureNewPassword != c.obscureNewPassword,
                          builder: (context, state) {
                            return AppTextField(
                              controller: bloc.newPassCtrl,
                              hint: AppStrings.newPassword,
                              prefexIcon: Icons.lock_outline,
                              obscureText: state.obscureNewPassword,
                              suffixIconWidget: IconButton(
                                icon: Icon(
                                  state.obscureNewPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: colorScheme.onSurface.withValues(alpha: .65),
                                  size: 20,
                                ),
                                onPressed: () => bloc.add(
                                  const ChangePasswordObscureToggled(PasswordFieldType.newPass),
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) return AppStrings.enterYourNewPassword;
                                if (v.length < 6) return AppStrings.password8Characters;
                                return null;
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.height),
                         ProfileFieldLabel(label: AppStrings.confirmPassword),
                        SizedBox(height: 8.height),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          buildWhen: (p, c) => p.obscureConfirmPassword != c.obscureConfirmPassword,
                          builder: (context, state) {
                            return AppTextField(
                              controller: bloc.confirmPassCtrl,
                              hint: AppStrings.confirmPassword,
                              prefexIcon: Icons.lock_outline,
                              obscureText: state.obscureConfirmPassword,
                              suffixIconWidget: IconButton(
                                icon: Icon(
                                  state.obscureConfirmPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: colorScheme.onSurface.withValues(alpha: .65),
                                  size: 20,
                                ),
                                onPressed: () => bloc.add(
                                  const ChangePasswordObscureToggled(PasswordFieldType.confirm),
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Please confirm your password';
                                if (v != bloc.newPassCtrl.text) return 'Passwords do not match';
                                return null;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (p, c) => p.isSubmitting != c.isSubmitting,
                  builder: (context, state) {
                    return ProfileSaveButton(
                      isSubmitting: state.isSubmitting,
                      onTap: () => _save(context),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
