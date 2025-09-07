import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../widgets/responsive_navigation.dart';

class MainLayout extends ConsumerWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1200;
          final isTablet =
              constraints.maxWidth >= 768 && constraints.maxWidth < 1200;
          final isMobile = constraints.maxWidth < 768;

          if (isDesktop) {
            return _DesktopLayout(
              child: child,
              isDarkMode: isDarkMode,
              onThemeToggle: () =>
                  ref.read(themeProvider.notifier).state = !isDarkMode,
            );
          } else if (isTablet) {
            return _TabletLayout(
              child: child,
              isDarkMode: isDarkMode,
              onThemeToggle: () =>
                  ref.read(themeProvider.notifier).state = !isDarkMode,
            );
          } else {
            return _MobileLayout(
              child: child,
              isDarkMode: isDarkMode,
              onThemeToggle: () =>
                  ref.read(themeProvider.notifier).state = !isDarkMode,
            );
          }
        },
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final Widget child;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const _DesktopLayout({
    required this.child,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Side Navigation
        Container(
          width: 280,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border(
              right: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: ResponsiveNavigation(
            isRail: false,
            isDarkMode: isDarkMode,
            onThemeToggle: onThemeToggle,
          ),
        ).animate().slideX(
          begin: -1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        ),
        // Main Content
        Expanded(
          child: child.animate().fadeIn(
            duration: const Duration(milliseconds: 400),
            delay: const Duration(milliseconds: 100),
          ),
        ),
      ],
    );
  }
}

class _TabletLayout extends StatelessWidget {
  final Widget child;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const _TabletLayout({
    required this.child,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Navigation Rail
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border(
              right: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: ResponsiveNavigation(
            isRail: true,
            isDarkMode: isDarkMode,
            onThemeToggle: onThemeToggle,
          ),
        ).animate().slideX(
          begin: -1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        ),
        // Main Content
        Expanded(
          child: child.animate().fadeIn(
            duration: const Duration(milliseconds: 400),
            delay: const Duration(milliseconds: 100),
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final Widget child;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const _MobileLayout({
    required this.child,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getPageTitle(context)),
        actions: [
          IconButton(
            onPressed: onThemeToggle,
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            tooltip: isDarkMode ? 'Light mode' : 'Dark mode',
          ),
        ],
      ),
      drawer: Drawer(
        child: ResponsiveNavigation(
          isRail: false,
          isDarkMode: isDarkMode,
          onThemeToggle: onThemeToggle,
        ),
      ),
      body: child.animate().fadeIn(duration: const Duration(milliseconds: 400)),
    );
  }

  String _getPageTitle(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    switch (location) {
      case '/':
        return 'Home';
      case '/dashboard':
        return 'Dashboard';
      case '/profile':
        return 'Profile';
      case '/settings':
        return 'Settings';
      default:
        return 'Flutter Web Demo';
    }
  }
}

