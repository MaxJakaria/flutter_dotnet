import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/exception.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/departments/data/data_sources/department_remote_data_source.dart';
import 'package:flutter_dotnet/feature/departments/data/models/department_model.dart';
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
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Department>> createDepartment(
    Department department,
  ) async {
    try {
      final model = DepartmentModel(
        departmentId: department.departmentId,
        name: department.name,
      );

      final result = await remoteDataSource.createDepartment(model);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDepartment(int deptId) async {
    try {
      await remoteDataSource.deleteDepartment(deptId);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
