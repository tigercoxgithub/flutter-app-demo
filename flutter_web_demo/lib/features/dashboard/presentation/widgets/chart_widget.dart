import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  String selectedPeriod = 'Last 7 days';

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analytics Overview',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'Track your performance metrics',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                DropdownButton<String>(
                  value: selectedPeriod,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedPeriod = newValue;
                      });
                    }
                  },
                  items: ['Last 7 days', 'Last 30 days', 'Last 90 days']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                ),
              ],
            ),

            const Gap(24),

            // Mock Chart Area
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Stack(
                children: [
                  // Mock chart lines
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _ChartPainter(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  // Data points
                  ..._generateDataPoints(context),

                  // Center info
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 48,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.5),
                        ),
                        const Gap(8),
                        Text(
                          'Performance Trending Up',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          '+15.3% from last period',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: const Duration(milliseconds: 1000)),

            const Gap(20),

            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _LegendItem(
                  color: Theme.of(context).colorScheme.primary,
                  label: 'Revenue',
                  value: '\$12,450',
                ),
                _LegendItem(
                  color: Theme.of(context).colorScheme.secondary,
                  label: 'Users',
                  value: '2,340',
                ),
                _LegendItem(
                  color: Theme.of(context).colorScheme.tertiary,
                  label: 'Sessions',
                  value: '4,567',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateDataPoints(BuildContext context) {
    final points = <Widget>[];
    final random = [0.2, 0.4, 0.3, 0.6, 0.5, 0.8, 0.7];

    for (int i = 0; i < random.length; i++) {
      points.add(
        Positioned(
          left: (i / (random.length - 1)) * 280 + 20,
          top: 50 + (1 - random[i]) * 200,
          child:
              Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.3),
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  )
                  .animate(delay: Duration(milliseconds: 200 + (i * 100)))
                  .scale(
                    begin: const Offset(0, 0),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                  ),
        ),
      );
    }

    return points;
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const Gap(8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const Gap(4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ChartPainter extends CustomPainter {
  final Color color;

  _ChartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = [0.2, 0.4, 0.3, 0.6, 0.5, 0.8, 0.7];

    for (int i = 0; i < points.length; i++) {
      final x = (i / (points.length - 1)) * size.width;
      final y = size.height * 0.2 + (1 - points[i]) * size.height * 0.6;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

