import 'package:flutter/material.dart';

class GradiantBackground extends StatelessWidget {
  const GradiantBackground({Key? key, required this.child, this.height
    // , required this.center
  })
      : super(key: key);
  final Widget child;
  final double? height;

  // final AlignmentGeometry center;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: RadialGradient(colors: [
          // Theme.of(context).colorScheme.primary,
          // Theme.of(context).colorScheme.secondary,
          Color(0xff020024),
          Color(0xff090979),
          Color(0xff161616),
          // Color(0xff054c5b),
          // Theme.of(context).colorScheme.secondary,
        ], radius: 1.0, center: Alignment.bottomRight),
      ),
      child: child,
    );
  }
}