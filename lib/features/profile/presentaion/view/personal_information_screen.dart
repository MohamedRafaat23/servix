import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';
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
        if (state.successMessage != null) {
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
            'Personal Information',
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
                    padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
                    child: Column(
                      children: [
                        SizedBox(height: 24.height),
                        // ── Avatar with edit badge ──────────────────────────
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.lightPrimaryColor.withValues(alpha: .15),
                                    blurRadius: 20,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 48.width,
                                backgroundColor: const Color(0xFFDDE7F0),
                                child: Image.asset(AppImages.profile),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 28.width,
                                height: 28.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF97316),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.edit, color: Colors.white, size: 14.width),
                              ),
                            ),
                          ],
                        ),
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
