import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../widgets/feature_card.dart';
import '../widgets/hero_section.dart';
import '../widgets/stats_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            const HeroSection().animate().fadeIn(
              duration: const Duration(milliseconds: 800),
            ),
            const Gap(48),

            // Stats Section
            const StatsSection().animate().slideY(
              begin: 0.3,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
            ),
            const Gap(48),

            // Features Section
            Text(
              'Features',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
            ).animate().slideX(
              begin: -0.3,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 400),
            ),
            const Gap(24),

            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 1200
                    ? 3
                    : constraints.maxWidth > 768
                    ? 2
                    : 1;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _features.length,
                  itemBuilder: (context, index) {
                    final feature = _features[index];
                    return FeatureCard(
                      title: feature.title,
                      description: feature.description,
                      icon: feature.icon,
                      onTap: () => context.go(feature.route),
                    ).animate().scale(
                      begin: const Offset(0.8, 0.8),
                      duration: Duration(milliseconds: 400 + (index * 100)),
                      delay: const Duration(milliseconds: 600),
                      curve: Curves.easeOutBack,
                    );
                  },
                );
              },
            ),

            const Gap(48),

            // Call to Action
            Center(
              child: Column(
                children: [
                  Text(
                    'Ready to explore?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  Text(
                    'Discover all the features this modern Flutter web app has to offer.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(24),
                  FilledButton.icon(
                    onPressed: () => context.go('/dashboard'),
                    icon: const Icon(Icons.explore),
                    label: const Text('Get Started'),
                  ),
                ],
              ),
            ).animate().fadeIn(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 1000),
            ),
          ],
        ),
      ),
    );
  }
}

class _Feature {
  final String title;
  final String description;
  final IconData icon;
  final String route;

  const _Feature({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
  });
}

const List<_Feature> _features = [
  _Feature(
    title: 'Dashboard',
    description:
        'View analytics and insights with beautiful charts and data visualization.',
    icon: Icons.dashboard,
    route: '/dashboard',
  ),
  _Feature(
    title: 'Profile',
    description: 'Manage your personal information and preferences with ease.',
    icon: Icons.person,
    route: '/profile',
  ),
  _Feature(
    title: 'Settings',
    description:
        'Customize the app to your liking with various configuration options.',
    icon: Icons.settings,
    route: '/settings',
  ),
];

