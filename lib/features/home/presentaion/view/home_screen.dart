// lib/features/home/presentation/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/home/presentaion/view/widgets/section_header.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'widgets/category_item.dart';
import 'widgets/home_profile_widget.dart';
import 'widgets/professional_card.dart';
import 'widgets/promo_banner_carousel.dart';
import 'widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
      child: Scaffold(
        body: AppBackground(
          child: SafeArea(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.status == HomeStatus.loading ||
                    state.status == HomeStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == HomeStatus.failure) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? AppStrings.somethingWentWrong,
                    ),
                  );
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
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                      ),
                      children: [
                        SizedBox(height: 8.height),
                        //home profile
                        HomeProfileWidget(
                          name: 'User',
                          address:
                              'London, st12', // هتيجي من بيانات المستخدم الحقيقية
                          onTap: () {
                            // الانتقال لشاشة البروفايل
                          },
                          onNotificationTap: () {
                            //  الانتقال لشاشة الإشعارات
                          },
                        ),
                        SizedBox(height: 16.height),
                        //search
                        SearchWidget(
                          hintText: 'search plumbers, cleaners...',
                          icon: Icons.search,
                          onChanged: (value) {
                            context.read<HomeBloc>().add(
                              HomeSearchQueryChanged(value),
                            );
                          },
                        ),
                        SizedBox(height: 16.height),
                        //bannner
                        PromoBannerCarousel(onBookNow: (banner) {}),
                        SizedBox(height: 24.height),
                        SectionHeader(
                          title: 'categorise',
                          onSeeAll: () {
                            context.pushNamed(
                              AppRoutesNames.services,
                            ); 
                          },
                        ),
                        SizedBox(height: 12.height),
                        Builder(
                          builder: (context) {
                            final filteredCategories = state.categories
                                .where(
                                  (category) =>
                                      category.name.toLowerCase().contains(
                                        state.searchQuery.toLowerCase(),
                                      ),
                                )
                                .toList();
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredCategories.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: context.byDevice(
                                      mobilePortrait: 3,
                                      mobileLandscape: 4,
                                      tablet: 5,
                                    ),
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 0.95,
                                  ),
                              itemBuilder: (context, index) {
                                final category = filteredCategories[index];
                                return CategoryItem(
                                  category: category,
                                  onTap: () {
                                    context.push(
                                      AppRoutesNames.serviceDetails,
                                      extra: category,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 24.height),
                        SectionHeader(
                          title: 'Nearby professionals',
                          onSeeAll: () {},
                        ),
                        SizedBox(height: 12.height),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.professionals
                              .where(
                                (professional) =>
                                    professional.name.toLowerCase().contains(
                                      state.searchQuery.toLowerCase(),
                                    ) ||
                                    professional.profession
                                        .toLowerCase()
                                        .contains(
                                          state.searchQuery.toLowerCase(),
                                        ),
                              )
                              .length,
                          separatorBuilder: (_, __) =>
                              SizedBox(height: 12.height),
                          itemBuilder: (context, index) {
                            final filteredProfessionals = state.professionals
                                .where(
                                  (professional) =>
                                      professional.name.toLowerCase().contains(
                                        state.searchQuery.toLowerCase(),
                                      ) ||
                                      professional.profession
                                          .toLowerCase()
                                          .contains(
                                            state.searchQuery.toLowerCase(),
                                          ),
                                )
                                .toList();
                            return ProfessionalCard(
                              professional: filteredProfessionals[index],
                              onTap: () {
                                context.push(
                                  AppRoutesNames.serviceDetails,
                                  extra: filteredProfessionals[index],
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.height),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
