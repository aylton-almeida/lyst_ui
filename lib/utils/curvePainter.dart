import 'dart:math';

import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  final List<Color> colors;

  CurvePainter(this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromCircle(
      center: new Offset(size.width * 0.5, size.height* 0),
      radius: 180.0,
    );

    // a fancy rainbow gradient
    final Gradient gradient = new LinearGradient(
      colors: colors,
      transform: GradientRotation(pi / 2)
    );

    // create the Shader from the gradient and the bounding square
    Paint paint = new Paint()..shader = gradient.createShader(rect);

    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9);
    path.quadraticBezierTo(size.width * 0.25, size.height * 1.1,
        size.width * 0.5, size.height * 0.9);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.7,
        size.width * 1.0, size.height * 0.9);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawShadow(path, Colors.grey, 2, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
