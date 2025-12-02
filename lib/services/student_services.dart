import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../models/checkin_model.dart';
import '../models/student_model.dart';

class StudentService {

  static const String baseUrl = 'https://student-backend-api-gfxm.onrender.com/api';


  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;


  Future<List<Student>> getAllStudents({String? query}) async {
    try {
      if (currentUserId == null) throw Exception("User not logged in");


      String urlString = '$baseUrl/students?adminId=$currentUserId';

      if (query != null && query.isNotEmpty) {
        urlString += "&search=$query";
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
      if (currentUserId == null) return "User not logged in";

      final url = Uri.parse('$baseUrl/students');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'adminId': currentUserId,
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
        return null;
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? "Failed to add student";
      }
    } catch (e) {
      return "Error connecting to server: $e";
    }
  }


  Future<String?> checkInStudent(String studentId) async {
    try {
      if (currentUserId == null) return "User not logged in";

      final url = Uri.parse('$baseUrl/checkins');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'studentId': studentId,
          'adminId': currentUserId,
        }),
      );

      if (response.statusCode == 201) {
        return null;
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? "Check-in failed";
      }
    } catch (e) {
      return "Error: $e";
    }
  }


  Future<List<CheckIn>> getCheckIns() async {
    try {
      if (currentUserId == null) throw Exception("User not logged in");

      final url = Uri.parse('$baseUrl/checkins?adminId=$currentUserId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CheckIn.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load check-ins");
      }
    } catch (e) {
      throw Exception("Error fetching check-ins: $e");
    }
  }
}