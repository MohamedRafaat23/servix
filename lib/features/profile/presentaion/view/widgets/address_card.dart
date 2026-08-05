import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class AddressCard extends StatelessWidget {
  final String address;
  final VoidCallback onDelete;

  const AddressCard({super.key, required this.address, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 14.height),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Color(0xFF64B5F6), size: 20),
          SizedBox(width: 10.width),
          Expanded(
            child: Text(
              address,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 20),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
