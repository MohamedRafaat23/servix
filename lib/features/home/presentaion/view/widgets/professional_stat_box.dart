import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class ProfessionalStatBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const ProfessionalStatBox({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.height, horizontal: 4.width),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.radius),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: const Color(0xFF3B82F6),
              size: 22.width,
            ),
            SizedBox(height: 6.height),
            Text(
              value,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.height),
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                color: const Color(0xFF94A3B8),
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
