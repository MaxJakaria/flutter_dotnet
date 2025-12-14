import 'package:flutter_dotnet/feature/departments/data/data_sources/department_remote_data_source.dart';
import 'package:flutter_dotnet/feature/departments/data/repository/department_repository_impl.dart';
import 'package:flutter_dotnet/feature/departments/domain/repository/department_repository.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/create_department_use_case.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/delete_department_use_case.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/get_all_departments_use_case.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/update_department_use_case.dart';
import 'package:flutter_dotnet/feature/departments/presentation/bloc/department_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // External dependencies
  try {
    serviceLocator.registerLazySingleton(() => http.Client());
  } catch (e, st) {
    // Log and throw so caller sees the original failure
    debugPrint('initDependencies: failed registering http.Client -> $e\n$st');
    throw Exception('initDependencies: failed registering http.Client -> $e');
  }

  // Initialize Data Sources
  try {
    serviceLocator.registerLazySingleton<DepartmentRemoteDataSource>(
      () => DepartmentRemoteDataSourceImpl(client: serviceLocator()),
    );
  } catch (e, st) {
    debugPrint(
      'initDependencies: failed registering DepartmentRemoteDataSource -> $e\n$st',
    );
    throw Exception(
      'initDependencies: failed registering DepartmentRemoteDataSource -> $e',
    );
  }

  // Initialize Repositories
  try {
    serviceLocator.registerLazySingleton<DepartmentRepository>(
      () => DepartmentRepositoryImpl(remoteDataSource: serviceLocator()),
    );
  } catch (e, st) {
    debugPrint(
      'initDependencies: failed registering DepartmentRepository -> $e\n$st',
    );
    throw Exception(
      'initDependencies: failed registering DepartmentRepository -> $e',
    );
  }

  // Initialize Use Cases
  try {
    serviceLocator
      ..registerFactory(
        () => GetAllDepartmentsUseCase(repository: serviceLocator()),
      )
      ..registerFactory(
        () => CreateDepartmentUseCase(repository: serviceLocator()),
      )
      ..registerFactory(
        () => DeleteDepartmentUseCase(repository: serviceLocator()),
      )
      ..registerFactory(
        () => UpdateDepartmentUseCase(repository: serviceLocator()),
      );
  } catch (e, st) {
    debugPrint('initDependencies: failed registering UseCases -> $e\n$st');
    throw Exception('initDependencies: failed registering UseCases -> $e');
  }

  // Initialize Bloc
  try {
    serviceLocator.registerFactory(
      () => DepartmentBloc(
        getAllDepartmentsUseCase: serviceLocator(),
        createDepartmentUseCase: serviceLocator(),
        deleteDepartmentUseCase: serviceLocator(),
        updateDepartmentUseCase: serviceLocator(),
      ),
    );
  } catch (e, st) {
    debugPrint(
      'initDependencies: failed registering DepartmentBloc -> $e\n$st',
    );
    throw Exception(
      'initDependencies: failed registering DepartmentBloc -> $e',
    );
  }
}
