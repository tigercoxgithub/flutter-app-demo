import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/analytics_card.dart';
import '../widgets/chart_widget.dart';
import '../widgets/activity_feed.dart';
import '../widgets/quick_actions.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const Gap(4),
                    Text(
                      'Welcome back! Here\'s what\'s happening.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                ),
              ],
            ).animate().slideX(
              begin: -0.3,
              duration: const Duration(milliseconds: 600),
            ),

            const Gap(32),

            // Analytics Cards
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 1200
                    ? 4
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
                    childAspectRatio: 2.2,
                  ),
                  itemCount: _analyticsData.length,
                  itemBuilder: (context, index) {
                    final data = _analyticsData[index];
                    return AnalyticsCard(
                      title: data.title,
                      value: data.value,
                      change: data.change,
                      icon: data.icon,
                      color: data.color,
                    ).animate().scale(
                      begin: const Offset(0.8, 0.8),
                      duration: Duration(milliseconds: 400 + (index * 100)),
                      delay: const Duration(milliseconds: 200),
                      curve: Curves.easeOutBack,
                    );
                  },
                );
              },
            ),

            const Gap(32),

            // Charts and Activity
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1200) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            const ChartWidget().animate().slideY(
                              begin: 0.3,
                              duration: const Duration(milliseconds: 600),
                              delay: const Duration(milliseconds: 600),
                            ),
                            const Gap(24),
                            const QuickActions().animate().slideY(
                              begin: 0.3,
                              duration: const Duration(milliseconds: 600),
                              delay: const Duration(milliseconds: 800),
                            ),
                          ],
                        ),
                      ),
                      const Gap(24),
                      Expanded(
                        flex: 1,
                        child: const ActivityFeed().animate().slideX(
                          begin: 0.3,
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 1000),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      const ChartWidget().animate().slideY(
                        begin: 0.3,
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 600),
                      ),
                      const Gap(24),
                      const QuickActions().animate().slideY(
                        begin: 0.3,
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 800),
                      ),
                      const Gap(24),
                      const ActivityFeed().animate().slideY(
                        begin: 0.3,
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 1000),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AnalyticsData {
  final String title;
  final String value;
  final double change;
  final IconData icon;
  final Color color;

  const _AnalyticsData({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
  });
}

const List<_AnalyticsData> _analyticsData = [
  _AnalyticsData(
    title: 'Total Revenue',
    value: '\$45,231',
    change: 12.5,
    icon: Icons.attach_money,
    color: Colors.green,
  ),
  _AnalyticsData(
    title: 'New Users',
    value: '1,234',
    change: 8.3,
    icon: Icons.person_add,
    color: Colors.blue,
  ),
  _AnalyticsData(
    title: 'Page Views',
    value: '89,432',
    change: -2.1,
    icon: Icons.visibility,
    color: Colors.orange,
  ),
  _AnalyticsData(
    title: 'Conversion Rate',
    value: '3.2%',
    change: 5.7,
    icon: Icons.trending_up,
    color: Colors.purple,
  ),
];

