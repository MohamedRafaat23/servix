import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';
import 'package:servix/features/profile/presentaion/view/widgets/profile_appbar.dart';
import 'widgets/profile_avatar_editable.dart';
import 'widgets/profile_feedback_listener.dart';
import 'widgets/profile_save_button.dart';
import 'widgets/profile_widgets.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileBloc>().state.profile;
    _nameCtrl = TextEditingController(text: profile?.name ?? 'Khaled Ali');
    _emailCtrl = TextEditingController(text: profile?.email ?? 'Alikhaled33@gmail.com');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileBloc>().add(
          UpdateProfileInformationEvent(
            name: _nameCtrl.text.trim(),
            email: _emailCtrl.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        showProfileFeedback(
          context,
          successMessage: state.successMessage,
          errorMessage: state.errorMessage,
        );
      },
      child: Scaffold(
        appBar: const ProfileAppBar(title: 'Personal Information'),
        body: AppBackground(
          child: Form(
            key: _formKey,
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
                          valueListenable: _nameCtrl,
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
                          valueListenable: _emailCtrl,
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
                        const ProfileFieldLabel(label: 'full name'),
                        SizedBox(height: 8.height),
                        ProfileTextField(
                          controller: _nameCtrl,
                          hintText: 'Enter your full name',
                          prefixIcon: Icons.person_outline,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                        ),
                        SizedBox(height: 20.height),
                        const ProfileFieldLabel(label: 'Email address'),
                        SizedBox(height: 8.height),
                        ProfileTextField(
                          controller: _emailCtrl,
                          hintText: 'Enter your email or number',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Email is required' : null,
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
                      onTap: _save,
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