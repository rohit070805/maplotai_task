import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/colors.dart';
import '../utils/components.dart';
import '../services/student_services.dart';

class Addstudent extends StatefulWidget {
  const Addstudent({super.key});

  @override
  State<Addstudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countrytController = TextEditingController();

  bool _isLoadingLocation = false;
  bool _showLocationFields = false;

  Future<void> fetchLocationDetails() async {
    String pincode = _pinCodeController.text.trim();

    if (pincode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid 6-digit Pincode"), backgroundColor: Colors.red));
      return;
    }

    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final url = Uri.parse("https://api.postalpincode.in/pincode/$pincode");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data[0]['Status'] == 'Success') {
          final postOfficeData = data[0]['PostOffice'][0];

          setState(() {
            _districtController.text = postOfficeData['District'] ?? '';
            _stateController.text = postOfficeData['State'] ?? '';
            _countrytController.text = postOfficeData['Country'] ?? 'India';
            _showLocationFields = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Location Fetched!"), backgroundColor: Colors.green)
          );
        } else {
          setState(() {
            _showLocationFields = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Pincode not found. Please enter details manually."), backgroundColor: Colors.orange)
          );
        }
      } else {
        throw Exception("API Error");
      }
    } catch (e) {
      setState(() {
        _showLocationFields = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching location: $e"), backgroundColor: Colors.red));
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.appColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          title: const Text(
            "Add Student",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Note: readOnly is false by default now (thanks to Step 1)
                Components().normaltextFeild(context, _nameController, "Name"),
                const SizedBox(height: 15),
                Components().normaltextFeild(context, _emailController, "Email Address"),
                const SizedBox(height: 15),
                Components().normaltextFeild(context, _studentIDController, "Student ID (Must be Unique)"),
                const SizedBox(height: 15),

                Components().normaltextFeild(context, _pinCodeController, "POSTAL CODE"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isLoadingLocation ? null : fetchLocationDetails,
                      child: _isLoadingLocation
                          ? const SizedBox(
                          height: 15, width: 15, child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(
                        "Fetch Location Details",
                        style: TextStyle(color: AppColors.appColor),
                      ),
                    ),
                  ],
                ),

                // Only show these fields after the button is clicked
                if (_showLocationFields) ...[
                  const SizedBox(height: 15),
                  Components().normaltextFeild(context, _districtController, "District"),
                  const SizedBox(height: 15),
                  Components().normaltextFeild(context, _stateController, "State"),
                  const SizedBox(height: 15),
                  Components().normaltextFeild(context, _countrytController, "Country"),
                ],

                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppColors.appColor),
                    onPressed: () async {

                      if (_nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _studentIDController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Name, Email, and ID are required!"),
                            backgroundColor: Colors.red));
                        return;
                      }


                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Saving Student..."),
                          duration: Duration(milliseconds: 800)));


                      String? error = await StudentService().addStudent(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        studentId: _studentIDController.text.trim(),
                        pincode: _pinCodeController.text.trim(),
                        district: _districtController.text.trim(),
                        state: _stateController.text.trim(),
                        country: _countrytController.text.trim(),
                      );


                      if (error == null) {
                        // Success
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Student Added Successfully!"),
                              backgroundColor: Colors.green));


                          _nameController.clear();
                          _emailController.clear();
                          _studentIDController.clear();
                          _pinCodeController.clear();
                          _districtController.clear();
                          _stateController.clear();
                          _countrytController.clear();
                          setState(() {
                            _showLocationFields = false;
                          });
                        }
                      } else {

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(error), backgroundColor: Colors.red));
                        }
                      }
                    },
                    child: const Text(
                      "ADD STUDENT",
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}