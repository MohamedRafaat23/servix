import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';
import 'package:servix/features/profile/presentaion/view/widgets/profile_widgets.dart';
import 'personal_information_screen.dart';
import 'saved_addresses_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(const FetchProfileEvent()),
      child: const _ProfileScreenBody(),
    );
  }
}

class _ProfileScreenBody extends StatelessWidget {
  const _ProfileScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.status == ProfileStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              final profile = state.profile;
              final name = profile?.name ?? 'Khaled Ali';
              final email = profile?.email ?? 'Alikhaled33@gmail.com';
              final notificationsEnabled = profile?.notificationsEnabled ?? false;
              final nightModeEnabled = profile?.nightModeEnabled ?? true;

              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 110.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.height),
                    // ── Title ──────────────────────────────────────────────────
                    Text(
                      AppStrings.profile,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(20),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 20.height),
                    // ── Avatar ─────────────────────────────────────────────────
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.lightPrimaryColor.withValues(alpha: .18),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 44.width,
                            backgroundColor: const Color(0xFFDDE7F0),
                            child: profile?.avatarUrl != null
                                ? Image.network(profile!.avatarUrl!)
                                : Image.asset(AppImages.profile),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.height),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(18),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 4.height),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: AppColors.greyColor,
                      ),
                    ),
                    SizedBox(height: 28.height),

                    // ── Account Section ────────────────────────────────────────
                    const ProfileSectionLabel(label: 'Account'),
                    SizedBox(height: 8.height),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: Icons.person_outline,
                            iconColor: AppColors.lightPrimaryColor,
                            title: 'Personal Information',
                            onTap: () {
                              final bloc = context.read<ProfileBloc>();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: bloc,
                                    child: const PersonalInformationScreen(),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10.height),
                          ProfileMenuItem(
                            icon: Icons.location_on_outlined,
                            iconColor: const Color(0xFFF97316),
                            title: 'Saved Addresses',
                            onTap: () {
                              final bloc = context.read<ProfileBloc>();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: bloc,
                                    child: const SavedAddressesScreen(),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10.height),
                          ProfileMenuItem(
                            icon: Icons.lock_outline,
                            iconColor: AppColors.lightPrimaryColor,
                            title: 'Change Password',
                            onTap: () {
                              final bloc = context.read<ProfileBloc>();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: bloc,
                                    child: const ChangePasswordScreen(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.height),

                    // ── Settings Section ───────────────────────────────────────
                    const ProfileSectionLabel(label: 'Settings'),
                    SizedBox(height: 8.height),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            iconColor: AppColors.lightPrimaryColor,
                            image: AppImages.language,
                            title: 'Language',
                            onTap: () {},
                          ),
                          SizedBox(height: 10.height),
                          ProfileMenuToggle(
                            icon: Icons.notifications_outlined,
                            iconColor: const Color(0xFFF97316),
                            title: 'Notifications',
                            value: notificationsEnabled,
                            onChanged: (v) {
                              context.read<ProfileBloc>().add(ToggleNotificationsProfileEvent(v));
                            },
                          ),
                          SizedBox(height: 10.height),
                          ProfileMenuToggle(
                            icon: Icons.dark_mode_outlined,
                            iconColor: AppColors.lightPrimaryColor,
                            title: 'Night Mode',
                            value: nightModeEnabled,
                            onChanged: (v) {
                              context.read<ProfileBloc>().add(ToggleNightModeProfileEvent(v));
                            },
                          ),
                          SizedBox(height: 10.height),
                          ProfileMenuItem(
                            iconColor: AppColors.lightPrimaryColor,
                            image: AppImages.termsPrivacy,
                            title: 'Terms And Privacy',
                            onTap: () {},
                          ),
                          SizedBox(height: 10.height),
                          ProfileMenuItem(
                            iconColor: const Color(0xFFEF4444),
                            image: AppImages.deleteAccount,
                            title: 'Delete Account',
                            titleColor: const Color(0xFFEF4444),
                            onTap: () => _showDeleteAccountDialog(context),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28.height),

                    // ── Logout Button ──────────────────────────────────────────
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52.height,
                        child: ElevatedButton.icon(
                          onPressed: () => _showLogoutDialog(context),
                          icon: const Icon(Icons.logout_rounded, color: Colors.white),
                          label: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightPrimaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.radius),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightPrimaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Account', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEF4444))),
        content: const Text('This action is permanent and cannot be undone. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
