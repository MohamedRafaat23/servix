import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';
import 'package:servix/features/profile/presentaion/view/widgets/profile_appbar.dart';
import 'widgets/profile_feedback_listener.dart';
import 'widgets/profile_save_button.dart';
import 'widgets/profile_widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPassCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  bool _showOld = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _oldPassCtrl.dispose();
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileBloc>().add(
          ChangeUserPasswordEvent(
            oldPassword: _oldPassCtrl.text,
            newPassword: _newPassCtrl.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          _oldPassCtrl.clear();
          _newPassCtrl.clear();
          _confirmPassCtrl.clear();
        }
        showProfileFeedback(
          context,
          successMessage: state.successMessage,
          errorMessage: state.errorMessage,
        );
      },
      child: Scaffold(
        appBar: const ProfileAppBar(title: 'Change Password'),
        body: AppBackground(
          child: Form(
            key: _formKey,
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
                        const ProfileFieldLabel(label: 'Old Password'),
                        SizedBox(height: 8.height),
                        ProfileTextField(
                          controller: _oldPassCtrl,
                          hintText: 'Enter your old password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: !_showOld,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showOld ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.greyColor,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _showOld = !_showOld),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Old password is required';
                            return null;
                          },
                        ),
                        SizedBox(height: 20.height),
                        const ProfileFieldLabel(label: 'New Password'),
                        SizedBox(height: 8.height),
                        ProfileTextField(
                          controller: _newPassCtrl,
                          hintText: 'Enter your new password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: !_showNew,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showNew ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.greyColor,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _showNew = !_showNew),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'New password is required';
                            if (v.length < 6) return 'Password must be at least 6 characters';
                            return null;
                          },
                        ),
                        SizedBox(height: 20.height),
                        const ProfileFieldLabel(label: 'Confirm Password'),
                        SizedBox(height: 8.height),
                        ProfileTextField(
                          controller: _confirmPassCtrl,
                          hintText: 'Confirm your password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: !_showConfirm,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.greyColor,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _showConfirm = !_showConfirm),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Please confirm your password';
                            if (v != _newPassCtrl.text) return 'Passwords do not match';
                            return null;
                          },
                        ),
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