import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/components.dart';
import '../services/student_services.dart';
import '../models/checkin_model.dart';

class Showcheckondate extends StatefulWidget {
  final String dateStr;
  const Showcheckondate({super.key, required this.dateStr});

  @override
  State<Showcheckondate> createState() => _ShowcheckondateState();
}

class _ShowcheckondateState extends State<Showcheckondate> {
  late Future<List<CheckIn>> _checkInsFuture;

  @override
  void initState() {
    super.initState();
    _checkInsFuture = StudentService().getCheckIns();
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        title: Text(
          widget.dateStr,
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<CheckIn>>(
        future: _checkInsFuture,
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }


          if (!snapshot.hasData) return const SizedBox();

          final allChecks = snapshot.data!;
          final filteredChecks = allChecks.where((item) {
            return _formatDate(item.checkInTime) == widget.dateStr;
          }).toList();

          if (filteredChecks.isEmpty) {
            return const Center(child: Text("No data for this date"));
          }


          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20),
            itemCount: filteredChecks.length,
            itemBuilder: (context, index) {
              final item = filteredChecks[index];


              String time = "${item.checkInTime.hour}:${item.checkInTime.minute.toString().padLeft(2, '0')}";

              return Components().ChecksTile(
                  context,
                  item.studentName,
                  "ID: ${item.studentId}  •  $time"
              );
            },
          );
        },
      ),
    );
  }
}