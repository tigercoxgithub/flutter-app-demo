import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ActivityFeed extends StatelessWidget {
  const ActivityFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),

            const Gap(20),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _activities.length,
              separatorBuilder: (context, index) => const Gap(16),
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return _ActivityItem(
                  icon: activity.icon,
                  title: activity.title,
                  description: activity.description,
                  time: activity.time,
                  color: activity.color,
                ).animate().slideX(
                  begin: 0.3,
                  duration: Duration(milliseconds: 400 + (index * 100)),
                  delay: const Duration(milliseconds: 200),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String time;
  final Color color;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),

        const Gap(12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Gap(2),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),

        Text(
          time,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

class _Activity {
  final IconData icon;
  final String title;
  final String description;
  final String time;
  final Color color;

  const _Activity({
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
    required this.color,
  });
}

const List<_Activity> _activities = [
  _Activity(
    icon: Icons.person_add,
    title: 'New User Registered',
    description: 'John Doe joined the platform',
    time: '2m ago',
    color: Colors.blue,
  ),
  _Activity(
    icon: Icons.shopping_cart,
    title: 'Order Completed',
    description: 'Order #1234 has been processed',
    time: '5m ago',
    color: Colors.green,
  ),
  _Activity(
    icon: Icons.payment,
    title: 'Payment Received',
    description: 'Payment of \$299.99 received',
    time: '12m ago',
    color: Colors.purple,
  ),
  _Activity(
    icon: Icons.bug_report,
    title: 'Issue Reported',
    description: 'Bug report submitted by user',
    time: '18m ago',
    color: Colors.red,
  ),
  _Activity(
    icon: Icons.update,
    title: 'System Update',
    description: 'Database optimization completed',
    time: '1h ago',
    color: Colors.orange,
  ),
  _Activity(
    icon: Icons.backup,
    title: 'Backup Created',
    description: 'Daily backup completed successfully',
    time: '2h ago',
    color: Colors.teal,
  ),
];

