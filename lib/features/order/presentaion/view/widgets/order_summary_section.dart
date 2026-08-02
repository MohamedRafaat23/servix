import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';

class OrderSummarySection extends StatelessWidget {
  final OrderEntity order;

  const OrderSummarySection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deatils',
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 12.height),
        _OrderSummaryRow(label: 'Service', value: order.serviceName),
        _OrderSummaryRow(label: 'Address', value: '${order.date}, ${order.time}'),
        _OrderSummaryRow(label: 'Date', value: order.address),
        _OrderSummaryRow(
          label: 'Base Rate',
          value: '\$${order.baseRate.toStringAsFixed(2)}',
        ),
        _OrderSummaryRow(
          label: 'Service Fee',
          value: '\$${order.serviceFee.toStringAsFixed(2)}',
        ),
        SizedBox(height: 8.height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: context.responsiveFontScale(15),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            Text(
              '\$${order.total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.bold,
                color: AppColors.lightPrimaryColor,
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              color: AppColors.greyColor,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: const Color(0xFF334155),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
