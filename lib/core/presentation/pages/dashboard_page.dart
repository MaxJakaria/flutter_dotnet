import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotnet/core/presentation/widgets/action_card.dart';
import 'package:flutter_dotnet/core/presentation/widgets/recent_students_card.dart';
import 'package:flutter_dotnet/core/presentation/widgets/stat_card.dart';
import 'package:flutter_dotnet/core/theme/app_theme.dart';
import 'package:flutter_dotnet/feature/students/presentation/bloc/student_bloc.dart';
import 'package:flutter_dotnet/init_dependencies.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late StudentBloc _studentBloc;

  @override
  void initState() {
    super.initState();
    _studentBloc = serviceLocator<StudentBloc>();
    _studentBloc.add(GetStudentsEvent());
  }

  @override
  void dispose() {
    _studentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 1000;
        final horizontalPadding = isWide
            ? const EdgeInsets.symmetric(horizontal: 32, vertical: 24)
            : const EdgeInsets.all(20);

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Custom App Bar (theme-aware for light & dark)
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: theme.colorScheme.surface.withValues(
                  alpha: 0.95,
                ),
                surfaceTintColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.menu_outlined),
                  onPressed: () {},
                  color: theme.colorScheme.onSurface,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                    color: theme.colorScheme.onSurface,
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () {},
                    color: theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 8),
                ],
                title: Text(
                  'University DB',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                centerTitle: false,
              ),

              // Content
              SliverPadding(
                padding: horizontalPadding,
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Stat Cards Row with BLoC
                    BlocBuilder<StudentBloc, StudentState>(
                      bloc: _studentBloc,
                      builder: (context, state) {
                        final studentCount = (state is StudentsLoaded)
                            ? state.students.length.toString()
                            : '0';

                        return Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                icon: Icons.school_outlined,
                                title: 'Students',
                                value: studentCount,
                                trend: '+12%',
                                trendUp: true,
                                gradient: AppTheme.primaryCyan,
                                onTap: () {
                                  // Navigate to students
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: StatCard(
                                icon: Icons.apartment_outlined,
                                title: 'Departments',
                                value: '18',
                                trend: '+2 new',
                                trendUp: true,
                                gradient: AppTheme.accentViolet,
                                onTap: () {
                                  // Navigate to departments
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    // Quick Actions Section
                    Text(
                      'Quick Actions',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Action Cards responsive layout
                    if (isWide)
                      Row(
                        children: [
                          Expanded(
                            child: ActionCard(
                              icon: Icons.person_add_outlined,
                              title: 'Enroll New Student',
                              subtitle: 'Add student to the system',
                              gradient: const LinearGradient(
                                colors: [
                                  AppTheme.primaryCyan,
                                  Color(0xFF0EA5E9),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              onTap: () {
                                // Navigate to add student
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ActionCard(
                              icon: Icons.business_outlined,
                              title: 'Create Department',
                              subtitle: 'Set up a new department',
                              gradient: const LinearGradient(
                                colors: [
                                  AppTheme.accentViolet,
                                  AppTheme.accentPurple,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              onTap: () {
                                // Navigate to add department
                              },
                            ),
                          ),
                        ],
                      )
                    else ...[
                      ActionCard(
                        icon: Icons.person_add_outlined,
                        title: 'Enroll New Student',
                        subtitle: 'Add student to the system',
                        gradient: const LinearGradient(
                          colors: [AppTheme.primaryCyan, Color(0xFF0EA5E9)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () {
                          // Navigate to add student
                        },
                      ),
                      const SizedBox(height: 12),
                      ActionCard(
                        icon: Icons.business_outlined,
                        title: 'Create Department',
                        subtitle: 'Set up a new department',
                        gradient: const LinearGradient(
                          colors: [
                            AppTheme.accentViolet,
                            AppTheme.accentPurple,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () {
                          // Navigate to add department
                        },
                      ),
                    ],

                    const SizedBox(height: 32),

                    // Recent Students Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Students',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to all students
                          },
                          child: const Text('View All'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Recent Students List with BLoC
                    BlocBuilder<StudentBloc, StudentState>(
                      bloc: _studentBloc,
                      builder: (context, state) {
                        if (state is StudentLoading) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          );
                        } else if (state is StudentsLoaded) {
                          return RecentStudentsCard(students: state.students);
                        } else if (state is StudentError) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Error: ${state.message}',
                              style: TextStyle(color: theme.colorScheme.error),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    const SizedBox(height: 24),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
