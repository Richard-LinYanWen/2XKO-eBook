import 'package:flutter/material.dart';

class LeftToRightReveal extends StatelessWidget {
  final Widget child;
  const LeftToRightReveal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: value, // Wipes from left to right
            child: Opacity(
              opacity: value, // Fades in simultaneously
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}