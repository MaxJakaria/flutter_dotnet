import 'package:flutter_dotnet/feature/students/domain/entities/student.dart';

class StudentModel extends Student {
  StudentModel({
    required super.studentId,
    required super.name,
    required super.email,
    required super.cgpa,
    required super.deptId,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentId: (json['studentId'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      cgpa: (json['cgpa'] as num?)?.toDouble() ?? 0.0,
      deptId: (json['departmentId'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'name': name,
      'email': email,
      'cgpa': cgpa,
      'departmentId': deptId,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {'studentId': studentId, 'name': name, 'departmentId': deptId};
  }
}
