import 'package:flutter/material.dart';
import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';
import 'package:flutter_dotnet/feature/departments/presentation/bloc/department_bloc.dart';
import 'package:flutter_dotnet/feature/departments/presentation/widgets/empty_state.dart';
import 'package:flutter_dotnet/feature/departments/presentation/widgets/department_tile.dart';

class DepartmentBody extends StatelessWidget {
  final DepartmentState state;
  final List<Department>? fallbackDepartments;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onRefresh;
  final ValueChanged<Department> onDelete;
  final VoidCallback onAdd;
  final bool showSearchBar;

  const DepartmentBody({
    super.key,
    required this.state,
    this.fallbackDepartments,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onRefresh,
    required this.onDelete,
    required this.onAdd,
    this.showSearchBar = true,
  });

  List<Department> _filter(List<Department> source) {
    if (searchQuery.trim().isEmpty) return source;
    final q = searchQuery.toLowerCase();
    return source
        .where(
          (d) =>
              d.name.toLowerCase().contains(q) ||
              d.departmentId.toString().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Build a search bar that's always visible for interactive states
    Widget searchBar = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search by name or ID',
          border: OutlineInputBorder(),
        ),
        onChanged: onSearchChanged,
      ),
    );

    if (state is DepartmentLoading) {
      return Column(
        children: [
          if (showSearchBar) searchBar,
          const Expanded(child: Center(child: CircularProgressIndicator())),
        ],
      );
    }

    if (state is DepartmentLoaded) {
      final items = _filter((state as DepartmentLoaded).departments);

      return Column(
        children: [
          if (showSearchBar) searchBar,
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => onRefresh(),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  // More granular breakpoints for responsive layouts
                  final columns = width >= 1400
                      ? 4
                      : (width >= 1000 ? 3 : (width >= 700 ? 2 : 1));
                  final tileAspect = width >= 1000 ? 4.5 : 3.5;

                  if (items.isEmpty) return EmptyState(onAdd: onAdd);

                  if (columns == 1) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: items.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) => DepartmentTile(
                        department: items[index],
                        onDelete: () => onDelete(items[index]),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: width >= 1000 ? 24 : 12,
                      vertical: 12,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: tileAspect,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) => DepartmentTile(
                      department: items[index],
                      onDelete: () => onDelete(items[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }

    if (state is DepartmentError) {
      final fallback = fallbackDepartments ?? [];
      if (fallback.isNotEmpty) {
        final items = _filter(fallback);
        return Column(
          children: [
            if (showSearchBar) searchBar,
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) => DepartmentTile(
                  department: items[index],
                  onDelete: () => onDelete(items[index]),
                ),
              ),
            ),
          ],
        );
      }

      return Column(
        children: [
          if (showSearchBar) searchBar,
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Something went wrong',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: onRefresh,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        if (showSearchBar) searchBar,
        const Expanded(child: Center(child: Text('Initializing...'))),
      ],
    );
  }
}
