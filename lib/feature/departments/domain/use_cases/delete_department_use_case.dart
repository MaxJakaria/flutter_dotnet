import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/departments/domain/repository/department_repository.dart';

class DeleteDepartmentUseCase {
  final DepartmentRepository repository;

  DeleteDepartmentUseCase({required this.repository});

  Future<Either<Failure, void>> call(int deptId) async {
    return await repository.deleteDepartment(deptId);
  }
}
