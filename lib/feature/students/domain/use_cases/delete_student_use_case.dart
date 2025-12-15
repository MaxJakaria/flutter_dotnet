import 'package:dartz/dartz.dart';
import 'package:flutter_dotnet/core/error/failure.dart';
import 'package:flutter_dotnet/feature/students/domain/repository/student_repository.dart';

class DeleteStudentUseCase {
  final StudentRepository repository;

  DeleteStudentUseCase({required this.repository});

  Future<Either<Failure, void>> call(int studentId) {
    return repository.deleteStudent(studentId);
  }
}
