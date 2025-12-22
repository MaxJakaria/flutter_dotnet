import 'package:flutter/material.dart';
import 'package:flutter_dotnet/core/theme/app_theme.dart';
import 'package:flutter_dotnet/feature/students/domain/entities/student.dart';

class RecentStudentsCard extends StatelessWidget {
  final List<Student> students;

  const RecentStudentsCard({super.key, this.students = const []});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Show up to 4 recent students
    final displayStudents = students.take(4).toList();

    if (displayStudents.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark
              ? AppTheme.slate800.withValues(alpha: 0.4)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? AppTheme.slate700.withValues(alpha: 0.5)
                : AppTheme.slate200,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            'No students yet',
            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.slate800.withValues(alpha: 0.4) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? AppTheme.slate700.withValues(alpha: 0.5)
              : AppTheme.slate200,
          width: 1,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        itemCount: displayStudents.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: isDark
              ? AppTheme.slate700.withValues(alpha: 0.3)
              : AppTheme.slate200,
        ),
        itemBuilder: (context, index) {
          final student = displayStudents[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppTheme.primaryCyan.withValues(
                    alpha: isDark ? 0.2 : 0.15,
                  ),
                  child: Text(
                    student.name.substring(0, 2).toUpperCase(),
                    style: const TextStyle(
                      color: AppTheme.primaryCyan,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        student.departmentName ?? 'N/A',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
