import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplotai_task/screens/StudentDetailsPage.dart';
import 'package:maplotai_task/screens/showCheckonDate.dart';
import '';
import 'colors.dart';
class Components{
  // PreferredSizeWidget homePageAppBar(  GlobalKey<ScaffoldState> _drawerkey){
  //   return AppBar(
  //     leading: IconButton(onPressed: (){
  //       _drawerkey.currentState?.openDrawer();
  //     },
  //         icon: Icon(Icons.menu,color: Colors.white,)),
  //
  //     centerTitle: true,
  //     automaticallyImplyLeading: false,
  //     backgroundColor:AppColors.appColor,
  //     actions: [
  //       Padding(padding: EdgeInsets.all(10),
  //         child: IconButton(
  //
  //
  //             highlightColor: Colors.transparent,
  //             onPressed: (){}, icon: Icon(Icons.open_in_new,color: Colors.white,)),
  //
  //       ),
  //     ],
  //     shape:const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(bottom:Radius.circular(30) )
  //     ),
  //     title: Text("AI BOT",style: TextStyle(color: Colors.white,fontSize: 30),),
  //   );
  // }
  // Widget signUpwithPrefixTextFeild(BuildContext context,TextEditingController controller,String label,String prefix){
  //   return  TextField(
  //     style: TextStyle(fontSize: 18),
  //     controller: controller,
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(
  //               color: Colors.black,
  //               width: 1.5
  //           )
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(
  //               color: Colors.grey,
  //               width: 1.5
  //           )
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(
  //               color: Colors.grey,
  //               width: 1.5
  //           )
  //       ),
  //       labelText: label,
  //       prefixText: prefix,
  //
  //       labelStyle: TextStyle(color: Colors.black,fontSize: 16),
  //
  //       prefixStyle: TextStyle(color: Colors.grey),
  //
  //
  //
  //
  //
  //     ),
  //
  //
  //
  //   );
  // }
  //
  //
  // Widget signUptextFeild(BuildContext context,TextEditingController controller,String label){
  //   return  TextField(
  //     style: TextStyle(fontSize: 18),
  //     controller: controller,
  //
  //     decoration: InputDecoration(
  //       alignLabelWithHint: true,
  //       border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(
  //               color: Colors.grey,
  //               width: 1.5
  //           )
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(
  //               color: Colors.grey,
  //               width: 1.5
  //           )
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(
  //               color: Colors.grey,
  //               width: 1.5
  //           )
  //       ),
  //       labelText: label,
  //       labelStyle: TextStyle(color: Colors.black,fontSize: 16),
  //
  //
  //
  //
  //
  //
  //
  //     ),
  //
  //
  //
  //   );
  // }

  Widget normaltextFeild(BuildContext context, TextEditingController controller, String label, ) {
    return TextField(
      style: const TextStyle(fontSize: 18),
      controller: controller,

      readOnly: true,
      decoration: InputDecoration(

        alignLabelWithHint: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 16),

      ),
    );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [

      AppColors.orange,
      AppColors.green,
      AppColors.grey,
      AppColors.lightOrange,
      AppColors.skyBlue,
      AppColors.titleTextColor,
      Colors.red,
      Colors.brown,
      AppColors.purpleExtraLight,
      AppColors.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }
  Widget ChecksTile(BuildContext context,String title,String subtitle) {
    return Container(

        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: AppColors.grey.withOpacity(.4),
            ),
            BoxShadow(
              offset: Offset(-3, 0),
              blurRadius: 15,
              color: AppColors.grey.withOpacity(.1),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: ListTile(
            onTap: () {
              if(subtitle=="") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Showcheckondate()));
              } },
            contentPadding: EdgeInsets.all(0),

            title: Text(title, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),

            subtitle:subtitle==""?null: Text(
              subtitle,
              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 16),
            ),


          ),
        )
    );
  }
  Widget StudentTile(BuildContext context,String title,String subtitle) {
    return Container(

        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: AppColors.grey.withOpacity(.4),
            ),
            BoxShadow(
              offset: Offset(-3, 0),
              blurRadius: 15,
              color: AppColors.grey.withOpacity(.1),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: ListTile(
            onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Studentdetailspage()));
            },
            contentPadding: EdgeInsets.all(0),
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: randomColor(),
                ),
                child: Image.asset(
                  "assets/images/student.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(title, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 16),
            ),

          ),
        )
    );
  }


}