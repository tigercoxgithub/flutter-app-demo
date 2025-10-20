import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/3d_viewer/presentation/pages/viewer_3d_page.dart';
import '../../features/webview/presentation/pages/webview_page.dart';
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
          GoRoute(
            path: '/3d-viewer',
            name: '3d-viewer',
            builder: (context, state) => const Viewer3DPage(),
          ),
          GoRoute(
            path: '/webview',
            name: 'webview',
            builder: (context, state) => const WebViewPage(),
          ),
        ],
      ),
    ],
  );
});
