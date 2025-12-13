import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';
import 'package:flutter_dotnet/feature/departments/domain/repository/department_repository.dart';

class CreateDepartmentUseCase {
  final DepartmentRepository repository;

  CreateDepartmentUseCase({required this.repository});

  Future<Either<Failure, Department>> call(Department department) async {
    return await repository.createDepartment(department);
  }
}
