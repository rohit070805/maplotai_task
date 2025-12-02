import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/components.dart';
class Showcheckondate extends StatefulWidget {
  const Showcheckondate({super.key});

  @override
  State<Showcheckondate> createState() => _ShowcheckondateState();
}

class _ShowcheckondateState extends State<Showcheckondate> {
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
        title: Text("02/12/2025",style: TextStyle(color: Colors.white,fontSize: 30),),
      ),
      body: ListView.builder(

        shrinkWrap: true,
        itemBuilder: (context,index){

          return Components().ChecksTile(context, "Rohit", "02/12/2025 - 9:00");
        },
        itemCount: 20,
      ),
    );
  }
}
