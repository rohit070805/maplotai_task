import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/components.dart';
class Addstudent extends StatefulWidget {
  const Addstudent({super.key});

  @override
  State<Addstudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  final TextEditingController _nameController  = TextEditingController();
  final TextEditingController _emailController  = TextEditingController();
  final TextEditingController _studentIDController  = TextEditingController();
  final TextEditingController _pinCodeController  = TextEditingController();
  final TextEditingController _districtController  = TextEditingController();
  final TextEditingController _stateController  = TextEditingController();
  final TextEditingController _countrytController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor:AppColors.appColor,
          shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom:Radius.circular(30) )
          ),
          title: Text("Add Student",style: TextStyle(color: Colors.white,fontSize: 30),),
        ),
        body:Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [





                Components().normaltextFeild(context,_nameController, "Name"),
                SizedBox(height: 15,),
    Components().normaltextFeild(context,_emailController, "Email Adress"),
                SizedBox(height: 15,),

                Components().normaltextFeild(context,_studentIDController, "Student ID(Must be Unique)"),
                SizedBox(height: 15,),

                Components().normaltextFeild(context,_pinCodeController, "POSTAL CODE"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){},
                        child: Text("Fetch Location Details",style: TextStyle(color: AppColors.appColor),),),
                  ],
                ),

                Components().normaltextFeild(context,_districtController, "District (To be AutoFilled)"),
                SizedBox(height: 15,),

                Components().normaltextFeild(context,_stateController, "State (To be AutoFilled)"),
                SizedBox(height: 15,),

                Components().normaltextFeild(context,_countrytController, "Country (To be AutoFilled"),

                SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppColors.appColor
                    ),
                    onPressed: () {
                      },
                    child: Text(
                      "ADD STUDENT",
                      style: TextStyle(color: Colors.white,letterSpacing: 2,fontWeight: FontWeight.w400,fontSize: 18),
                    ),
                  ),
                )



              ],
            ),
          ),
        )
    );
  }
}
