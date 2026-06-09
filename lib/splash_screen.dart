import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<Alignment> _alignmentAnimation;

  @override
  void initState() {
    super.initState();
    
    // Total duration: 2000ms (2 seconds)
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));

    // STEP 1: The Flicker (Color changes while staying centered)
    _colorAnimation = TweenSequence<Color?>([
      TweenSequenceItem(tween: ColorTween(begin: Colors.white, end: Colors.green), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.green, end: Colors.black), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.black, end: Colors.white), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.white, end: Colors.green), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.green, end: Colors.black), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3)));

    // STEP 2: The Step-by-Step Movement
    _alignmentAnimation = TweenSequence<Alignment>([
      // Phase 1: Stay in center (Flicker phase)
      TweenSequenceItem(
        tween: Tween<Alignment>(begin: Alignment.center, end: Alignment.center),
        weight: 30, 
      ),
      // Phase 2: Move Vertical only
      TweenSequenceItem(
        tween: Tween<Alignment>(begin: Alignment.center, end: const Alignment(0, -0.55)),
        weight: 35,
      ),
      // Phase 3: Move Horizontal only
      TweenSequenceItem(
        tween: Tween<Alignment>(begin: const Alignment(0, -0.55), end: const Alignment(-0.4, -0.55)),
        weight: 35,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward().then((_) {
      if (!mounted) return;
      
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // This is the fade logic
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          // 800ms to 1s gives it that "cinematic" feel
          transitionDuration: const Duration(milliseconds: 800), 
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _colorAnimation.value ?? Colors.black,
          body: Align(
            alignment: _alignmentAnimation.value,
            child: Image.asset('assets/icons/Riot_Logo.png', height: 120),
          ),
        );
      },
    );
  }
}