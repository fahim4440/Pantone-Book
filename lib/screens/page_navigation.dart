import 'package:flutter/material.dart';

class FadeAnimatedPageRoute extends PageRouteBuilder {
  final Widget page;

  FadeAnimatedPageRoute({required this.page}) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 600), // Custom duration
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class SlideAnimatedPageRoute extends PageRouteBuilder {
  final Widget page;

  SlideAnimatedPageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 400), // Custom duration
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide transition configuration
      const begin = Offset(-1.0, -1.0); // Slide in from the right
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

