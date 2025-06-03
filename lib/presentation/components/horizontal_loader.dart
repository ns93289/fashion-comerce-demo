import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalLoader extends StatefulWidget {
  const HorizontalLoader({super.key});

  @override
  State<HorizontalLoader> createState() => _HorizontalLoaderState();
}

class _HorizontalLoaderState extends State<HorizontalLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Color> colors = [Colors.blue, Colors.red, Colors.yellow, Colors.green];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3.sp,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  transform: GradientRotation(_controller.value * 6.28),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
