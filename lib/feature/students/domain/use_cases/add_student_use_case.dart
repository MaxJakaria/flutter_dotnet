import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/students/domain/entities/student.dart';
import 'package:flutter_dotnet/feature/students/domain/repository/student_repository.dart';

class AddStudentUseCase {
  final StudentRepository repository;

  AddStudentUseCase({required this.repository});

  Future<Either<Failure, void>> call(Student student) {
    return repository.addStudent(student);
  }
}
