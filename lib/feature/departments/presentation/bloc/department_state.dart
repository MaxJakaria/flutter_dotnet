part of 'department_bloc.dart';

sealed class DepartmentState extends Equatable {
  const DepartmentState();

  @override
  List<Object> get props => [];
}

final class DepartmentInitial extends DepartmentState {}

final class DepartmentLoading extends DepartmentState {}

final class DepartmentLoaded extends DepartmentState {
  final List<Department> departments;

  const DepartmentLoaded({required this.departments});

  @override
  List<Object> get props => [departments];
}

class DepartmentError extends DepartmentState {
  final String message;

  const DepartmentError({required this.message});

  @override
  List<Object> get props => [message];
}
