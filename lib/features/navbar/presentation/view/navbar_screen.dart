// Asset paths for navigation icons
// Replace these with the real asset paths in your project if different

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/functions/translation.dart';
import 'package:servix/features/favorite/presentaion/view/favorites_screen.dart';
import 'package:servix/features/home/presentaion/view/home_screen.dart';
import 'package:servix/features/navbar/presentation/view/widgets/nav_items.dart';
import 'package:servix/features/order/presentaion/view/orders_screen.dart';
import 'package:servix/features/profile/presentaion/view/profile_screen.dart';
import '../bloc/navbar_bloc.dart';
import '../bloc/navbar_event.dart';
import '../bloc/navbar_state.dart';

class PlaceholderTab extends StatelessWidget {
  final String title;
  const PlaceholderTab(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  static const List<Widget> _pages = [
    HomeScreen(),
    OrdersScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  static const List<String> _iconPaths = [
    AppImages.home,
    AppImages.order,
    AppImages.favorite,
    AppImages.profile,
  ];

  static const List<String> _labelKeys = [
    'home',
    'orders',
    'favorite',
    'profile',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NavbarBloc>(),
      child: BlocBuilder<NavbarBloc, NavbarState>(
        builder: (context, state) {
          final colorScheme = Theme.of(context).colorScheme;
          return Scaffold(
            extendBody: true, // يخلي المحتوى يمتد تحت النافبار العائم
            body: IndexedStack(index: state.currentIndex, children: _pages),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.width,
                  right: 20.width,
                  bottom: 10.height,
                ),
                child: Container(
                  height: context.byDevice(
                    mobilePortrait: 96.height,
                    mobileLandscape: 88.height,
                    tablet: 100.height,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.width,
                    vertical: 4.height,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: .94),
                    borderRadius: BorderRadius.circular(42),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .14),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      final isSelected = state.currentIndex == index;
                      return NavItem(
                        assetPath: _iconPaths[index],
                        label: _labelKeys[index].trans,
                        isSelected: isSelected,
                        onTap: () {
                          context.read<NavbarBloc>().add(
                            NavbarPageChanged(index),
                          );
                        },
                      );
                    }),
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
