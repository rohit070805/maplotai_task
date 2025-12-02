import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../models/student_model.dart';
import '../services/student_services.dart';

class Studentdetailspage extends StatefulWidget {
  final Student student;
  const Studentdetailspage({super.key, required this.student});

  @override
  State<Studentdetailspage> createState() => _StudentdetailspageState();
}

class _StudentdetailspageState extends State<Studentdetailspage> {
  bool _isLoading = false;

  Future<void> _handleCheckIn() async {
    setState(() => _isLoading = true);


    String? error = await StudentService().checkInStudent(widget.student.studentId);

    setState(() => _isLoading = false);

    if (error == null) {
      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Check-in Successful!"), backgroundColor: Colors.green));
        Navigator.pop(context, true);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[

            Image.asset(
              'assets/images/student.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              fit: BoxFit.fill,
            ),

            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            // Details Sheet
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: const EdgeInsets.only(left: 19, right: 19, top: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.student.name.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 28,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.appColor),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(Icons.check_circle,
                                  size: 25, color: AppColors.appColor),
                            ],
                          ),
                          subtitle: Text(
                            widget.student.email,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Student ID",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Text(
                          widget.student.studentId,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "LOCATION",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Text(
                          "${widget.student.district}, ${widget.student.state}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: AppColors.appColor,
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)
                            ),
                            onPressed: _isLoading ? null : _handleCheckIn,
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                              "CHECK STUDENT IN",
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}