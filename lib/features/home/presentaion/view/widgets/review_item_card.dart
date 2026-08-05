import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class ReviewItemCard extends StatelessWidget {
  final String name;
  final String date;
  final String imageAsset;
  final String comment;
  final int rating;

  const ReviewItemCard({
    super.key,
    required this.name,
    required this.date,
    required this.imageAsset,
    required this.comment,
    this.rating = 5,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18.radius),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.width,
                backgroundImage: AssetImage(imageAsset),
              ),
              SizedBox(width: 10.width),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 2.height),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(11),
                      color: colorScheme.onSurface.withValues(alpha: .6),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  rating,
                  (index) => Padding(
                    padding: EdgeInsets.only(left: 1.width),
                    child: Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 15.width,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.height),
          Text(
            comment,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              color: colorScheme.onSurface.withValues(alpha: .7),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
