part of 'department_bloc.dart';

sealed class DepartmentEvent extends Equatable {
  const DepartmentEvent();

  @override
  List<Object> get props => [];
}

class GetDepartmentsEvent extends DepartmentEvent {
  final bool withLoading;

  const GetDepartmentsEvent({this.withLoading = true});

  @override
  List<Object> get props => [withLoading];
}

class CreateDepartmentEvent extends DepartmentEvent {
  final Department department;

  const CreateDepartmentEvent({required this.department});

  @override
  List<Object> get props => [department];
}

class DeleteDepartmentEvent extends DepartmentEvent {
  final int deptId;

  const DeleteDepartmentEvent({required this.deptId});

  @override
  List<Object> get props => [deptId];
}

class UpdateDepartmentEvent extends DepartmentEvent {
  final Department department;

  const UpdateDepartmentEvent({required this.department});

  @override
  List<Object> get props => [department];
}
