import 'package:flutter/material.dart';

class ActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final VoidCallback? onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    this.onTap,
  });
  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;
        final padding = isWide ? 24.0 : 18.0;
        final iconSize = isWide ? 28.0 : 22.0;
        final titleSize = isWide ? 18.0 : 16.0;
        final subtitleSize = isWide ? 14.0 : 13.0;
        final radius = isWide ? 18.0 : 14.0;

        return MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            transform: _hovering
                ? (Matrix4.identity()..translateByDouble(1.0, -2.0, 0.0, 1.0))
                : Matrix4.identity(),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(20),
                child: Ink(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.gradient.colors
                          .map((c) => c.withValues(alpha: isDark ? 0.08 : 0.12))
                          .toList(),
                      begin: widget.gradient.begin,
                      end: widget.gradient.end,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.gradient.colors.first.withValues(
                        alpha: isDark ? 0.28 : 0.36,
                      ),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(padding * 0.6),
                        decoration: BoxDecoration(
                          gradient: widget.gradient,
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        child: Icon(
                          widget.icon,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ),
                      SizedBox(width: isWide ? 20 : 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: titleSize,
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.subtitle,
                              style: TextStyle(
                                fontSize: subtitleSize,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: isWide ? 18 : 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
