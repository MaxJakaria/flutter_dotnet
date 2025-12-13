import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final int departmentId;
  final String name;

  const Department({required this.departmentId, required this.name});

  @override
  List<Object?> get props => [departmentId, name];
}
