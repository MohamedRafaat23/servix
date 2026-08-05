
import 'package:flutter/material.dart';

class CardCutoutPainter extends CustomPainter {
  final Color color;
  final double buttonRight;
  final double buttonTop;
  final double buttonRadius;
  final double cutoutGap;

  CardCutoutPainter({
    required this.color,
    required this.buttonRight,
    required this.buttonTop,
    required this.buttonRadius,
    required this.cutoutGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // شكل الكارد الأساسي (Pill Shape)
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.height / 2),
    );
    final backgroundPath = Path()..addRRect(rrect);

    // دائرة الـ Cutout اللي هنطرحها من الكارد
    final double centerX = size.width - buttonRight - buttonRadius;
    final double centerY = buttonTop + buttonRadius;
    final double cutoutRadius = buttonRadius + cutoutGap;

    final cutoutPath = Path()
      ..addOval(
  Rect.fromCenter(
    center: Offset(centerX, centerY),
    width: cutoutRadius * 2,
    height: cutoutRadius * 2,
  ));

    // طرح الدائرة من الكارد
    final finalPath = Path.combine(PathOperation.difference, backgroundPath, cutoutPath);

    // رسم الـ Shadow يدوياً على المسار النهائي
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4); 
    
    final shadowPath = finalPath.shift(const Offset(0, 2));
    canvas.drawPath(shadowPath, shadowPaint);

    // رسم الكارد النهائي باللون الأبيض
    canvas.drawPath(finalPath, paint);
  }

  @override
  bool shouldRepaint(covariant CardCutoutPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.buttonRight != buttonRight ||
        oldDelegate.buttonTop != buttonTop ||
        oldDelegate.buttonRadius != buttonRadius ||
        oldDelegate.cutoutGap != cutoutGap;
  }
}