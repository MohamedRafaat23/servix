// lib/features/home/presentation/view/widgets/banner_card.dart
import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/bannar_entity.dart';

class BannerCard extends StatelessWidget {
  final BannerEntity banner;
  final VoidCallback? onBookNow;

  const BannerCard({super.key, required this.banner, this.onBookNow});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.width),
      padding: EdgeInsets.symmetric(horizontal: 20.width, vertical: 16.height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF53A7FA), Color(0xFF358BE0), Color(0xFF1A68B6)],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  banner.discountText,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: context.responsiveFontScale(14),
                  ),
                ),
                SizedBox(height: 4.height),
                Text(
                  banner.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: context.responsiveFontScale(16),
                    height: 1.15,
                  ),
                ),
                SizedBox(height: 4.height),
                Text(
                  banner.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: context.responsiveFontScale(11),
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8.height),
                SizedBox(
                  height: 32.height,
                  child: ElevatedButton(
                    onPressed: onBookNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1A68B6),
                      padding: EdgeInsets.symmetric(horizontal: 14.width),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(
                      'Book now →',
                      style: TextStyle(fontSize: context.responsiveFontScale(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}