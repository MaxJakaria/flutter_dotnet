import 'dart:convert';

import 'package:flutter_dotnet/core/error/exception.dart';
import 'package:flutter_dotnet/core/network/api_constants.dart';
import 'package:flutter_dotnet/feature/students/data/models/student_model.dart';
import 'package:http/http.dart' as http;

abstract interface class StudentRemoteDataSource {
  Future<void> addStudent(StudentModel student);

  Future<List<StudentModel>> getStudents();

  Future<StudentModel> getStudentsById(int studentId);

  Future<void> updateStudent(StudentModel student);

  Future<void> deleteStudent(int studentId);
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final http.Client client;

  StudentRemoteDataSourceImpl({required this.client});

  @override
  Future<void> addStudent(StudentModel student) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/Students'),

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },

      body: json.encode(student.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw ServerException(message: "Failed to add student");
    }
  }

  @override
  Future<List<StudentModel>> getStudents() async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/Students'),

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((e) => StudentModel.fromJson(e)).toList();
    } else {
      throw ServerException(
        message: 'Failed to load students: ${response.statusCode}',
      );
    }
  }

  @override
  Future<StudentModel> getStudentsById(int studentId) async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/Students/$studentId'),

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return StudentModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(message: "Student not found");
    }
  }

  @override
  Future<void> updateStudent(StudentModel student) async {
    final response = await client.put(
      Uri.parse('${ApiConstants.baseUrl}/Students/${student.studentId}'),

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },

      body: jsonEncode(student.toUpdateJson()),
    );

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw ServerException(message: "Failed to update student");
    }
  }

  @override
  Future<void> deleteStudent(int studentId) async {
    final response = await client.delete(
      Uri.parse('${ApiConstants.baseUrl}/Students/$studentId'),

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw ServerException(message: "Failed to delete student");
    }
  }
}
