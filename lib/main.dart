import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotnet/core/theme/app_theme.dart';
import 'package:flutter_dotnet/feature/departments/presentation/bloc/department_bloc.dart';
import 'package:flutter_dotnet/feature/departments/presentation/pages/department_list_page.dart';
import 'package:flutter_dotnet/feature/students/presentation/bloc/student_bloc.dart';
import 'package:flutter_dotnet/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DepartmentBloc>(
          create: (context) => serviceLocator<DepartmentBloc>(),
        ),

        BlocProvider<StudentBloc>(
          create: (context) => serviceLocator<StudentBloc>(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'University DB',

        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,

        home: DepartmentListPage(),
      ),
    );
  }
}
