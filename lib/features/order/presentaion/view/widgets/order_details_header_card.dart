import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_colors.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/order/domain/entites/order_entity.dart';
import 'order_status_badge.dart';

class OrderDetailsHeaderCard extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsHeaderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 26.width,
            backgroundImage: AssetImage(order.providerImage),
          ),
          SizedBox(width: 12.width),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.providerName,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(15),
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
                SizedBox(height: 4.height),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                    SizedBox(width: 3.width),
                    Text(
                      '${order.rating} · ${order.jobsCount} Jobs',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              OrderStatusBadge(status: order.status),
              SizedBox(width: 8.width),
              Container(
                width: 26.width,
                height: 26.width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFFEDD5)),
                  color: const Color(0xFFFFF7ED),
                ),
                child: Icon(
                  Icons.north_east,
                  size: 14.width,
                  color: const Color(0xFFF97316),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
