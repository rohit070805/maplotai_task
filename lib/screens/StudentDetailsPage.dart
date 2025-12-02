import 'package:flutter/material.dart';

import '../utils/colors.dart';
class Studentdetailspage extends StatefulWidget {
  const Studentdetailspage({super.key});

  @override
  State<Studentdetailspage> createState() => _StudentdetailspageState();
}

class _StudentdetailspageState extends State<Studentdetailspage> {
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
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  padding: EdgeInsets.only(left: 19, right: 19, top: 16),
                  //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Rohit Kumar",
                                style: TextStyle(fontSize: 30,letterSpacing:2,fontWeight: FontWeight.w600,color: AppColors.appColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.check_circle,
                                  size: 25,
                                  color: AppColors.appColor),

                            ],
                          ),
                          subtitle: Text("rohit@gmail.com"
                            ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,letterSpacing: 3),
                          ),
                        ),

                        Text(
                          "Student id",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,letterSpacing: 3),
                        ),
                        Text("LOCATION",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,letterSpacing: 3),


                        ),
                       

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
