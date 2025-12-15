import 'package:flutter_dotnet/feature/departments/data/data_sources/department_remote_data_source.dart';
import 'package:flutter_dotnet/feature/departments/data/repository/department_repository_impl.dart';
import 'package:flutter_dotnet/feature/departments/domain/repository/department_repository.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/create_department_use_case.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/delete_department_use_case.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/get_all_departments_use_case.dart';
import 'package:flutter_dotnet/feature/departments/domain/use_cases/update_department_use_case.dart';
import 'package:flutter_dotnet/feature/departments/presentation/bloc/department_bloc.dart';
import 'package:flutter_dotnet/feature/students/data/data_sources/student_remote_data_source.dart';
import 'package:flutter_dotnet/feature/students/data/repository/student_repository_impl.dart';
import 'package:flutter_dotnet/feature/students/domain/repository/student_repository.dart';
import 'package:flutter_dotnet/feature/students/domain/use_cases/add_student_use_case.dart';
import 'package:flutter_dotnet/feature/students/domain/use_cases/delete_student_use_case.dart';
import 'package:flutter_dotnet/feature/students/domain/use_cases/get_student_by_id_use_case.dart';
import 'package:flutter_dotnet/feature/students/domain/use_cases/get_students_use_case.dart';
import 'package:flutter_dotnet/feature/students/domain/use_cases/update_student_use_case.dart';
import 'package:flutter_dotnet/feature/students/presentation/bloc/student_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // ১. core/external dependencies
  serviceLocator.registerLazySingleton(() => http.Client());

  _initDepartmentDependencies();
  _initStudentDependencies();
}

// ===========================
// Departments Feature Dependencies
// ===========================
void _initDepartmentDependencies() {
  // Data Source
  serviceLocator.registerLazySingleton<DepartmentRemoteDataSource>(
    () => DepartmentRemoteDataSourceImpl(client: serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<DepartmentRepository>(
    () => DepartmentRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Use Cases
  // UseCase গুলো স্টেটলেস হওয়ায় Singleton ব্যবহার করা ভালো
  serviceLocator.registerLazySingleton(
    () => GetAllDepartmentsUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => CreateDepartmentUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteDepartmentUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => UpdateDepartmentUseCase(repository: serviceLocator()),
  );

  // Bloc
  // Bloc অবশ্যই Factory হতে হবে, কারণ প্রতিবার নতুন স্ক্রিনে নতুন Bloc দরকার।
  serviceLocator.registerFactory(
    () => DepartmentBloc(
      getAllDepartmentsUseCase: serviceLocator(),
      createDepartmentUseCase: serviceLocator(),
      deleteDepartmentUseCase: serviceLocator(),
      updateDepartmentUseCase: serviceLocator(),
    ),
  );
}

// ===========================
// Students Feature Dependencies
// ===========================
void _initStudentDependencies() {
  // Data Source
  serviceLocator.registerLazySingleton<StudentRemoteDataSource>(
    () => StudentRemoteDataSourceImpl(client: serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => GetStudentsUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetStudentByIdUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => AddStudentUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => UpdateStudentUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteStudentUseCase(repository: serviceLocator()),
  );

  // Bloc
  serviceLocator.registerFactory(
    () => StudentBloc(
      addStudentUseCase: serviceLocator(),
      getStudentsUseCase: serviceLocator(),
      getStudentByIdUseCase: serviceLocator(),
      updateStudentUseCase: serviceLocator(),
      deleteStudentUseCase: serviceLocator(),
    ),
  );
}
