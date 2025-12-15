import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/students/domain/entities/student.dart';
import 'package:flutter_dotnet/feature/students/domain/repository/student_repository.dart';

class GetStudentByIdUseCase {
  final StudentRepository repository;

  GetStudentByIdUseCase({required this.repository});

  Future<Either<Failure, Student>> call(int studentId) {
    return repository.getStudentsById(studentId);
  }
}
