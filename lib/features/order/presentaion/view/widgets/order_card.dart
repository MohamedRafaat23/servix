import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';
import 'order_status_badge.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.width),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDDE7F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Avatar, Name, Profession, Status Badge, Price, Arrow
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22.width,
                  backgroundImage: AssetImage(order.providerImage),
                ),
                SizedBox(width: 10.width),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.providerName,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      SizedBox(height: 2.height),
                      Text(
                        order.profession,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        OrderStatusBadge(status: order.status),
                        SizedBox(width: 8.width),
                        Container(
                          width: 24.width,
                          height: 24.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFFFEDD5)),
                            color: const Color(0xFFFFF7ED),
                          ),
                          child: Icon(
                            Icons.north_east,
                            size: 13.width,
                            color: const Color(0xFFF97316),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.height),
                    Text(
                      '\$${order.total.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(15),
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.height),
            const Divider(color: Color(0xFFF1F5F9), height: 1),
            SizedBox(height: 10.height),
            // Bottom rows: Date & Address
            Row(
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: AppColors.greyColor,
                  ),
                ),
                const Spacer(),
                Text(
                  '${order.date} · ${order.time}',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.height),
            Row(
              children: [
                Text(
                  'Address',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: AppColors.greyColor,
                  ),
                ),
                const Spacer(),
                Text(
                  order.address,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
