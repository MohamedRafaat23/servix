import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/functions/translation.dart';
import '../bloc/navbar_bloc.dart';
import '../bloc/navbar_event.dart';
import '../bloc/navbar_state.dart';

class _PlaceholderTab extends StatelessWidget {
  final String title;
  const _PlaceholderTab(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(title)),
    );
  }
}

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  static const List<Widget> _pages = [
    _PlaceholderTab('Home'),
    _PlaceholderTab('Orders'),
    _PlaceholderTab('Favorites'),
    _PlaceholderTab('Profile'),
  ];

  Widget _navIcon(String assetPath, bool isSelected) {
    return Image.asset(
      assetPath,
      width: 24,
      height: 24,
      color: isSelected ? AppColors.primaryColor : AppColors.greyColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NavbarBloc>(),
      child: BlocBuilder<NavbarBloc, NavbarState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: _pages,
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: state.currentIndex,
              height: context.byDevice(
                mobilePortrait: 64.height,
                mobileLandscape: 60.height,
                tablet: 72.height,
              ),
              onDestinationSelected: (index) {
                context.read<NavbarBloc>().add(NavbarPageChanged(index));
              },
              backgroundColor: AppColors.whiteColor,
              destinations: [
                NavigationDestination(
                  icon: _navIcon(AppImages.home, false),
                  selectedIcon: _navIcon(AppImages.home, true),
                  label: 'home'.trans,
                ),
                NavigationDestination(
                  icon: _navIcon(AppImages.order, false),
                  selectedIcon: _navIcon(AppImages.order, true),
                  label: 'orders'.trans,
                ),
                NavigationDestination(
                  icon: _navIcon(AppImages.favorite, false),
                  selectedIcon: _navIcon(AppImages.favorite, true),
                  label: 'favorites'.trans,
                ),
                NavigationDestination(
                  icon: _navIcon(AppImages.profile, false),
                  selectedIcon: _navIcon(AppImages.profile, true),
                  label: 'profile'.trans,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}