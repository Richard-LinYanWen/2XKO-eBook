import 'package:flutter/material.dart';

class StatBar extends StatefulWidget {
  final int columnIndex;
  final bool isFilled;
  const StatBar({super.key, required this.columnIndex, required this.isFilled});

  @override
  State<StatBar> createState() => _StatBarState();
}

class _StatBarState extends State<StatBar> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Delay triggering the animation based on column index
    // 1st bars (index 0) = 0ms, 2nd (index 1) = 150ms, etc.
    Future.delayed(Duration(milliseconds: widget.columnIndex * 150), () {
      if (mounted) setState(() => _isVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _isVisible ? 1.0 : 0.0,
        child: Container(
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: widget.isFilled ? Colors.greenAccent : Colors.white10,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}