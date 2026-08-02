import 'package:flutter/material.dart';

class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFBDD9F0).withValues(alpha: .5)
      ..strokeWidth = 0.8;
    const spacing = 18.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final road = Paint()
      ..color = const Color(0xFF93C5FD).withValues(alpha: .7)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, size.height * 0.45), Offset(size.width, size.height * 0.45), road);
    canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.4, size.height), road);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}