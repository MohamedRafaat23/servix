import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/config/app_controller/app_controller_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_bloc.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_event.dart';
import 'package:servix/features/profile/presentaion/bloc/profile_state.dart';
import 'package:servix/features/profile/presentaion/view/widgets/confirm_dialog.dart';
import 'package:servix/features/profile/presentaion/view/widgets/language_sheet.dart';
import 'package:servix/features/profile/presentaion/view/widgets/profile_menu_item.dart';
import 'package:servix/features/profile/presentaion/view/widgets/profile_menu_toggle.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
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
              final notificationsEnabled =
                  profile?.notificationsEnabled ?? false;
              final nightModeEnabled = context.select(
                (AppControllerBloc bloc) => bloc.state.isDarkMode,
              );

              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 110.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.height),
                    Text(
                      AppStrings.profile,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(20),
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 20.height),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withValues(
                                  alpha: .18,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 44.width,
                            backgroundColor: colorScheme.surface,
                            child: profile?.avatarUrl != null
                                ? Image.network(profile!.avatarUrl!)
                                : SvgPicture.asset(AppImages.profile),
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
                        color: colorScheme.onSurface,
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
                    ProfileSectionLabel(label: AppStrings.account),
                    SizedBox(height: 8.height),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                      ),
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            image: AppImages.profile,
                            title: AppStrings.personalInformation,
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
                            image: AppImages.location,
                            title: AppStrings.savedAddresses,
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
                            image: AppImages.lock,
                            title: AppStrings.changePassword,
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
                    //  Settings Section
                    ProfileSectionLabel(label: AppStrings.settingsSection),
                    SizedBox(height: 8.height),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                      ),
                      child: Column(
                        children: [
                          ProfileMenuItem(
                              image: AppImages.language,
                              title: AppStrings.language,
                              onTap: () async {
                                final newCode = await showLanguageSheet(context);
                                if (newCode == null || !context.mounted) return;

                                await context.setLocale(Locale(newCode));
                                if (!context.mounted) return;

                                context.read<ProfileBloc>().add(LanguageProfileEvent(newCode));
                              },
                            ),
                          SizedBox(height: 10.height),
                          ProfileMenuToggle(
                            image: AppImages.notification,
                            title: AppStrings.notifications,
                            value: notificationsEnabled,
                            onChanged: (v) {
                              context.read<ProfileBloc>().add(
                                ToggleNotificationsProfileEvent(v),
                              );
                            },
                          ),
                          SizedBox(height: 10.height),
                          ProfileMenuToggle(
                            iconColor: colorScheme.primary,
                            image: AppImages.nightIcon,
                            title: AppStrings.nightMode,
                            value: nightModeEnabled,
                            onChanged: (v) {
                              context.read<AppControllerBloc>().add(
                                SetThemeEvent(v),
                              );
                            },
                          ),
                          SizedBox(height: 10.height),
                          ProfileMenuItem(
                            image: AppImages.termsPrivacy,
                            title: AppStrings.termsAndPrivacy,
                            onTap: () {},
                          ),
                          SizedBox(height: 10.height),
                          ProfileMenuItem(
                            image: AppImages.deleteAccount,
                            title: AppStrings.deleteAccount,
                            titleColor: const Color(0xFFEF4444),
                            onTap: () => _showDeleteAccountDialog(context),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28.height),
                    //  Logout Button
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52.height,
                        child: ElevatedButton.icon(
                          onPressed: () => _showLogoutDialog(context),
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                          ),
                          label: Text(
                            AppStrings.logout,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
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
    showConfirmDialog(
      context,
      title: AppStrings.logout,
      content: AppStrings.logoutConfirmMessage,
      confirmLabel: AppStrings.logout,
      onConfirm: () {
        Navigator.pop(context);
        //todo:delete token from HandleMulticallLocal then context.goNamed(login))
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showConfirmDialog(
      context,
      title: AppStrings.deleteAccountConfirmTitle,
      content: AppStrings.thisActionIsPermanentAndCannotBeUndoneAreYouSure,
      confirmLabel: AppStrings.deleteAccount,
      confirmColor: const Color(0xFFEF4444),
      titleColor: const Color(0xFFEF4444),
      onConfirm: () {
        Navigator.pop(context);
        // TODO: delete acc
      },
    );
  }
}
