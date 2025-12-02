import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/components.dart';

class Checkspage extends StatefulWidget {
  const Checkspage({super.key});

  @override
  State<Checkspage> createState() => _CheckspageState();
}

class _CheckspageState extends State<Checkspage> {
  bool showDateWise = false;

   bool showStudentResult = false;

  TextEditingController studentIdController = TextEditingController();

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
            Container(
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
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 15,
                              offset: Offset(5, 5),
                            )
                          ],
                        ),
                        child: TextField(
                          controller: studentIdController,
                           onChanged: (val) {
                            if (val.isEmpty && showStudentResult) {
                              setState(() {
                                showStudentResult = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            border: InputBorder.none,
                            hintText: "Enter StudentId to Add Check",
                              suffixIcon: InkWell(
                              onTap: () {
                                // Only show result if text field is not empty
                                if (studentIdController.text.isNotEmpty) {
                                  setState(() {
                                    showStudentResult = true;
                                  });
                                }
                              },
                              child: SizedBox(
                                  width: 50,
                                  child: Icon(Icons.search,
                                      color: AppColors.appColor)),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),

             showStudentResult
                ? Components().StudentTile(context, "Rohit", "Student ID: ${studentIdController.text}")
                : SizedBox.shrink(),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            showDateWise ? "DateWise CheckIns" : "All Checks",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  showDateWise = !showDateWise;
                                });
                              },
                              child: Text(
                                !showDateWise
                                    ? "SHOW BY DATES"
                                    : "SHOW ALL CHECKS",
                                style: TextStyle(color: AppColors.appColor),
                              )),
                        ],
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return showDateWise
                            ? Components()
                            .ChecksTile(context, "02/12/2025", "")
                            : Components().ChecksTile(
                            context, "Rohit", "02/12/2025 - 9:00");
                      },
                      itemCount: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}