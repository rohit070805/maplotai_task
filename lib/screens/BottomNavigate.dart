import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:maplotai_task/screens/AddStudent.dart';
import 'package:maplotai_task/screens/ChecksPage.dart';
import 'package:maplotai_task/screens/HomePage.dart';
class BottomNavigate extends StatefulWidget {
  const BottomNavigate({super.key});
  @override
  State<BottomNavigate> createState() => _BottomNavigateState();
}
class _BottomNavigateState extends State<BottomNavigate> {
  int myIndex = 1;
  List<Widget> _widgetList = [

    Checkspage(),

   Homepage(),

    Addstudent()

  ];
  final List<Widget> _navigationitems = [
    const Icon(Icons.smart_toy_outlined,color: Colors.white,size: 25,),
     const Icon(Icons.home,color: Colors.white,size: 25),
     const Icon(Icons.person,color: Colors.white,size: 25)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetList[myIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: myIndex,
        backgroundColor: Colors.white,
        color: Colors.blue,
        height: 55,
        items: _navigationitems,
        onTap: (index){
          setState(() {
            myIndex = index;
          });
        },

      ),
    );
  }
}


