class SubjectAttendanceModel {
  final int id;
  final String subject;
  final int attended;
  final int total;
  final int colorValue;

  SubjectAttendanceModel({
    required this.id,
    required this.subject,
    required this.attended,
    required this.total,
    required this.colorValue,
  });

  double get percentage => total == 0 ? 0.0 : (attended / total) * 100.0;

  factory SubjectAttendanceModel.fromJson(Map<String, dynamic> json) {
    return SubjectAttendanceModel(
      id: json['id'] is int ? json['id'] as int : int.parse(json['id'].toString()),
      subject: json['subject']?.toString() ?? '',
      attended: json['attended'] is int ? json['attended'] as int : int.parse(json['attended'].toString()),
      total: json['total'] is int ? json['total'] as int : int.parse(json['total'].toString()),
      colorValue: json['colorValue'] is int ? json['colorValue'] as int : 0xFF6366F1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'attended': attended,
      'total': total,
      'colorValue': colorValue,
    };
  }
}

class AttendanceSummaryModel {
  final int totalAttended;
  final int totalClasses;
  final List<SubjectAttendanceModel> subjects;

  AttendanceSummaryModel({
    required this.totalAttended,
    required this.totalClasses,
    required this.subjects,
  });

  double get overallPercentage =>
      totalClasses == 0 ? 0.0 : (totalAttended / totalClasses) * 100.0;

  factory AttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    var rawList = json['subjects'] as List? ?? [];
    List<SubjectAttendanceModel> subjectsList = rawList
        .map((item) => SubjectAttendanceModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return AttendanceSummaryModel(
      totalAttended: json['totalAttended'] is int ? json['totalAttended'] as int : 42,
      totalClasses: json['totalClasses'] is int ? json['totalClasses'] as int : 48,
      subjects: subjectsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAttended': totalAttended,
      'totalClasses': totalClasses,
      'subjects': subjects.map((s) => s.toJson()).toList(),
    };
  }
}
