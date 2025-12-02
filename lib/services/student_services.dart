import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/student_model.dart';

class StudentService {
  // 10.0.2.2 is the special IP for Android Emulator to reach your computer
  static const String baseUrl = 'http://10.0.2.2:3000/api/students';
  // Function to Get Students (Optional Search Query)
  Future<List<Student>> getAllStudents({String? query}) async {
    try {
      // Build the URL
      String urlString = baseUrl;
      if (query != null && query.isNotEmpty) {
        // Append the search parameter if user typed something
        urlString += "?search=$query";
      }

      final url = Uri.parse(urlString);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load students");
      }
    } catch (e) {
      throw Exception("Error fetching students: $e");
    }
  }
  Future<String?> addStudent({
    required String name,
    required String email,
    required String studentId,
    required String pincode,
    required String district,
    required String state,
    required String country,
  }) async {
    try {
      final url = Uri.parse(baseUrl);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'studentId': studentId,
          'pincode': pincode,
          'district': district,
          'state': state,
          'country': country,
        }),
      );

      if (response.statusCode == 201) {
        return null; // Success (No error)
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? "Failed to add student";
      }
    } catch (e) {
      return "Error connecting to server: $e";
    }
  }
}