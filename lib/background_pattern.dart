import 'package:flutter/material.dart';

class BackgroundPattern extends StatelessWidget {
  final Widget child;

  const BackgroundPattern({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black, // Base background
      ),
      child: CustomPaint(
        painter: DiagonalStripePainter(),
        child: child,
      ),
    );
  }
}

class DiagonalStripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define the colors for the stripes
    final List<Color> stripeColors = [
      Colors.black,
      Colors.white.withValues(alpha: 0.1), // Subtle white
      Colors.green.withValues(alpha: 0.1), // Subtle green
    ];

    final double stripeWidth = 60.0; // Adjust for wider/thinner stripes
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stripeWidth;

    // Loop to draw lines across the diagonal
    // We start from a negative offset to ensure we cover the whole screen
    for (double i = -size.width; i < size.width + size.height; i += stripeWidth) {
      // Pick a color based on the current index
      paint.color = stripeColors[((i / stripeWidth).floor() % stripeColors.length).abs()];
      
      // Draw a line from top-right to bottom-left
      canvas.drawLine(
        Offset(i, 0),
        Offset(i - size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}