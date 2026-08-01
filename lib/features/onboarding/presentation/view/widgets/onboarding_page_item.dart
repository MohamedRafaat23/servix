import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/onboarding/presentation/models/onboarding_page_data_model.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingPageDataModel page;
  const OnboardingPageItem({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          page.image,
          fit: BoxFit.cover,
        ),

        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black87,
              ],
              stops: [0.5, 1.0],
            ),
          ),
        ),
        Positioned(
          left: 30.width,
          right: 30.width,
          bottom: 180.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                page.title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 8.height),
              Text(
                page.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}