import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class BookingStepIndicator extends StatelessWidget {
  final int currentStep; // 1, 2, or 3
  const BookingStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const labels = [
      'Select your location',
      'Choose your appointment',
      'Confirm Booking',
    ];
    return Column(
      children: [
        Row(
          children: List.generate(3, (i) {
            final step = i + 1;
            final isActive = step == currentStep;
            final isDone = step < currentStep;
            return Expanded(
              child: Row(
                children: [
                  Container(
                    width: 24.width,
                    height: 24.width,
                    decoration: BoxDecoration(
                      color: (isActive || isDone)
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isDone
                          ? Icon(Icons.check, color: Colors.white, size: 14.width)
                          : Text(
                              '$step',
                              style: TextStyle(
                            color: isActive ? colorScheme.onPrimary : colorScheme.onSurface,
                                fontSize: context.responsiveFontScale(11),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  if (i < 2)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isDone
                            ? colorScheme.primary
                            : colorScheme.surfaceContainerHighest,
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        SizedBox(height: 6.height),
        Text(
          labels[currentStep - 1],
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Shared scaffold used by each booking wizard step.
/// Export as part of the booking barrel so step screens can import it easily.
class BookingScaffold extends StatelessWidget {
  final int currentStep;
  final Widget body;
  final String buttonLabel;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool isLoading;

  const BookingScaffold({
    super.key,
    required this.currentStep,
    required this.body,
    required this.buttonLabel,
    required this.onNext,
    this.onBack,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Column(
          children: [
            Text(
              'Book Service',
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              'Step $currentStep of 3',
              style: TextStyle(
                fontSize: context.responsiveFontScale(11),
                color: colorScheme.onSurface.withValues(alpha: .65),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveHorizontalPadding,
              vertical: 8.height,
            ),
            child: BookingStepIndicator(currentStep: currentStep),
          ),
          Expanded(child: body),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveHorizontalPadding,
            vertical: 12.height,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: onBack ?? () => Navigator.maybePop(context),
                borderRadius: BorderRadius.circular(28.radius),
                child: Container(
                  width: 52.width,
                  height: 52.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: colorScheme.outlineVariant, width: 1.5),
                  ),
                  child: Icon(Icons.arrow_back_ios_new,
                      size: 18, color: colorScheme.onSurface),
                ),
              ),
              SizedBox(width: 12.width),
              Expanded(
                child: SizedBox(
                  height: 52.height,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.radius),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            buttonLabel,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
