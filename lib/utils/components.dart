import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplotai_task/screens/showCheckonDate.dart';

import 'colors.dart';
class Components{



  Widget normaltextFeild(BuildContext context, TextEditingController controller, String label, {bool readOnly = false}) {
    return TextField(
      style: const TextStyle(fontSize: 18),
      controller: controller,
      readOnly: readOnly,
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
  Widget ChecksTile(BuildContext context, String title, String subtitle) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 10,
              color: AppColors.grey.withOpacity(.4),
            ),
            BoxShadow(
              offset: const Offset(-3, 0),
              blurRadius: 15,
              color: AppColors.grey.withOpacity(.1),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: ListTile(
            onTap: () {

              if (subtitle == "") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Showcheckondate(dateStr: title)));
              }
            },
            contentPadding: const EdgeInsets.all(0),
            title: Text(title,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            subtitle: subtitle == ""
                ? null
                : Text(
              subtitle,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
        ));
  }
  Widget StudentTile(BuildContext context, String title, String subtitle, {VoidCallback? onTap}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 10,
              color: AppColors.grey.withOpacity(.4),
            ),
            BoxShadow(
              offset: const Offset(-3, 0),
              blurRadius: 15,
              color: AppColors.grey.withOpacity(.1),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: ListTile(
            onTap: onTap,
            contentPadding: const EdgeInsets.all(0),
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(13)),
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
            title: Text(title,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            subtitle: Text(
              subtitle,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
        ));
  }
  }


