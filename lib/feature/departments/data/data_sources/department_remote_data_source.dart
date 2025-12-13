import 'dart:convert';
import 'package:flutter_dotnet/core/error/exception.dart';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_constants.dart';
import '../models/department_model.dart';

abstract class DepartmentRemoteDataSource {
  Future<List<DepartmentModel>> getAllDepartments();
  Future<DepartmentModel> createDepartment(DepartmentModel department);
  Future<void> deleteDepartment(int deptId);
}

class DepartmentRemoteDataSourceImpl implements DepartmentRemoteDataSource {
  final http.Client client;

  DepartmentRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DepartmentModel>> getAllDepartments() async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/Departments');

    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
    );

    if (response.statusCode == 200) {
      final String jsonString = utf8.decode(response.bodyBytes);
      final List<dynamic> jsonList = json.decode(jsonString);

      return jsonList.map((e) => DepartmentModel.fromJson(e)).toList();
    } else {
      throw ServerException(message: 'Failed to load departments');
    }
  }

  @override
  Future<DepartmentModel> createDepartment(DepartmentModel department) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/Departments');
    final response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
      body: json.encode(department.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final String jsonString = utf8.decode(response.bodyBytes);

      return DepartmentModel.fromJson(json.decode(jsonString));
    } else {
      throw ServerException(message: 'Failed to create department');
    }
  }

  @override
  Future<void> deleteDepartment(int deptId) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/Departments/$deptId');

    final response = await client.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw ServerException(message: 'Failed to delete department');
    }
  }
}
