import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/create_department_use_case.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/delete_department_use_case.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/get_all_departments_use_case.dart';

part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  final GetAllDepartmentsUseCase getAllDepartmentsUseCase;
  final CreateDepartmentUseCase createDepartmentUseCase;
  final DeleteDepartmentUseCase deleteDepartmentUseCase;

  DepartmentBloc({
    required this.getAllDepartmentsUseCase,
    required this.createDepartmentUseCase,
    required this.deleteDepartmentUseCase,
  }) : super(DepartmentInitial()) {
    on<GetDepartmentsEvent>((event, emit) async {
      if (event.withLoading) emit(DepartmentLoading());

      final result = await getAllDepartmentsUseCase();

      result.fold(
        (failure) => emit(DepartmentError(message: failure.message)),
        (departments) => emit(DepartmentLoaded(departments: departments)),
      );
    });

    on<CreateDepartmentEvent>((event, emit) async {
      // Derect pass the department object to the use-case
      final result = await createDepartmentUseCase(event.department);

      result.fold(
        (failure) => emit(DepartmentError(message: failure.message)),
        (success) => add(GetDepartmentsEvent(withLoading: false)),
      );
    });

    on<DeleteDepartmentEvent>((event, emit) async {
      final result = await deleteDepartmentUseCase(event.deptId);

      result.fold(
        (failure) => emit(DepartmentError(message: failure.message)),
        (success) => add(GetDepartmentsEvent(withLoading: false)),
      );
    });
  }
}
