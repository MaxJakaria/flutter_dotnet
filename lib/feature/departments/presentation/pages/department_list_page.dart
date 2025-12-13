import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotnet/feature/departments/presentation/bloc/department_bloc.dart';

class DepartmentListPage extends StatefulWidget {
  const DepartmentListPage({super.key});

  @override
  State<DepartmentListPage> createState() => _DepartmentListPageState();
}

class _DepartmentListPageState extends State<DepartmentListPage> {
  @override
  void initState() {
    // Call event when page is loaded
    context.read<DepartmentBloc>().add(GetDepartmentsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Departments List',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocBuilder<DepartmentBloc, DepartmentState>(
        builder: (context, state) {
          if (state is DepartmentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DepartmentLoaded) {
            if (state.departments.isEmpty) {
              return const Center(child: Text("No departments found."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.departments.length,
              itemBuilder: (context, index) {
                final dept = state.departments[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      child: Text('${dept.departmentId}'),
                    ),

                    title: Text(
                      dept.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text("ID: ${dept.departmentId}"),
                  ),
                );
              },
            );
          } else if (state is DepartmentError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      context.read<DepartmentBloc>().add(GetDepartmentsEvent());
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("Initializing..."));
        },
      ),
    );
  }
}
