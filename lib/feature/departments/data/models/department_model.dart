import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';

class DepartmentModel extends Department {
  const DepartmentModel({required super.departmentId, required super.name});

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      departmentId: (json['departmentId'] as int?) ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'departmentId': departmentId, 'name': name};
  }
}
