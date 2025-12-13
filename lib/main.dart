import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotnet/feature/departments/presentation/bloc/department_bloc.dart';
import 'package:flutter_dotnet/feature/departments/presentation/pages/department_list_page.dart';
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
      ],
      child: MaterialApp(
        title: 'University DB',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: DepartmentListPage(),
      ),
    );
  }
}
