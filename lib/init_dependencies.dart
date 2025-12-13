import 'package:flutter_dotnet/feature/departments/data/data_sources/department_remote_data_source.dart';
import 'package:flutter_dotnet/feature/departments/data/repository/department_repository_impl.dart';
import 'package:flutter_dotnet/feature/departments/domain/repository/department_repository.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/create_department_use_case.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/delete_department_use_case.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/get_all_departments_use_case.dart';
import 'package:flutter_dotnet/feature/departments/presentation/bloc/department_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // External dependencies
  serviceLocator.registerLazySingleton(() => http.Client());

  // Initialize Bloc
  serviceLocator.registerFactory(
    () => DepartmentBloc(
      getAllDepartmentsUseCase: serviceLocator(),
      createDepartmentUseCase: serviceLocator(),
      deleteDepartmentUseCase: serviceLocator(),
    ),
  );

  // Initialize Use Cases
  serviceLocator.registerFactory(
    () => GetAllDepartmentsUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => CreateDepartmentUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => DeleteDepartmentUseCase(repository: serviceLocator()),
  );

  // Initialize Repositories
  serviceLocator.registerLazySingleton<DepartmentRepository>(
    () => DepartmentRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Initialize Data Sources
  serviceLocator.registerLazySingleton<DepartmentRemoteDataSource>(
    () => DepartmentRemoteDataSourceImpl(client: serviceLocator()),
  );
}
