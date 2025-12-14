import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';
import 'package:flutter_dotnet/feature/departments/presentation/bloc/department_bloc.dart';

class AddDepartmentSheet extends StatefulWidget {
  final Department? initialDepartment;

  const AddDepartmentSheet({super.key, this.initialDepartment});

  @override
  State<AddDepartmentSheet> createState() => _AddDepartmentSheetState();
}

class _AddDepartmentSheetState extends State<AddDepartmentSheet> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool get _isEditing => widget.initialDepartment != null;

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialDepartment != null) {
      _idController.text = widget.initialDepartment!.departmentId.toString();
      _nameController.text = widget.initialDepartment!.name;
    }
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final id = _isEditing
        ? widget.initialDepartment!.departmentId
        : int.parse(_idController.text.trim());
    final name = _nameController.text.trim();
    final newDept = Department(departmentId: id, name: name);
    if (_isEditing) {
      context.read<DepartmentBloc>().add(
        UpdateDepartmentEvent(department: newDept),
      );
      Navigator.pop(context);
    } else {
      context.read<DepartmentBloc>().add(
        CreateDepartmentEvent(department: newDept),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isEditing ? 'Edit Department' : 'Create Department',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    readOnly: _isEditing,
                    decoration: const InputDecoration(
                      labelText: 'Department ID',
                      prefixIcon: Icon(Icons.numbers),
                    ),
                    validator: (v) {
                      if (_isEditing) return null;
                      if (v == null || v.isEmpty) return 'Enter ID';
                      if (int.tryParse(v) == null) return 'Enter valid number';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Department Name',
                      prefixIcon: Icon(Icons.school),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Enter Name' : null,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _save,
                      child: const Text(
                        'Save Department',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
