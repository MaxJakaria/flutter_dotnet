import 'package:flutter/material.dart';
import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';

class DepartmentTile extends StatefulWidget {
  final Department department;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const DepartmentTile({
    super.key,
    required this.department,
    required this.onDelete,
    this.onEdit,
  });

  @override
  State<DepartmentTile> createState() => _DepartmentTileState();
}

class _DepartmentTileState extends State<DepartmentTile> {
  bool _hover = false;

  void _setHover(bool v) {
    if (_hover == v) return;
    setState(() => _hover = v);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final scale = _hover ? 1.01 : 1.0;
    final elevation = _hover ? 12.0 : 6.0;

    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.surface, color.surfaceContainerHighest],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(0, 0, 0, 0.06),
                blurRadius: elevation,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              onLongPress: widget.onEdit,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: color.primary,
                      foregroundColor: color.onPrimary,
                      child: Text(
                        widget.department.departmentId.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.department.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ID: ${widget.department.departmentId}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: color.onSurface.withAlpha(
                                    (0.72 * 255).round(),
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      tooltip: 'Delete',
                      onPressed: widget.onDelete,
                      icon: Icon(
                        Icons.delete_outline,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
