import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/students/domain/entities/student.dart';
import 'package:flutter_dotnet/feature/students/domain/repository/student_repository.dart';

class GetStudentsUseCase {
  final StudentRepository repository;

  GetStudentsUseCase({required this.repository});

  Future<Either<Failure, List<Student>>> call() {
    return repository.getStudents();
  }
}
