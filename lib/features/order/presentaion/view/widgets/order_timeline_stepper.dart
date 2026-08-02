import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';

class OrderTimelineStepper extends StatelessWidget {
  final OrderEntity order;

  const OrderTimelineStepper({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final steps = order.timelineSteps.isNotEmpty
        ? order.timelineSteps
        : const [
            OrderTimelineStepEntity(stepNumber: 1, title: 'Booking Confirmed', timeOrStatus: '09:12 AM', isCompleted: true),
            OrderTimelineStepEntity(stepNumber: 2, title: 'On The Way', timeOrStatus: '10:02 AM', isCompleted: true),
            OrderTimelineStepEntity(stepNumber: 3, title: 'Arrived', timeOrStatus: '10:24 AM', isCompleted: true),
            OrderTimelineStepEntity(stepNumber: 4, title: 'start Worked', timeOrStatus: 'Pending', isCompleted: false, isCurrent: true),
            OrderTimelineStepEntity(stepNumber: 5, title: 'Payment', timeOrStatus: 'Pending', isCompleted: false),
          ];

    final isCancelled = order.status == OrderStatusType.cancelled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Status',
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 12.height),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 16.height),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFDDE7F0)),
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
                                    ? AppColors.lightPrimaryColor
                                    : Colors.white,
                            border: showCheck || isCurrentStep
                                ? null
                                : Border.all(color: const Color(0xFFDDE7F0), width: 1.5),
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
                                          : const Color(0xFF94A3B8),
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
                                  : const Color(0xFFE2E8F0),
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
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFF94A3B8),
                              ),
                            ),
                            if (step.timeOrStatus != null) ...[
                              SizedBox(height: 2.height),
                              Text(
                                step.timeOrStatus!,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(11),
                                  color: AppColors.greyColor,
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
