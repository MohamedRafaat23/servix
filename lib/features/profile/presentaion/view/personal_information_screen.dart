import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/core/widgets/app_text_field.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';
import 'package:servix/features/profile/presentaion/view/widgets/profile_appbar.dart';
import 'widgets/profile_avatar_editable.dart';
import 'widgets/profile_feedback_listener.dart';
import 'widgets/profile_save_button.dart';
import 'widgets/profile_widgets.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        showProfileFeedback(
          context,
          successMessage: state.successMessage,
          errorMessage: state.errorMessage,
        );
      },
      child: Scaffold(
        appBar:  ProfileAppBar(title: AppStrings.profile, ),
        body: AppBackground(
          child: Form(
            key: bloc.profileFormKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
                    child: Column(
                      children: [
                        SizedBox(height: 24.height),
                        const ProfileAvatarEditable(),
                        SizedBox(height: 8.height),
                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: bloc.nameCtrl,
                          builder: (context, value, _) {
                            return Text(
                              value.text,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(17),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E293B),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 2.height),
                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: bloc.emailCtrl,
                          builder: (context, value, _) {
                            return Text(
                              value.text,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                color: AppColors.greyColor,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 32.height),
                         ProfileFieldLabel(label: AppStrings.fullName),
                        SizedBox(height: 8.height),
                        AppTextField(
                          controller: bloc.nameCtrl,
                          hint: AppStrings.enterYourFullName,
                          prefexIcon: Icons.person_outline,
                          validator: (v) => (v == null || v.trim().isEmpty) ? AppStrings.nameRequired : null,
                        ),
                        SizedBox(height: 20.height),
                         ProfileFieldLabel(label: AppStrings.email),
                        SizedBox(height: 8.height),
                        AppTextField(
                          controller: bloc.emailCtrl,
                          hint: AppStrings.enterYourEmail,
                          prefexIcon: Icons.email_outlined,
                          textInputType: TextInputType.emailAddress,
                          validator: (v) => (v == null || v.trim().isEmpty) ? AppStrings.emailErrorEmpty : null,
                        ),
                        SizedBox(height: 32.height),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return ProfileSaveButton(
                      isSubmitting: state.isSubmitting,
                      onTap: () {
                        if (!bloc.profileFormKey.currentState!.validate()) return;
                        bloc.add(const UpdateProfileInformationEvent());
                      },
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