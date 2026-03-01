import 'package:flutter/material.dart';

import '../../routes/app_router.dart';
import '../widgets/gradient_background.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  final _pages = const [
    (
      icon: Icons.checklist_rounded,
      title: 'Plan smartly',
      text: 'Organize your work, study and personal tasks in one place.'
    ),
    (
      icon: Icons.swipe_left_rounded,
      title: 'Interact quickly',
      text: 'Swipe to delete, drag to reorder, and tap to edit instantly.'
    ),
    (
      icon: Icons.insights_rounded,
      title: 'Track progress',
      text: 'Get completion stats and stay consistent with reminders.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (value) => setState(() => _index = value),
                  itemBuilder: (_, i) {
                    final page = _pages[i];
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.8, end: 1),
                            duration: const Duration(milliseconds: 600),
                            builder: (_, scale, child) => Transform.scale(
                              scale: scale,
                              child: child,
                            ),
                            child: Icon(page.icon, size: 120),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            page.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            page.text,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  onPressed: _index == _pages.length - 1
                      ? () => Navigator.pushReplacementNamed(context, AppRouter.home)
                      : () => _controller.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOut,
                          ),
                  child: Text(_index == _pages.length - 1 ? 'Get Started' : 'Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
