import 'dart:math';
import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint();
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    bgPaint.shader = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF6B7FD4),
        Color(0xFF8B9FE8),
        Color(0xFF7B8FD8),
        Color(0xFF5A6DC4),
      ],
      stops: [0.0, 0.3, 0.6, 1.0],
    ).createShader(bgRect);
    canvas.drawRect(bgRect, bgPaint);

    _drawWaveLines(
      canvas,
      size,
      Offset(size.width * 0.05, size.height * 0.65),
      18,
      28.0,
      const Color(0xFF3A4FA8),
    );
    _drawWaveLines(
      canvas,
      size,
      Offset(size.width * 0.85, size.height * 0.45),
      14,
      22.0,
      const Color(0xFF3A4FA8),
    );
    _drawSplatter(canvas, size);
  }

  void _drawWaveLines(
    Canvas canvas,
    Size size,
    Offset center,
    int count,
    double spacing,
    Color color,
  ) {
    final paint = Paint()
      ..color = color.withOpacity(0.6)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < count; i++) {
      final path = Path();
      final radius = spacing * (i + 1);
      path.addOval(
        Rect.fromCenter(
          center: center,
          width: radius * 2.2,
          height: radius * 1.4,
        ),
      );
      canvas.drawPath(path, paint);
    }
  }

  void _drawSplatter(Canvas canvas, Size size) {
    final random = Random(42);
    final dotPaint = Paint()..style = PaintingStyle.fill;

    final dots = [
      {
        'x': 0.18,
        'y': 0.08,
        'r': 8.0,
        'color': const Color(0xFF2A3A8C),
        'opacity': 0.85,
      },
      {
        'x': 0.55,
        'y': 0.05,
        'r': 5.0,
        'color': const Color(0xFF2A3A8C),
        'opacity': 0.75,
      },
      {
        'x': 0.72,
        'y': 0.12,
        'r': 9.0,
        'color': const Color(0xFF2A3A8C),
        'opacity': 0.80,
      },
      {
        'x': 0.30,
        'y': 0.15,
        'r': 4.0,
        'color': const Color(0xFF2A3A8C),
        'opacity': 0.70,
      },
      {
        'x': 0.80,
        'y': 0.28,
        'r': 6.0,
        'color': const Color(0xFF2A3A8C),
        'opacity': 0.75,
      },
      {
        'x': 0.10,
        'y': 0.35,
        'r': 5.0,
        'color': const Color(0xFF2A3A8C),
        'opacity': 0.65,
      },
      {
        'x': 0.60,
        'y': 0.40,
        'r': 7.0,
        'color': const Color(0xFF2A3A8C),
        'opacity': 0.70,
      },
      {
        'x': 0.40,
        'y': 0.55,
        'r': 4.0,
        'color': const Color(0xFF2A3A8C),
        'opacity': 0.60,
      },
      {
        'x': 0.85,
        'y': 0.65,
        'r': 5.0,
        'color': const Color(0xFF2A3A8C),
        'opacity': 0.70,
      },
      {
        'x': 0.25,
        'y': 0.75,
        'r': 6.0,
        'color': const Color(0xFF2A3A8C),
        'opacity': 0.65,
      },
      {
        'x': 0.35,
        'y': 0.92,
        'r': 10.0,
        'color': const Color(0xFF4ECDC4),
        'opacity': 0.50,
      },
      {
        'x': 0.70,
        'y': 0.50,
        'r': 8.0,
        'color': const Color(0xFF4ECDC4),
        'opacity': 0.40,
      },
    ];

    for (final dot in dots) {
      dotPaint.color = (dot['color'] as Color).withOpacity(
        dot['opacity'] as double,
      );
      canvas.drawCircle(
        Offset(
          size.width * (dot['x'] as double),
          size.height * (dot['y'] as double),
        ),
        dot['r'] as double,
        dotPaint,
      );
    }

    for (int i = 0; i < 30; i++) {
      dotPaint.color = const Color(
        0xFF2A3A8C,
      ).withOpacity(0.3 + random.nextDouble() * 0.4);
      canvas.drawCircle(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        1.0 + random.nextDouble() * 2.5,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: BackgroundPainter(),
          child: const SizedBox.expand(),
        ),
        child,
      ],
    );
  }
}
