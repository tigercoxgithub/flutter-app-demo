# Flutter Demo App Development Guide Using Dart MCP Server Tools

## Overview
This guide demonstrates how to use the Dart MCP Server tools available in Cursor to build a completely fresh Flutter demo application from scratch that can be built for both **Web** and **macOS Desktop** platforms using the same codebase, following modern best practices.

## Prerequisites
- Cursor IDE with Dart MCP Server configured
- Flutter SDK installed and configured
- Dart SDK (comes with Flutter)
- **For macOS Desktop**: Xcode installed (for macOS builds)
- **For Web**: Chrome browser (for web testing)

## Step-by-Step Instructions

### Step 1: Initialize the Project
```bash
# Create a new Flutter project with web and macOS support
flutter create --platforms=web,macos flutter_demo_app
cd flutter_demo_app

# Verify platform support
flutter devices
```

### Step 2: Configure Project Dependencies
Update `pubspec.yaml` with modern packages that support both web and macOS:

```yaml
name: flutter_demo_app
description: A modern Flutter demo application for Web and macOS
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.10.0"

dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.9
  
  # Routing
  go_router: ^12.1.3
  
  # UI & Design
  google_fonts: ^6.1.0
  gap: ^3.0.1
  
  # HTTP & Networking
  http: ^1.1.2
  
  # Platform-specific utilities
  universal_platform: ^2.0.0
  
  # Utilities
  logging: ^1.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

### Step 3: Using Dart MCP Server Tools

#### 3.1: Add Project Root to MCP Server
```dart
// Use mcp_dart_add_roots to register the project
// This allows MCP tools to work with your project
```

#### 3.2: Run Dart Format
```dart
// Use mcp_dart_dart_format to format all Dart files
// Ensures consistent code style across the project
```

#### 3.3: Run Dart Fix
```dart
// Use mcp_dart_dart_fix to apply automatic fixes
// Resolves common linting issues automatically
```

#### 3.4: Analyze Project
```dart
// Use mcp_dart_analyze_files to check for errors
// Identifies potential issues before building
```

### Step 4: Create Project Structure

#### 4.1: Core Architecture
```
lib/
├── core/
│   ├── theme/
│   │   └── app_theme.dart
│   ├── router/
│   │   └── app_router.dart
│   └── constants/
│       └── app_constants.dart
├── features/
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   └── widgets/
│   │   └── domain/
│   │       └── models/
│   ├── profile/
│   │   ├── presentation/
│   │   └── domain/
│   └── settings/
│       ├── presentation/
│       └── domain/
├── shared/
│   ├── presentation/
│   │   ├── widgets/
│   │   └── pages/
│   └── domain/
│       └── models/
└── main.dart
```

### Step 5: Implement Core Components

#### 5.1: App Theme (lib/core/theme/app_theme.dart)
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_platform/universal_platform.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      cardTheme: CardThemeData(
        elevation: UniversalPlatform.isWeb ? 2 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      // Platform-specific adjustments
      appBarTheme: AppBarTheme(
        elevation: UniversalPlatform.isWeb ? 0 : 1,
        centerTitle: true,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardThemeData(
        elevation: UniversalPlatform.isWeb ? 2 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      // Platform-specific adjustments
      appBarTheme: AppBarTheme(
        elevation: UniversalPlatform.isWeb ? 0 : 1,
        centerTitle: true,
      ),
    );
  }
}
```

#### 5.2: App Router (lib/core/router/app_router.dart)
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../shared/presentation/pages/main_layout.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
});
```

#### 5.3: Main App (lib/main.dart)
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: FlutterDemoApp()));
}

class FlutterDemoApp extends ConsumerWidget {
  const FlutterDemoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Flutter Demo App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
```

### Step 6: Create Feature Pages

#### 6.1: Home Page (lib/features/home/presentation/pages/home_page.dart)
```dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Flutter Demo',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            const Text(
              'This is a modern Flutter application built using MCP Server tools and best practices.',
              style: TextStyle(fontSize: 16),
            ),
            const Gap(24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureCard(
                  context,
                  'Material 3',
                  Icons.palette,
                  'Modern design system',
                ),
                _buildFeatureCard(
                  context,
                  'Responsive',
                  Icons.phone_android,
                  'Works on all devices',
                ),
                _buildFeatureCard(
                  context,
                  'Fast',
                  Icons.speed,
                  'Optimized performance',
                ),
                _buildFeatureCard(
                  context,
                  'Modern',
                  Icons.star,
                  'Latest Flutter features',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    String description,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            const Gap(8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### 6.2: Profile Page (lib/features/profile/presentation/pages/profile_page.dart)
```dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              child: Icon(Icons.person, size: 60),
            ),
            const Gap(16),
            const Text(
              'Demo User',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Text(
              'demo@example.com',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            const Gap(32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    const Text(
                      'This is a demo profile page showcasing modern Flutter development practices.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### 6.3: Settings Page (lib/features/settings/presentation/pages/settings_page.dart)
```dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Enable Notifications'),
                    subtitle: const Text('Receive app notifications'),
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Use dark theme'),
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Gap(24),
            const Text(
              'About',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Version: 1.0.0'),
                    const Gap(8),
                    const Text('Built with Flutter & MCP Server tools'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Step 7: Create Main Layout

#### 7.1: Main Layout (lib/shared/presentation/pages/main_layout.dart)
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_platform/universal_platform.dart';

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
                  onDestinationSelected: (index) => _onDestinationSelected(context, index),
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
    }
  }
}
```

### Step 8: Cross-Platform Development Considerations

#### 8.1: Platform Detection
Create a utility for platform detection (lib/core/utils/platform_utils.dart):
```dart
import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

class PlatformUtils {
  static bool get isWeb => kIsWeb;
  static bool get isMacOS => UniversalPlatform.isMacOS;
  static bool get isDesktop => UniversalPlatform.isDesktop;
  static bool get isMobile => UniversalPlatform.isMobile;
  
  static String get platformName {
    if (isWeb) return 'Web';
    if (isMacOS) return 'macOS';
    return 'Unknown';
  }
}
```

#### 8.2: Responsive Design Helper
Create a responsive design utility (lib/core/utils/responsive_utils.dart):
```dart
import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }
  
  static int getCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }
}
```

### Step 9: Using MCP Server Tools for Development

#### 9.1: Format Code
```bash
# Use mcp_dart_dart_format to format all files
# This ensures consistent code style
```

#### 9.2: Apply Fixes
```bash
# Use mcp_dart_dart_fix to apply automatic fixes
# Resolves common linting issues
```

#### 9.3: Run Tests
```bash
# Use mcp_dart_run_tests to run all tests
# Ensures code quality and functionality
```

#### 9.4: Analyze Project
```bash
# Use mcp_dart_analyze_files to check for errors
# Identifies potential issues before building
```

### Step 10: Create Tests

#### 10.1: Widget Test (test/widget_test.dart)
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_demo_app/main.dart';

void main() {
  testWidgets('Flutter Demo App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FlutterDemoApp()));
    await tester.pump();
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Home page displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FlutterDemoApp()));
    await tester.pump();
    await tester.pump();

    expect(find.text('Welcome to Flutter Demo'), findsOneWidget);
    expect(find.text('Material 3'), findsOneWidget);
  });
}
```

### Step 11: Build and Run

#### 11.1: Get Dependencies
```bash
flutter pub get
```

#### 11.2: Run Tests
```bash
flutter test
```

#### 11.3: Run the App
```bash
# For web
flutter run -d chrome

# For macOS desktop
flutter run -d macos

# List available devices
flutter devices
```

#### 11.4: Build for Production
```bash
# For web
flutter build web --release

# For macOS desktop
flutter build macos --release

# Build for both platforms
flutter build web --release && flutter build macos --release
```

## MCP Server Tools Usage Summary

### Available Tools:
1. **mcp_dart_add_roots** - Register project roots for MCP tools
2. **mcp_dart_dart_format** - Format Dart code consistently
3. **mcp_dart_dart_fix** - Apply automatic code fixes
4. **mcp_dart_run_tests** - Run tests with proper configuration
5. **mcp_dart_analyze_files** - Analyze code for errors and issues
6. **mcp_dart_pub** - Manage pub dependencies
7. **mcp_dart_create_project** - Create new Dart/Flutter projects

### Best Practices:
- Always format code before committing
- Run tests regularly during development
- Use analyze_files to catch issues early
- Apply automatic fixes when available
- Keep dependencies up to date

## Project Structure Benefits:
- **Clean Architecture**: Separation of concerns
- **Feature-based**: Organized by functionality
- **Scalable**: Easy to add new features
- **Testable**: Clear structure for testing
- **Maintainable**: Easy to understand and modify

## Modern Flutter Features Used:
- **Material 3**: Latest design system
- **Riverpod**: State management
- **Go Router**: Declarative routing
- **Google Fonts**: Typography
- **Gap**: Consistent spacing
- **Responsive Design**: Works on all screen sizes
- **Cross-Platform**: Single codebase for Web and macOS
- **Universal Platform**: Platform detection and adaptation

## Platform-Specific Considerations:

### Web Platform:
- **SEO Optimization**: Meta tags, structured data
- **Performance**: Code splitting, lazy loading
- **Responsive Design**: Mobile-first approach
- **Browser Compatibility**: Modern browser features

### macOS Desktop Platform:
- **Native Feel**: macOS-specific UI patterns
- **Window Management**: Proper window sizing and behavior
- **File System Access**: Platform-appropriate file handling
- **Menu Integration**: Native menu bar integration

## Cross-Platform Development Tips:
1. **Use Universal Platform**: Detect platform differences
2. **Responsive Layouts**: Adapt UI based on screen size
3. **Platform-Specific Assets**: Different icons/images per platform
4. **Conditional Compilation**: Use `kIsWeb` and `Platform.isMacOS`
5. **Testing**: Test on both platforms regularly

This instruction set provides a complete guide for building a modern Flutter application that works seamlessly on both Web and macOS Desktop platforms using Dart MCP Server tools, following current best practices and architectural patterns.
