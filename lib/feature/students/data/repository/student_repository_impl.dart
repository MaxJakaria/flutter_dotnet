import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/exception.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/students/data/data_sources/student_remote_data_source.dart';
import 'package:flutter_dotnet/feature/students/data/models/student_model.dart';
import 'package:flutter_dotnet/feature/students/domain/entities/student.dart';
import 'package:flutter_dotnet/feature/students/domain/repository/student_repository.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;

  StudentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addStudent(Student student) async {
    try {
      final studentModel = StudentModel(
        studentId: student.studentId,
        name: student.name,
        email: student.email,
        cgpa: student.cgpa,
        deptId: student.deptId,
      );

      await remoteDataSource.addStudent(studentModel);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Student>>> getStudents() async {
    try {
      final students = await remoteDataSource.getStudents();

      return Right(students);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Student>> getStudentsById(int studentId) async {
    try {
      final student = await remoteDataSource.getStudentsById(studentId);

      return Right(student);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateStudent(Student student) async {
    try {
      final studentModel = StudentModel(
        studentId: student.studentId,
        name: student.name,
        email: student.email,
        cgpa: student.cgpa,
        deptId: student.deptId,
      );

      await remoteDataSource.updateStudent(studentModel);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(int studentId) async {
    try {
      await remoteDataSource.deleteStudent(studentId);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
