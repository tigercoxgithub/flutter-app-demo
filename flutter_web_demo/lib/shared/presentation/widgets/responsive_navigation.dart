import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResponsiveNavigation extends StatelessWidget {
  final bool isRail;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const ResponsiveNavigation({
    super.key,
    required this.isRail,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (isRail) {
      return _NavigationRail(
        isDarkMode: isDarkMode,
        onThemeToggle: onThemeToggle,
      );
    } else {
      return _NavigationDrawer(
        isDarkMode: isDarkMode,
        onThemeToggle: onThemeToggle,
      );
    }
  }
}

class _NavigationRail extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const _NavigationRail({
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.path;

    return NavigationRail(
      selectedIndex: _getSelectedIndex(currentLocation),
      onDestinationSelected: (index) => _navigateToIndex(context, index),
      labelType: NavigationRailLabelType.selected,
      leading: Column(
        children: [
          const Gap(16),
          FloatingActionButton.small(
            onPressed: onThemeToggle,
            child: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
          const Gap(16),
        ],
      ),
      destinations: _destinations.map((dest) {
        return NavigationRailDestination(
          icon: Icon(dest.icon),
          selectedIcon: Icon(dest.selectedIcon),
          label: Text(dest.label),
        );
      }).toList(),
    );
  }
}

class _NavigationDrawer extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const _NavigationDrawer({
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.path;

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.flutter_dash,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Flutter Web Demo',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Modern Web App',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.7),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: const Duration(milliseconds: 600)),
              const Gap(24),
              // Theme toggle
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: isDarkMode,
                onChanged: (_) => onThemeToggle(),
                secondary: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                contentPadding: EdgeInsets.zero,
              ).animate().fadeIn(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 100),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // Navigation Items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _destinations.length,
            itemBuilder: (context, index) {
              final dest = _destinations[index];
              final isSelected = _getSelectedIndex(currentLocation) == index;

              return Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: ListTile(
                  leading: Icon(
                    isSelected ? dest.selectedIcon : dest.icon,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  title: Text(
                    dest.label,
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  selected: isSelected,
                  selectedTileColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    _navigateToIndex(context, index);
                    // Close drawer on mobile
                    if (Scaffold.of(context).hasDrawer) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ).animate().slideX(
                begin: -0.3,
                duration: Duration(milliseconds: 300 + (index * 50)),
                curve: Curves.easeOutCubic,
              );
            },
          ),
        ),
        const Divider(height: 1),
        // Footer
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Built with Flutter & Material 3',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ).animate().fadeIn(
          duration: const Duration(milliseconds: 600),
          delay: const Duration(milliseconds: 400),
        ),
      ],
    );
  }
}

class _NavigationDestination {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String route;

  const _NavigationDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.route,
  });
}

const List<_NavigationDestination> _destinations = [
  _NavigationDestination(
    label: 'Home',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    route: '/',
  ),
  _NavigationDestination(
    label: 'Dashboard',
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
    route: '/dashboard',
  ),
  _NavigationDestination(
    label: 'Profile',
    icon: Icons.person_outline,
    selectedIcon: Icons.person,
    route: '/profile',
  ),
  _NavigationDestination(
    label: 'Settings',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
    route: '/settings',
  ),
];

int _getSelectedIndex(String currentLocation) {
  for (int i = 0; i < _destinations.length; i++) {
    if (_destinations[i].route == currentLocation) {
      return i;
    }
  }
  return 0;
}

void _navigateToIndex(BuildContext context, int index) {
  if (index >= 0 && index < _destinations.length) {
    context.go(_destinations[index].route);
  }
}

