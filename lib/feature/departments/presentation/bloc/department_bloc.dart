import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotnet/feature/departments/domain/entities/department.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/get_all_departments_use_case.dart';

part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  final GetAllDepartmentsUseCase getAllDepartmentsUseCase;

  DepartmentBloc({required this.getAllDepartmentsUseCase})
    : super(DepartmentInitial()) {
    on<GetDepartmentsEvent>((event, emit) async {
      emit(DepartmentLoading());

      final result = await getAllDepartmentsUseCase();

      result.fold(
        (failure) => emit(DepartmentError(message: failure.message)),
        (departments) => emit(DepartmentLoaded(departments: departments)),
      );
    });
  }
}
