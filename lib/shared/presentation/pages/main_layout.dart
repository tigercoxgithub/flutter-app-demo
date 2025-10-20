import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Responsive layout that adapts to platform
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use NavigationRail for wider screens (desktop/web)
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                NavigationRail(
                  selectedIndex: _getSelectedIndex(context),
                  onDestinationSelected: (index) =>
                      _onDestinationSelected(context, index),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.view_in_ar_outlined),
                      selectedIcon: Icon(Icons.view_in_ar),
                      label: Text('3D Viewer'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.web),
                      selectedIcon: Icon(Icons.web),
                      label: Text('Web Viewer'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: child),
              ],
            );
          } else {
            // Use BottomNavigationBar for mobile screens
            return Scaffold(
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _getSelectedIndex(context),
                onTap: (index) => _onDestinationSelected(context, index),
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined),
                    activeIcon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.view_in_ar_outlined),
                    activeIcon: Icon(Icons.view_in_ar),
                    label: '3D Viewer',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.web),
                    activeIcon: Icon(Icons.web),
                    label: 'Web Viewer',
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    switch (location) {
      case '/':
        return 0;
      case '/profile':
        return 1;
      case '/settings':
        return 2;
      case '/3d-viewer':
        return 3;
      case '/webview':
        return 4;
      default:
        return 0;
    }
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/profile');
        break;
      case 2:
        context.go('/settings');
        break;
      case 3:
        context.go('/3d-viewer');
        break;
      case 4:
        context.go('/webview');
        break;
    }
  }
}
