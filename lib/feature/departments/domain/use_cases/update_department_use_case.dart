import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';
import 'package:flutter_dotnet/feature/departments/domain/repository/department_repository.dart';

class UpdateDepartmentUseCase {
  final DepartmentRepository repository;

  UpdateDepartmentUseCase({required this.repository});

  Future<Either<Failure, void>> call(Department department) {
    return repository.updateDepartment(department);
  }
}
