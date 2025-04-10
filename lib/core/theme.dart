import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static const Color primary = Color(0xFFFF7272);
  static const Color secondary = Color(0xFFF0F0F0);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF808080);
  static const Color success = Color(0xFF5BC507);
  static const Color info = Color(0xFF07ABF7);
  static const Color warning = Color(0xFFEB910B);
  static const Color danger = Color(0xFFED2727);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.black,
  );

  static const TextStyle bodyWhite = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  static const TextStyle bodyGray = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.gray,
  );
}

class AppStyles {
  static final BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withAlpha((0.26 * 255).toInt()),
    offset: Offset(0, 2),
    blurRadius: 3,
  );
}

class AppViewTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0), // Slide from right
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn)),
      child: child,
    );
  }
}
