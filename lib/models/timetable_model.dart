// lib/models/timetable_model.dart
// Model for daily class schedule items

class TimetableModel {
  final int id;
  final String subject;
  final String subjectCode;
  final String timeSlot;
  final String room;
  final String faculty;
  final String day; // 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
  final int colorValue;

  TimetableModel({
    required this.id,
    required this.subject,
    required this.subjectCode,
    required this.timeSlot,
    required this.room,
    required this.faculty,
    required this.day,
    required this.colorValue,
  });

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    return TimetableModel(
      id: json['id'] is int ? json['id'] as int : int.parse(json['id'].toString()),
      subject: json['subject']?.toString() ?? '',
      subjectCode: json['subjectCode']?.toString() ?? '',
      timeSlot: json['timeSlot']?.toString() ?? '',
      room: json['room']?.toString() ?? '',
      faculty: json['faculty']?.toString() ?? '',
      day: json['day']?.toString() ?? 'Wed',
      colorValue: json['colorValue'] is int ? json['colorValue'] as int : 0xFF6366F1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'subjectCode': subjectCode,
      'timeSlot': timeSlot,
      'room': room,
      'faculty': faculty,
      'day': day,
      'colorValue': colorValue,
    };
  }
}
