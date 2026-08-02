import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: context.responsiveFontScale(15),
            ),
          ),
        ),
        SizedBox(width: 8.width),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            'See All',
            style: TextStyle(
              color: const Color(0xFF358BE0),
              fontSize: context.responsiveFontScale(13),
            ),
          ),
        ),
      ],
    );
  }
}