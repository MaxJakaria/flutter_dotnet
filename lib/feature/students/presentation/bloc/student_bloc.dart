import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotnet/feature/students/domain/entities/student.dart';
import 'package:flutter_dotnet/feature/students/domain/use_cases/add_student_use_case.dart';
import 'package:flutter_dotnet/feature/students/domain/use_cases/delete_student_use_case.dart';
import 'package:flutter_dotnet/feature/students/domain/use_cases/get_student_by_id_use_case.dart';
import 'package:flutter_dotnet/feature/students/domain/use_cases/get_students_use_case.dart';
import 'package:flutter_dotnet/feature/students/domain/use_cases/update_student_use_case.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final AddStudentUseCase addStudentUseCase;
  final GetStudentsUseCase getStudentsUseCase;
  final GetStudentByIdUseCase getStudentByIdUseCase;
  final UpdateStudentUseCase updateStudentUseCase;
  final DeleteStudentUseCase deleteStudentUseCase;

  StudentBloc({
    required this.addStudentUseCase,
    required this.getStudentsUseCase,
    required this.getStudentByIdUseCase,
    required this.updateStudentUseCase,
    required this.deleteStudentUseCase,
  }) : super(StudentInitial()) {
    on<GetStudentsEvent>((event, emit) async {
      emit(StudentLoading());
      final result = await getStudentsUseCase();
      result.fold(
        (failure) => emit(StudentError(message: failure.message)),
        (students) => emit(StudentsLoaded(students: students)),
      );
    });

    on<GetStudentByIdEvent>((event, emit) async {
      emit(StudentLoading());
      final result = await getStudentByIdUseCase(event.studentId);
      result.fold(
        (failure) => emit(StudentError(message: failure.message)),
        (student) => emit(SingleStudentLoaded(student: student)),
      );
    });

    on<AddStudentEvent>((event, emit) async {
      emit(StudentLoading());
      final result = await addStudentUseCase(event.student);
      result.fold(
        (failure) => emit(StudentError(message: failure.message)),
        (success) => emit(
          const StudentActionSuccess(message: 'Student added successfully'),
        ),
      );
    });

    on<UpdateStudentEvent>((event, emit) async {
      emit(StudentLoading());
      final result = await updateStudentUseCase(event.student);
      result.fold(
        (failure) => emit(StudentError(message: failure.message)),
        (success) => emit(
          const StudentActionSuccess(message: 'Student updated successfully'),
        ),
      );
    });

    on<DeleteStudentEvent>((event, emit) async {
      emit(StudentLoading());
      final result = await deleteStudentUseCase(event.studentId);
      result.fold(
        (failure) => emit(StudentError(message: failure.message)),
        (success) => emit(
          const StudentActionSuccess(message: 'Student deleted successfully'),
        ),
      );
    });
  }
}
