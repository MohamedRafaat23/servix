import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Book Service',
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animated success icon
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      builder: (_, val, __) => Transform.scale(
                        scale: val,
                        child: Container(
                          width: 120.width,
                          height: 120.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF60B8FF), Color(0xFF368CE1)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.lightPrimaryColor.withValues(alpha: .3),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 60.width,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.height),
                    Text(
                      'Booking Successful',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(22),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 12.height),
                    Text(
                      "you'll be notified once your request\nupdated",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        color: AppColors.greyColor,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom button
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHorizontalPadding,
                vertical: 16.height,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54.height,
                child: ElevatedButton(
                  onPressed: () {
                    // Pop all booking screens back to the main nav
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightPrimaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.radius),
                    ),
                  ),
                  child: Text(
                    'Track Booking',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
