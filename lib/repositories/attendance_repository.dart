// lib/repositories/attendance_repository.dart
// Repository for student attendance records

import '../models/attendance_model.dart';

class AttendanceRepository {
  static final AttendanceSummaryModel _attendanceSummary = AttendanceSummaryModel(
    totalAttended: 42,
    totalClasses: 48,
    subjects: [
      SubjectAttendanceModel(
        id: 1,
        subject: 'Computer Science',
        attended: 11,
        total: 12,
        colorValue: 0xFF7C4DFF, // Purple
      ),
      SubjectAttendanceModel(
        id: 2,
        subject: 'Mathematics',
        attended: 10,
        total: 12,
        colorValue: 0xFF00B4D8, // Teal/Cyan
      ),
      SubjectAttendanceModel(
        id: 3,
        subject: 'Web Development',
        attended: 10,
        total: 12,
        colorValue: 0xFFFF9800, // Orange
      ),
      SubjectAttendanceModel(
        id: 4,
        subject: 'English Communication',
        attended: 9,
        total: 12,
        colorValue: 0xFFE91E63, // Pink
      ),
      SubjectAttendanceModel(
        id: 5,
        subject: 'Database Systems',
        attended: 11,
        total: 12,
        colorValue: 0xFF0288D1, // Blue
      ),
    ],
  );

  Future<AttendanceSummaryModel> fetchAttendance() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _attendanceSummary;
  }
}
