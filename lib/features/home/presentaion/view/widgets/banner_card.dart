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
      padding: EdgeInsets.all(20.width),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  banner.discountText,
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: context.responsiveFontScale(16),
                  ),
                ),
                SizedBox(height: 6.height),
                Text(
                  banner.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: context.responsiveFontScale(18),
                  ),
                ),
                SizedBox(height: 6.height),
                Text(
                  banner.description,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: context.responsiveFontScale(12),
                  ),
                ),
                SizedBox(height: 10.height),
                ElevatedButton(
                  onPressed: onBookNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1A68B6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Book now →'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}