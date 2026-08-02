import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';

class OrderFilterChips extends StatelessWidget {
  final OrderStatusType? selectedFilter; // null = All
  final void Function(OrderStatusType? filter) onFilterChanged;

  const OrderFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = <(String label, OrderStatusType? type)>[
      ('All', null),
      ('Pending', OrderStatusType.pending),
      ('Completed', OrderStatusType.completed),
      ('Cancelled', OrderStatusType.cancelled),
    ];

    return SizedBox(
      height: 38.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.width),
        itemBuilder: (_, i) {
          final (label, type) = filters[i];
          final isSelected = selectedFilter == type;

          return GestureDetector(
            onTap: () => onFilterChanged(type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 18.width, vertical: 8.height),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.lightPrimaryColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.lightPrimaryColor : const Color(0xFFDDE7F0),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.lightPrimaryColor.withValues(alpha: .25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? Colors.white : AppColors.greyColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
