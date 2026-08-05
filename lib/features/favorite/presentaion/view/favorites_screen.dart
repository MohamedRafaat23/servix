import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/core/widgets/professional_card.dart';
import 'package:servix/features/favorite/presentaion/bloc/favorite_bloc.dart';
import 'package:servix/features/favorite/presentaion/bloc/favorite_event.dart';
import 'package:servix/features/favorite/presentaion/bloc/favorite_state.dart';
import 'package:servix/features/favorite/presentaion/view/widgets/empty_favorites_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (_) => sl<FavoriteBloc>(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AppBackground(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 12.height),
                // Screen Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveHorizontalPadding,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 40), // Spacer for center alignment
                      Expanded(
                        child: Text(
                          AppStrings.favorite,
                          
                          textAlign: TextAlign.center,
                          style: TextStyle(
                  fontSize: context.responsiveFontScale(20),
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
                SizedBox(height: 16.height),
                // Content Body
                Expanded(
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      if (state.status == FavoriteStatus.loading ||
                          state.status == FavoriteStatus.initial) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == FavoriteStatus.failure) {
                        return Center(
                          child: Text(
                            state.errorMessage ??
                                AppStrings.failedToLoadFavorites,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (state.favorites.isEmpty) {
                        return const EmptyFavoritesWidget();
                      }

                      return Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: context.byDevice(
                              mobilePortrait: double.infinity,
                              mobileLandscape: 700.width,
                              tablet: 900.width,
                            ),
                          ),
                          child: ListView.separated(
                            padding: EdgeInsets.only(
                              left: context.responsiveHorizontalPadding,
                              right: context.responsiveHorizontalPadding,
                              top: 8.height,
                              bottom: 110.height, // Padding for floating navbar
                            ),
                            itemCount: state.favorites.length,
                            separatorBuilder: (_, __) =>
                                SizedBox(height: 16.height),
                            itemBuilder: (context, index) {
                              final professional = state.favorites[index];
                              return ProfessionalCard(
                                professional: professional,
                                isFavoritesCard: true,
                                onFavoriteToggle: () {
                                  context.read<FavoriteBloc>().add(
                                    FavoriteToggleRequested(professional),
                                  );
                                },
                                onTap: () {
                                  context.push(
                                    AppRoutesNames.professionalDetails,
                                    extra: professional,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
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
