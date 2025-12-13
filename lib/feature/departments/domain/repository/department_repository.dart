import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import '../entities/department.dart';

abstract class DepartmentRepository {
  Future<Either<Failure, List<Department>>> getAllDepartments();
}
