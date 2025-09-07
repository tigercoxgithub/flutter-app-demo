import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Settings',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
            ).animate().slideX(
              begin: -0.3,
              duration: const Duration(milliseconds: 600),
            ),

            const Gap(32),

            // Appearance Settings
            _SettingsSection(
              title: 'Appearance',
              icon: Icons.palette_outlined,
              children: [
                _SettingsTile(
                  title: 'Dark Mode',
                  subtitle: 'Switch between light and dark themes',
                  leading: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  ),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).state = value;
                    },
                  ),
                ),
                const _SettingsTile(
                  title: 'Language',
                  subtitle: 'English (US)',
                  leading: Icon(Icons.language),
                  trailing: Icon(Icons.chevron_right),
                ),
                const _SettingsTile(
                  title: 'Font Size',
                  subtitle: 'Medium',
                  leading: Icon(Icons.text_fields),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ).animate().slideY(
              begin: 0.3,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
            ),

            const Gap(24),

            // Notifications Settings
            const _SettingsSection(
              title: 'Notifications',
              icon: Icons.notifications_outlined,
              children: [
                _SettingsTile(
                  title: 'Push Notifications',
                  subtitle: 'Receive notifications on your device',
                  leading: Icon(Icons.notifications),
                  trailing: Switch(value: true, onChanged: null),
                ),
                _SettingsTile(
                  title: 'Email Notifications',
                  subtitle: 'Receive notifications via email',
                  leading: Icon(Icons.email),
                  trailing: Switch(value: false, onChanged: null),
                ),
                _SettingsTile(
                  title: 'Marketing Emails',
                  subtitle: 'Receive promotional content',
                  leading: Icon(Icons.campaign),
                  trailing: Switch(value: true, onChanged: null),
                ),
              ],
            ).animate().slideY(
              begin: 0.3,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 400),
            ),

            const Gap(24),

            // Privacy & Security Settings
            const _SettingsSection(
              title: 'Privacy & Security',
              icon: Icons.security_outlined,
              children: [
                _SettingsTile(
                  title: 'Two-Factor Authentication',
                  subtitle: 'Add an extra layer of security',
                  leading: Icon(Icons.security),
                  trailing: Icon(Icons.chevron_right),
                ),
                _SettingsTile(
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  leading: Icon(Icons.privacy_tip),
                  trailing: Icon(Icons.chevron_right),
                ),
                _SettingsTile(
                  title: 'Data Export',
                  subtitle: 'Download your data',
                  leading: Icon(Icons.download),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ).animate().slideY(
              begin: 0.3,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 600),
            ),

            const Gap(24),

            // Support Settings
            const _SettingsSection(
              title: 'Support',
              icon: Icons.help_outline,
              children: [
                _SettingsTile(
                  title: 'Help Center',
                  subtitle: 'Get help and support',
                  leading: Icon(Icons.help),
                  trailing: Icon(Icons.chevron_right),
                ),
                _SettingsTile(
                  title: 'Contact Us',
                  subtitle: 'Send us a message',
                  leading: Icon(Icons.contact_support),
                  trailing: Icon(Icons.chevron_right),
                ),
                _SettingsTile(
                  title: 'Report a Bug',
                  subtitle: 'Help us improve the app',
                  leading: Icon(Icons.bug_report),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ).animate().slideY(
              begin: 0.3,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 800),
            ),

            const Gap(24),

            // About Settings
            const _SettingsSection(
              title: 'About',
              icon: Icons.info_outline,
              children: [
                _SettingsTile(
                  title: 'Version',
                  subtitle: '1.0.0 (Build 1)',
                  leading: Icon(Icons.info),
                ),
                _SettingsTile(
                  title: 'Terms of Service',
                  subtitle: 'Read our terms and conditions',
                  leading: Icon(Icons.description),
                  trailing: Icon(Icons.chevron_right),
                ),
                _SettingsTile(
                  title: 'Licenses',
                  subtitle: 'View open source licenses',
                  leading: Icon(Icons.code),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ).animate().slideY(
              begin: 0.3,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 1000),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const Gap(12),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Gap(16),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: leading,
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}

