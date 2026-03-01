import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primaryContainer,
            scheme.surface,
            scheme.secondaryContainer,
          ],
        ),
      ),
      child: child,
    );
  }
}
