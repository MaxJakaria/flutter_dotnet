// Clean single-definition implementation for DepartmentListPage
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';
import 'package:flutter_dotnet/feature/departments/presentation/bloc/department_bloc.dart';
import 'package:flutter_dotnet/feature/departments/presentation/widgets/department_body.dart';
import 'package:flutter_dotnet/feature/departments/presentation/widgets/add_department_sheet.dart';

class DepartmentListPage extends StatefulWidget {
  const DepartmentListPage({super.key});

  @override
  State<DepartmentListPage> createState() => _DepartmentListPageState();
}

class _PremiumFab extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;
  final bool extended;

  const _PremiumFab({
    required this.onPressed,
    required this.icon,
    required this.label,
    this.extended = true,
  });

  @override
  State<_PremiumFab> createState() => _PremiumFabState();
}

class _PremiumFabState extends State<_PremiumFab> {
  bool _hover = false;

  void _setHover(bool v) {
    if (_hover == v) return;
    setState(() => _hover = v);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final scale = _hover ? 1.03 : 1.0;

    final primary = colors.primary;
    final primaryHsl = HSLColor.fromColor(primary);
    final darkerPrimary = primaryHsl
        .withLightness((primaryHsl.lightness * 0.7).clamp(0.0, 1.0))
        .toColor();

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      padding: widget.extended
          ? const EdgeInsets.symmetric(horizontal: 18, vertical: 12)
          : const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primary, darkerPrimary],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.12),
            blurRadius: _hover ? 18 : 10,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: IconThemeData(color: colors.onPrimary),
            child: widget.icon,
          ),
          if (widget.extended) ...[
            const SizedBox(width: 10),
            DefaultTextStyle(
              style: TextStyle(
                color: colors.onPrimary,
                fontWeight: FontWeight.w700,
              ),
              child: Text(widget.label),
            ),
          ],
        ],
      ),
    );

    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: widget.onPressed,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _DepartmentListPageState extends State<DepartmentListPage> {
  String _searchQuery = '';
  late final TextEditingController _searchController;
  List<Department>? _lastDepartments;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: _searchQuery);
    _searchController.addListener(() {
      if (mounted) setState(() => _searchQuery = _searchController.text);
    });
    context.read<DepartmentBloc>().add(GetDepartmentsEvent());
  }

  @override
  void dispose() {
    _searchController.removeListener(() {});
    _searchController.dispose();
    super.dispose();
  }

  void _refresh() => context.read<DepartmentBloc>().add(GetDepartmentsEvent());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final Widget fab = _PremiumFab(
      onPressed: () => _showAddDepartmentSheet(context),
      icon: Icon(screenWidth >= 700 ? Icons.add_rounded : Icons.add),
      label: 'New Department',
      extended: screenWidth >= 700,
    );

    return Scaffold(
      floatingActionButton: fab,
      floatingActionButtonLocation: screenWidth >= 700
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        titleSpacing: 16,
        title: Row(
          children: [
            Icon(Icons.school_outlined, size: 22, color: Theme.of(context).colorScheme.onSurface),
            const SizedBox(width: 10),
            Text('Departments', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _refresh,
            icon: Icon(Icons.refresh, color: Theme.of(context).colorScheme.onSurface),
            tooltip: 'Refresh',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(84),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              children: [
                // Rounded, filled search field inside AppBar for a premium look
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurfaceVariant),
                      hintText: 'Search departments by name or ID',
                      border: InputBorder.none,
                      suffixIcon: _searchQuery.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () => _searchController.clear(),
                              icon: Icon(Icons.clear, color: Theme.of(context).colorScheme.onSurfaceVariant),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // result count aligned left for easy scanning
                BlocBuilder<DepartmentBloc, DepartmentState>(
                  builder: (context, state) {
                    final count = _filteredCount(state);
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$count result${count == 1 ? '' : 's'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return BlocConsumer<DepartmentBloc, DepartmentState>(
              listener: (context, state) {
                if (state is DepartmentLoaded) {
                  _lastDepartments = state.departments;
                }

                if (state is DepartmentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final content = DepartmentBody(
                  state: state,
                  fallbackDepartments: _lastDepartments,
                  searchQuery: _searchQuery,
                  showSearchBar: false,
                  onSearchChanged: (v) => setState(() => _searchQuery = v),
                  onRefresh: _refresh,
                  onDelete: (department) => _confirmDelete(context, department),
                  onAdd: () => _showAddDepartmentSheet(context),
                );

                // Small screens: single column (content takes full width)
                if (width < 700) {
                  return content;
                }

                // Medium screens: center content with max width
                if (width < 1000) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: content,
                    ),
                  );
                }

                // Large screens: center content (overview removed)
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: content,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  int _filteredCount(DepartmentState state) {
    List<Department> source = [];
    if (state is DepartmentLoaded) {
      source = state.departments;
    } else if (_lastDepartments != null) {
      source = _lastDepartments!;
    }
    if (_searchQuery.trim().isEmpty) return source.length;
    final q = _searchQuery.toLowerCase();
    return source
        .where(
          (d) =>
              d.name.toLowerCase().contains(q) ||
              d.departmentId.toString().contains(q),
        )
        .length;
  }

  void _confirmDelete(BuildContext context, Department department) async {
    final bloc = context.read<DepartmentBloc>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Department'),
        content: Text('Are you sure you want to delete "${department.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      bloc.add(DeleteDepartmentEvent(deptId: department.departmentId));
    }
  }

  void _showAddDepartmentSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const AddDepartmentSheet(),
    );
  }
}
