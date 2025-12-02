import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../services/student_services.dart';
import '../models/student_model.dart'; // Import Model
import 'LoginScreen.dart';
import '../utils/colors.dart';
import '../utils/components.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController searchController = TextEditingController();
  // Variable to store the list of students
  late Future<List<Student>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _refreshStudents();
  }

  // Function to refresh the list (useful after adding a student)
  // Update this function
  void _refreshStudents({String? query}) {
    setState(() {
      _studentsFuture = StudentService().getAllStudents(query: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Section (Name & Logout) ---
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Hello,",
                          style: TextStyle(fontSize: 25, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          (user?.displayName ?? "Admin").toUpperCase(),
                          style: TextStyle(
                              fontSize: 35,
                              letterSpacing: 3,
                              color: AppColors.appColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<Authprovider>().signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Loginscreen()),
                              (route) => false,
                        );
                      },
                      icon: const Icon(Icons.exit_to_app,
                          size: 35, color: Colors.red)),
                ],
              ),
            ),

            // --- Search Bar (Visual Only for now) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  height: 55,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(13)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(5, 5),
                      )
                    ],
                  ),
                // ... inside the Container decoration ...
                child: TextField(
                  controller: searchController, // Make sure you have this controller defined at top
                  onChanged: (value) {
                    // Call the search function whenever text changes
                    _refreshStudents(query: value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    border: InputBorder.none,
                    hintText: "Search by Name or ID",
                    // Clear button if text is not empty
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        searchController.clear();
                        _refreshStudents(query: ""); // Reset list
                      },
                    )
                        : Icon(Icons.search, color: AppColors.appColor),
                  ),
                ),)
            ),

            // --- Student List Header ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Students",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: AppColors.appColor, size: 30),
                    onPressed: _refreshStudents, // Click to reload list
                  )
                ],
              ),
            ),

            // --- REAL DATA LIST ---
            Expanded(
              child: FutureBuilder<List<Student>>(
                future: _studentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No students found. Add one!"));
                  }

                  final students = snapshot.data!;

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      // Displaying Name and Student ID from MongoDB
                      return Components().StudentTile(
                          context,
                          student.name,
                          "ID: ${student.studentId} | ${student.district}"
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}