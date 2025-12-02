class CheckIn {
  final String id;
  final String studentId;
  final String studentName;
  final DateTime checkInTime;

  CheckIn({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.checkInTime,
  });

  factory CheckIn.fromJson(Map<String, dynamic> json) {
    return CheckIn(
      id: json['_id'] ?? '',
      studentId: json['studentId'] ?? '',
      studentName: json['studentName'] ?? 'Unknown',

      checkInTime: DateTime.parse(json['checkInTime']).toLocal(),
    );
  }
}