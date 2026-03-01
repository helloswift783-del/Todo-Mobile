import 'package:flutter/material.dart';

import '../views/screens/home_screen.dart';
import '../views/screens/onboarding_screen.dart';
import '../views/screens/statistics_screen.dart';

class AppRouter {
  static const onboarding = '/';
  static const home = '/home';
  static const stats = '/stats';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _fade(const HomeScreen());
      case stats:
        return _fade(const StatisticsScreen());
      case onboarding:
      default:
        return _fade(const OnboardingScreen());
    }
  }

  static PageRouteBuilder<dynamic> _fade(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
