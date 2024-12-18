import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:search_app/splash_screen/splash_screen/controller/splash_screen_controller.dart';
import 'package:search_app/utils/colors_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: controller.animationController!,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: CirclePainter(
                        progress: controller.animationController!.value,
                        listRadius: controller.listRadius,
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.search,
                  size: 55,
                  color: primaryColor,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  final List<int> listRadius;

  CirclePainter({required this.progress, required this.listRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 200.0;

    // Draw circles with different radii.
    for (final radius in listRadius) {
      final animatedRadius = radius + (radius * progress);
      canvas.drawCircle(size.center(Offset.zero), animatedRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
