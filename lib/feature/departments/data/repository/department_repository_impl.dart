import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/departments/data/data_sources/department_remote_data_source.dart';
import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';
import 'package:flutter_dotnet/feature/departments/domain/repository/department_repository.dart';

class DepartmentRepositoryImpl implements DepartmentRepository {
  final DepartmentRemoteDataSource remoteDataSource;

  DepartmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Department>>> getAllDepartments() async {
    try {
      final departments = await remoteDataSource.getAllDepartments();

      return Right(departments);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
