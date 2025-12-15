part of 'student_bloc.dart';

sealed class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class GetStudentsEvent extends StudentEvent {}

class GetStudentByIdEvent extends StudentEvent {
  final int studentId;

  const GetStudentByIdEvent({required this.studentId});

  @override
  List<Object> get props => [studentId];
}

class AddStudentEvent extends StudentEvent {
  final Student student;

  const AddStudentEvent({required this.student});

  @override
  List<Object> get props => [student];
}

class UpdateStudentEvent extends StudentEvent {
  final Student student;

  const UpdateStudentEvent({required this.student});

  @override
  List<Object> get props => [student.deptId, student.name];
}

class DeleteStudentEvent extends StudentEvent {
  final int studentId;

  const DeleteStudentEvent({required this.studentId});

  @override
  List<Object> get props => [studentId];
}
