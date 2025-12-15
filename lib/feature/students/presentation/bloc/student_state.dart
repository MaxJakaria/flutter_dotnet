part of 'student_bloc.dart';

sealed class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

final class StudentInitial extends StudentState {}

final class StudentLoading extends StudentState {}

final class StudentsLoaded extends StudentState {
  final List<Student> students;

  const StudentsLoaded({required this.students});

  @override
  List<Object> get props => [students];
}

final class SingleStudentLoaded extends StudentState {
  final Student student;

  const SingleStudentLoaded({required this.student});

  @override
  List<Object> get props => [student];
}

final class StudentActionSuccess extends StudentState {
  final String message;

  const StudentActionSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class StudentError extends StudentState {
  final String message;

  const StudentError({required this.message});

  @override
  List<Object> get props => [message];
}
