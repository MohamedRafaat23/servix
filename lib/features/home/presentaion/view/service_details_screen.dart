import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import 'package:servix/features/home/domain/entites/category_entity.dart';
import 'package:servix/features/home/presentaion/bloc/home_bloc.dart';
import 'package:servix/features/home/presentaion/bloc/home_event.dart';
import 'package:servix/features/home/presentaion/bloc/home_state.dart';
import 'package:servix/features/home/presentaion/view/widgets/professional_card.dart';
import 'package:servix/features/home/presentaion/view/widgets/search_widget.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final CategoryEntity category;

  const ServiceDetailsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            category.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
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
                  return Center(child: Text(state.errorMessage ?? AppStrings.somethingWentWrong));
                }

                final filteredProfessionals = state.professionals.where((professional) {
                  final query = state.searchQuery.toLowerCase();
                  return query.isEmpty ||
                      professional.name.toLowerCase().contains(query) ||
                      professional.profession.toLowerCase().contains(query);
                }).toList();

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
                          SearchWidget(
                            hintText: AppStrings.searchProfessionals,
                            icon: Icons.search,
                            onChanged: (value) {
                              context.read<HomeBloc>().add(HomeSearchQueryChanged(value));
                            },
                          ),
                          SizedBox(height: 16.height),
                          Text(
                            AppStrings.topProfessionals.replaceFirst('\$category.name', category.name),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.responsiveFontScale(18),
                            ),
                          ),
                          SizedBox(height: 10.height),
                          Expanded(
                            child: filteredProfessionals.isEmpty
                                ? Center(
                                    child: Text(
                                      AppStrings.somethingWentWrong,
                                      style: TextStyle(fontSize: context.responsiveFontScale(14)),
                                    ),
                                  )
                                : ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: filteredProfessionals.length,
                                    separatorBuilder: (_, __) => SizedBox(height: 12.height),
                                    itemBuilder: (context, index) {
                                      return ProfessionalCard(
                                        professional: filteredProfessionals[index],
                                        onTap: () {
                                          context.pushNamed(
                                            AppRoutesNames.professionalDetails, // ← كانت serviceDetails غلط
                                            extra: filteredProfessionals[index],
                                          );
                                        },
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(height: 12.height),
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