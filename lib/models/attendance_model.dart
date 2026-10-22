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
      id: json['id'] is int ? json['id'] as int : (int.tryParse(json['id']?.toString() ?? '') ?? 0),
      subject: json['subject']?.toString() ?? '',
      attended: json['attended'] is int ? json['attended'] as int : (int.tryParse(json['attended']?.toString() ?? '') ?? 0),
      total: json['total'] is int ? json['total'] as int : (int.tryParse(json['total']?.toString() ?? '') ?? 0),
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
      totalAttended: json['totalAttended'] is int ? json['totalAttended'] as int : (int.tryParse(json['totalAttended']?.toString() ?? '') ?? 0),
      totalClasses: json['totalClasses'] is int ? json['totalClasses'] as int : (int.tryParse(json['totalClasses']?.toString() ?? '') ?? 0),
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
