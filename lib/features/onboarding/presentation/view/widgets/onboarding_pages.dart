import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/features/onboarding/presentation/models/onboarding_page_data_model.dart';

List<OnboardingPageDataModel> get onboardingPages => [
      OnboardingPageDataModel(
        title: AppStrings.onBoardingTitle1,
        description: AppStrings.onBoardingDesc1,
        image: AppImages.onBoarding1,
      ),
      OnboardingPageDataModel(
        title: AppStrings.onBoardingTitle2,
        description: AppStrings.onBoardingDesc2,
        image: AppImages.onBoarding2,
      ),
      OnboardingPageDataModel(
        title: AppStrings.onBoardingTitle3,
        description: AppStrings.onBoardingDesc3,
        image: AppImages.onBoarding3,
      ),
    ];