class Student {
  final int studentId;
  final String name;
  final String email;
  final double cgpa;
  final int deptId;

  Student({
    required this.studentId,
    required this.name,
    required this.email,
    required this.cgpa,
    required this.deptId,
  });

  Student copyWith({
    int? studentId,
    String? name,
    String? email,
    double? cgpa,
    int? deptId,
  }) {
    return Student(
      studentId: studentId ?? this.studentId,
      name: name ?? this.name,
      email: email ?? this.email,
      cgpa: cgpa ?? this.cgpa,
      deptId: deptId ?? this.deptId,
    );
  }
}
