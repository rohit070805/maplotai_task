class Student {
  final String id;
  final String name;
  final String email;
  final String studentId;
  final String district;
  final String state;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.studentId,
    required this.district,
    required this.state,
  });


  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? '',
      studentId: json['studentId'] ?? '',
      district: json['district'] ?? '',
      state: json['state'] ?? '',
    );
  }
}