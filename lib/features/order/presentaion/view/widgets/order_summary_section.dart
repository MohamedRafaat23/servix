import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_strings.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';

class OrderSummarySection extends StatelessWidget {
  final OrderEntity order;

  const OrderSummarySection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.details,
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 12.height),
        _OrderSummaryRow(label: AppStrings.service, value: order.serviceName),
        _OrderSummaryRow(label: AppStrings.address, value: '${order.date}, ${order.time}'),
        _OrderSummaryRow(label: AppStrings.date, value: order.address),
        _OrderSummaryRow(
          label: AppStrings.baseRate,
          value: '\$${order.baseRate.toStringAsFixed(2)}',
        ),
        _OrderSummaryRow(
          label: AppStrings.serviceFee,
          value: '\$${order.serviceFee.toStringAsFixed(2)}',
        ),
        SizedBox(height: 8.height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.total,
              style: TextStyle(
                fontSize: context.responsiveFontScale(15),
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              '\$${order.total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _OrderSummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              color: colorScheme.onSurface.withValues(alpha: .65),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
