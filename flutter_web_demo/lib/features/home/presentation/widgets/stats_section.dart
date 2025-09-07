import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
            childAspectRatio: 2.5,
          ),
          itemCount: _stats.length,
          itemBuilder: (context, index) {
            final stat = _stats[index];
            return _StatCard(
              title: stat.title,
              value: stat.value,
              icon: stat.icon,
              color: stat.color,
              trend: stat.trend,
            ).animate().scale(
              begin: const Offset(0.8, 0.8),
              duration: Duration(milliseconds: 400 + (index * 100)),
              delay: const Duration(milliseconds: 200),
              curve: Curves.easeOutBack,
            );
          },
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double trend;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: trend > 0
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trend > 0 ? Icons.trending_up : Icons.trending_down,
                        size: 12,
                        color: trend > 0 ? Colors.green : Colors.red,
                      ),
                      const Gap(2),
                      Text(
                        '${trend.abs().toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: trend > 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const Gap(4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double trend;

  const _Stat({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
  });
}

const List<_Stat> _stats = [
  _Stat(
    title: 'Active Users',
    value: '2.4k',
    icon: Icons.people,
    color: Colors.blue,
    trend: 12.5,
  ),
  _Stat(
    title: 'Performance Score',
    value: '98%',
    icon: Icons.speed,
    color: Colors.green,
    trend: 5.2,
  ),
  _Stat(
    title: 'Page Load Time',
    value: '1.2s',
    icon: Icons.timer,
    color: Colors.orange,
    trend: -8.3,
  ),
  _Stat(
    title: 'User Satisfaction',
    value: '4.9',
    icon: Icons.star,
    color: Colors.purple,
    trend: 3.1,
  ),
];

