import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../core/providers/theme_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _notificationsEnabled = true;
  DateTime _currentDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update date/time every second
    _startDateTimeTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startDateTimeTimer() {
    // Update every second
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _currentDateTime = DateTime.now();
        });
        _startDateTimeTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

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
                  ListTile(
                    title: const Text('Theme Mode'),
                    subtitle: Text(_getThemeModeText(themeMode)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      _showThemeModeDialog(context, themeNotifier, themeMode);
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
                    _buildInfoRow('App Name', 'Flutter Demo App'),
                    const Gap(12),
                    _buildInfoRow('Version', '1.0.0+1'),
                    const Gap(12),
                    _buildInfoRow('Build Date', _formatDate(_currentDateTime)),
                    const Gap(12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Current Time:',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _formatTime(_currentDateTime),
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentDateTime = DateTime.now();
                            });
                          },
                          icon: const Icon(Icons.refresh),
                          tooltip: 'Refresh time',
                        ),
                      ],
                    ),
                    const Gap(12),
                    _buildInfoRow('Platform', _getPlatformInfo()),
                    const Gap(12),
                    _buildInfoRow('Framework', 'Flutter 3.35.3'),
                    const Gap(12),
                    _buildInfoRow('Dart SDK', '3.9.2'),
                    const Gap(12),
                    _buildInfoRow('Theme Mode', _getThemeModeText(themeMode)),
                    const Gap(16),
                    const Divider(),
                    const Gap(12),
                    const Text(
                      'Built with modern Flutter development practices:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Gap(8),
                    const Text('• Material 3 Design System'),
                    const Text('• Riverpod State Management'),
                    const Text('• Go Router Navigation'),
                    const Text('• Google Fonts Typography'),
                    const Text('• Cross-platform Support (Web & macOS)'),
                    const Text('• Dart MCP Server Tools'),
                    const Gap(12),
                    const Text(
                      'This demo showcases a modern Flutter application with responsive design, theme switching, and cross-platform compatibility.',
                      style: TextStyle(fontStyle: FontStyle.italic),
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('EEEE, MMMM d, yyyy').format(dateTime);
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  String _getPlatformInfo() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return 'iOS';
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      return 'Android';
    } else if (Theme.of(context).platform == TargetPlatform.macOS) {
      return 'macOS';
    } else if (Theme.of(context).platform == TargetPlatform.windows) {
      return 'Windows';
    } else if (Theme.of(context).platform == TargetPlatform.linux) {
      return 'Linux';
    } else {
      return 'Web';
    }
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  void _showThemeModeDialog(BuildContext context, ThemeModeNotifier notifier, ThemeMode currentMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme Mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ignore: deprecated_member_use
            RadioListTile<ThemeMode>(
              title: const Text('Light'),
              subtitle: const Text('Always use light theme'),
              value: ThemeMode.light,
              // ignore: deprecated_member_use
              groupValue: currentMode,
              // ignore: deprecated_member_use
              onChanged: (value) {
                if (value != null) {
                  notifier.setThemeMode(value);
                  Navigator.of(context).pop();
                }
              },
            ),
            // ignore: deprecated_member_use
            RadioListTile<ThemeMode>(
              title: const Text('Dark'),
              subtitle: const Text('Always use dark theme'),
              value: ThemeMode.dark,
              // ignore: deprecated_member_use
              groupValue: currentMode,
              // ignore: deprecated_member_use
              onChanged: (value) {
                if (value != null) {
                  notifier.setThemeMode(value);
                  Navigator.of(context).pop();
                }
              },
            ),
            // ignore: deprecated_member_use
            RadioListTile<ThemeMode>(
              title: const Text('System'),
              subtitle: const Text('Follow system theme'),
              value: ThemeMode.system,
              // ignore: deprecated_member_use
              groupValue: currentMode,
              // ignore: deprecated_member_use
              onChanged: (value) {
                if (value != null) {
                  notifier.setThemeMode(value);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
