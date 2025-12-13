import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';
import 'package:flutter_dotnet/feature/departments/domain/repository/department_repository.dart';

class GetAllDepartmentsUseCase {
  final DepartmentRepository repository;

  GetAllDepartmentsUseCase({required this.repository});

  Future<Either<Failure, List<Department>>> call() async {
    return await repository.getAllDepartments();
  }
}
