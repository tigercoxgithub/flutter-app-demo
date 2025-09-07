import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.2),
            Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 768;

          if (isDesktop) {
            return Row(
              children: [
                Expanded(flex: 3, child: _HeroContent()),
                const Gap(48),
                Expanded(flex: 2, child: _HeroVisual()),
              ],
            );
          } else {
            return Column(
              children: [_HeroContent(), const Gap(32), _HeroVisual()],
            );
          }
        },
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.flutter_dash,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const Gap(6),
              Text(
                'Built with Flutter',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ).animate().scale(
          begin: const Offset(0.8, 0.8),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
        ),
        const Gap(24),

        Text(
          'Modern Flutter Web Experience',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ).animate().slideX(
          begin: -0.3,
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 200),
        ),
        const Gap(16),

        Text(
          'Experience the power of Flutter on the web with this modern, responsive demo application. Built with the latest Material 3 design system, state-of-the-art animations, and best practices.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            height: 1.6,
          ),
        ).animate().slideX(
          begin: -0.3,
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 400),
        ),
        const Gap(32),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              label: const Text('Get Started'),
            ).animate().scale(
              begin: const Offset(0.8, 0.8),
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.code),
              label: const Text('View Source'),
            ).animate().scale(
              begin: const Offset(0.8, 0.8),
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 700),
              curve: Curves.easeOutBack,
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
            Theme.of(context).colorScheme.secondary.withOpacity(0.6),
            Theme.of(context).colorScheme.tertiary.withOpacity(0.4),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Floating elements
          Positioned(
            top: 40,
            right: 40,
            child:
                Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.flutter_dash,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .rotate(duration: const Duration(seconds: 10)),
          ),

          Positioned(
            bottom: 60,
            left: 40,
            child:
                Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.web,
                        color: Colors.white,
                        size: 40,
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      begin: const Offset(1.0, 1.0),
                      end: const Offset(1.1, 1.1),
                      duration: const Duration(seconds: 2),
                    ),
          ),

          Center(
            child:
                Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.rocket_launch,
                        color: Colors.white,
                        size: 60,
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .slideY(
                      begin: 0,
                      end: -0.1,
                      duration: const Duration(seconds: 3),
                    ),
          ),
        ],
      ),
    ).animate().fadeIn(
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 800),
    );
  }
}

