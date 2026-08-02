import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class OrderCancelledBanner extends StatelessWidget {
  final String reason;

  const OrderCancelledBanner({
    super.key,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 14.height),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFCA5A5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(4.width),
            decoration: const BoxDecoration(
              color: Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.priority_high_rounded,
              color: Colors.white,
              size: 14.width,
            ),
          ),
          SizedBox(width: 10.width),
          Expanded(
            child: Text(
              reason,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF991B1B),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
