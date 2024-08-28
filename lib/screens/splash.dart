import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Path _path;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _path = Path()
      ..moveTo(0, 0)
      ..lineTo(100, 100)
      ..lineTo(200, 0)
      ..close();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: _PathPainter(_path, _animation.value),
          child: child,
        );
      },
      child: Container(),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _PathPainter extends CustomPainter {
  final Path path;
  final double animationValue;

  _PathPainter(this.path, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(path, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_PathPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}