import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/config/router/app_routes_names.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/utils/functions/router_handler.dart';
import 'package:servix/core/widgets/app_button.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import 'widgets/onboarding_page_indicator.dart';
import 'widgets/onboarding_page_item.dart';
import 'widgets/onboarding_pages.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _finish(BuildContext context) {
    context.read<OnboardingBloc>().add(const OnboardingCompleted());
    RouterHandler.navigate(
      context,
      AppRoutesNames.login,
      routerType: RouterType.goAndPopAll,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingBloc>(),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            final pageController = context
                .read<OnboardingBloc>()
                .pageController;
            final isLastPage = state.currentPage == onboardingPages.length - 1;

            return Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: onboardingPages.length,
                  onPageChanged: (index) {
                    context.read<OnboardingBloc>().add(
                      OnboardingPageChanged(index),
                    );
                  },
                  itemBuilder: (context, index) {
                    return OnboardingPageItem(page: onboardingPages[index]);
                  },
                ),
                SafeArea(
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.width,
                        vertical: 8.height,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.width,
                          vertical: 6.height,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black.withValues(alpha: 0.35),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () => _finish(context),
                          child: Text(
                            AppStrings.skip,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.width,
                        vertical: 16.height,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OnboardingPageIndicator(
                            pageCount: onboardingPages.length,
                            currentPage: state.currentPage,
                          ),
                          SizedBox(height: 20.height),
                          AppButton(
                            text: isLastPage
                                ? AppStrings.onboardingGetStarted
                                : AppStrings.next,
                            onTap: () {
                              if (isLastPage) {
                                _finish(context);
                              } else {
                                context.read<OnboardingBloc>().add(
                                  const OnboardingNextPageRequested(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
