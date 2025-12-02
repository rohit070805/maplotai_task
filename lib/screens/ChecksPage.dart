import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/components.dart';
import '../services/student_services.dart';
import '../models/checkin_model.dart';
import '../models/student_model.dart';
import 'StudentDetailsPage.dart';


class Checkspage extends StatefulWidget {
  const Checkspage({super.key});

  @override
  State<Checkspage> createState() => _CheckspageState();
}

class _CheckspageState extends State<Checkspage> {

  bool showDateWise = false;


  TextEditingController studentIdController = TextEditingController();
  Student? _foundStudent;
  bool _isSearching = false;


  late Future<List<CheckIn>> _checkInsFuture;

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() {
    setState(() {
      _checkInsFuture = StudentService().getCheckIns();
    });
  }


  void _onSearchChanged(String val) async {
    if (val.isEmpty) {
      setState(() => _foundStudent = null);
      return;
    }


    try {
      List<Student> students = await StudentService().getAllStudents(query: val);


      var match = students.firstWhere(
            (s) => s.studentId.toLowerCase() == val.toLowerCase(),
        orElse: () => Student(id: '', name: '', email: '', studentId: '', district: '', state: ''), // Empty fallback
      );

      if (match.id.isNotEmpty) {
        setState(() => _foundStudent = match);
      } else {
        setState(() => _foundStudent = null);
      }
    } catch (e) {
      print("Search Error: $e");
    }
  }



  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }


  Map<String, List<CheckIn>> _groupCheckInsByDate(List<CheckIn> list) {
    Map<String, List<CheckIn>> grouped = {};
    for (var item in list) {
      String dateKey = _formatDate(item.checkInTime);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(item);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, toolbarHeight: 10),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "ADD CHECKINS",
                style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 3,
                    color: AppColors.appColor,
                    fontWeight: FontWeight.w500),
              ),
            ),


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
                  child: TextField(
                    controller: studentIdController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      border: InputBorder.none,
                      hintText: "Enter StudentId to Add Check",
                      suffixIcon: Icon(Icons.search, color: AppColors.appColor),
                    ),
                  )),
            ),


            if (_foundStudent != null)
              Container(
                color: Colors.green.withOpacity(0.1),
                child: Components().StudentTile(
                    context,
                    _foundStudent!.name,
                    "Tap to View Details | ID: ${_foundStudent!.studentId}",
                    onTap: () async {
                      // Navigate to Details Page passing the student
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Studentdetailspage(student: _foundStudent!)
                          )
                      );

                       if (result == true) {
                        studentIdController.clear();
                        setState(() => _foundStudent = null);
                        _refreshList();
                      }
                    }
                ),
              ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    showDateWise ? "DateWise List" : "Recent Checks",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showDateWise = !showDateWise;
                      });
                    },
                    child: Text(
                      showDateWise ? "SHOW ALL" : "SHOW BY DATE",
                      style: TextStyle(color: AppColors.appColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),


            Expanded(
              child: FutureBuilder<List<CheckIn>>(
                future: _checkInsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No Check-ins Found"));
                  }

                  final allChecks = snapshot.data!;


                  if (showDateWise) {
                    final grouped = _groupCheckInsByDate(allChecks);
                    final dates = grouped.keys.toList();

                    return ListView.builder(
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        String date = dates[index];
                        List<CheckIn> checksForDate = grouped[date]!;
// Custom Tile for Date Folder
                        return Components().ChecksTile(
                          context,
                          date,
                          "",
                        );

                      },
                    );
                  }


                  else {
                    return ListView.builder(
                      itemCount: allChecks.length,
                      itemBuilder: (context, index) {
                        final item = allChecks[index];
                        String time = "${item.checkInTime.hour}:${item.checkInTime.minute.toString().padLeft(2, '0')}";
                        String date = "${item.checkInTime.day}/${item.checkInTime.month}";

                        return Components().ChecksTile(
                            context,
                            item.studentName,
                            "$date - $time"
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}