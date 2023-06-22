import 'package:flutter/material.dart';

class GoogleLogo extends StatelessWidget {
  const GoogleLogo({super.key, required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: CustomPaint(
        painter: GoogleLogoPainter(color: color),
        size: Size.square(size),
      ),
    );
  }
}

class GoogleLogoPainter extends CustomPainter {
  const GoogleLogoPainter({required this.color});

  final Color color;

  @override
  bool shouldRepaint(oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    final length = size.width;
    final verticalOffset = (size.height / 2) - (length / 2);
    final bounds = Offset(0, verticalOffset) & Size.square(length);
    final center = bounds.center;
    final arcThickness = size.width / 4.5;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcThickness
      ..color = color;

    void drawArc(double startAngle, double sweepAngle) {
      canvas.drawArc(bounds, startAngle, sweepAngle, false, paint);
    }

    drawArc(3.5, 1.9);
    drawArc(2.5, 1.0);
    drawArc(0.9, 1.6);
    drawArc(-0.18, 1.1);

    canvas.drawRect(
      Rect.fromLTRB(
        center.dx,
        center.dy - (arcThickness / 2),
        bounds.centerRight.dx + (arcThickness / 2) - 4,
        bounds.centerRight.dy + (arcThickness / 2),
      ),
      paint
        ..style = PaintingStyle.fill
        ..strokeWidth = 0,
    );
  }
}
