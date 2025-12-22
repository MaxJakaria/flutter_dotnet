import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String trend;
  final bool trendUp;
  final Color gradient;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.trend,
    this.trendUp = true,
    required this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                gradient.withValues(alpha: isDark ? 0.15 : 0.2),
                gradient.withValues(alpha: isDark ? 0.05 : 0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: gradient.withValues(alpha: isDark ? 0.3 : 0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: gradient.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: gradient.withValues(alpha: isDark ? 0.2 : 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: gradient, size: 24),
                ),

                const SizedBox(height: 16),

                // Value
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),

                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 8),

                // Trend
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      trendUp ? Icons.trending_up : Icons.trending_down,
                      size: 14,
                      color: trendUp ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trend,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: trendUp ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
