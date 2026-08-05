import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';

class OrderTimelineStepper extends StatelessWidget {
  final OrderEntity order;

  const OrderTimelineStepper({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final steps = order.timelineSteps.isNotEmpty
        ? order.timelineSteps
        :  [
            OrderTimelineStepEntity(stepNumber: 1, title: AppStrings.bookingConfirmed, timeOrStatus: '09:12 AM', isCompleted: true),
            OrderTimelineStepEntity(stepNumber: 2, title: AppStrings.onTheWay, timeOrStatus: '10:02 AM', isCompleted: true),
            OrderTimelineStepEntity(stepNumber: 3, title: AppStrings.arrived, timeOrStatus: '10:24 AM', isCompleted: true),
            OrderTimelineStepEntity(stepNumber: 4, title: AppStrings.startWorked, timeOrStatus: 'Pending', isCompleted: false, isCurrent: true),
            OrderTimelineStepEntity(stepNumber: 5, title: AppStrings.payment, timeOrStatus: 'Pending', isCompleted: false),
          ];

    final isCancelled = order.status == OrderStatusType.cancelled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.orderStatus,
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 12.height),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 16.height),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: List.generate(steps.length, (index) {
              final step = steps[index];
              final isLast = index == steps.length - 1;

              final showCheck = !isCancelled && step.isCompleted;
              final isCurrentStep = !isCancelled && step.isCurrent;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline indicator + connecting line
                    Column(
                      children: [
                        Container(
                          width: 24.width,
                          height: 24.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: showCheck
                                ? const Color(0xFF22C55E)
                                : isCurrentStep
                                    ? colorScheme.primary
                                    : colorScheme.surface,
                            border: showCheck || isCurrentStep
                                ? null
                                : Border.all(color: colorScheme.outlineVariant, width: 1.5),
                          ),
                          child: Center(
                            child: showCheck
                                ? Icon(Icons.check, color: Colors.white, size: 14.width)
                                : Text(
                                    '${step.stepNumber}',
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(11),
                                      fontWeight: FontWeight.bold,
                                      color: isCurrentStep
                                          ? Colors.white
                                          : colorScheme.onSurface.withValues(alpha: .6),
                                    ),
                                  ),
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: showCheck
                                  ? const Color(0xFF22C55E)
                                  : colorScheme.outlineVariant,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 14.width),
                    // Step title and time
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 0 : 20.height),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step.title,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                fontWeight: FontWeight.bold,
                                color: (showCheck || isCurrentStep)
                                    ? colorScheme.onSurface
                                    : colorScheme.onSurface.withValues(alpha: .6),
                              ),
                            ),
                            if (step.timeOrStatus != null) ...[
                              SizedBox(height: 2.height),
                              Text(
                                step.timeOrStatus!,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(11),
                                  color: colorScheme.onSurface.withValues(alpha: .65),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
