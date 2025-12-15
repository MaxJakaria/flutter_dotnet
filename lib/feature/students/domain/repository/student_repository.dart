import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/students/domain/entities/student.dart';

abstract interface class StudentRepository {
  Future<Either<Failure, void>> addStudent(Student student);

  Future<Either<Failure, List<Student>>> getStudents();

  Future<Either<Failure, Student>> getStudentsById(int studentId);

  Future<Either<Failure, void>> updateStudent(Student student);

  Future<Either<Failure, void>> deleteStudent(int studentId);
}
