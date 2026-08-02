import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.lightPrimaryColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: const Color(0xFFEF4444),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Change Password',
            style: TextStyle(
              fontSize: context.responsiveFontScale(18),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
        ),
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
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 16.height,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52.height,
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state.isSubmitting ? null : _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightPrimaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.radius),
                              ),
                            ),
                            child: state.isSubmitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                  )
                                : Text(
                                    'Save',
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(16),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
