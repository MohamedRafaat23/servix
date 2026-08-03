import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'widgets/category_item.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(AppStrings.services),
          centerTitle: true,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: AppBackground(
          child: SafeArea(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.status == HomeStatus.loading || state.status == HomeStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == HomeStatus.failure) {
                  return Center(child: Text(state.errorMessage ?? 'Something went wrong'));
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.height),
                          Text(
                            AppStrings.allservices,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.responsiveFontScale(18),
                            ),
                          ),
                          SizedBox(height: 14.height),
                          Expanded(
                            child: GridView.builder(
                              itemCount: state.categories.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: context.byDevice(
                                  mobilePortrait: 2,
                                  mobileLandscape: 3,
                                  tablet: 4,
                                ),
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 1.5,
                              ),
                              itemBuilder: (context, index) {
                                final category = state.categories[index];
                                return CategoryItem(
                                  category: category,
                                  onTap: () {
                                    context.pushNamed(AppRoutesNames.serviceDetails, extra: category);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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