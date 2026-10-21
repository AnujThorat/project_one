// lib/repositories/attendance_repository.dart
// Repository for student attendance records with REST API integration

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/attendance_model.dart';
import '../services/api_constants.dart';

class AttendanceRepository {
  static final AttendanceSummaryModel _fallbackSummary = AttendanceSummaryModel(
    totalAttended: 42,
    totalClasses: 48,
    subjects: [
      SubjectAttendanceModel(
        id: 1,
        subject: 'Computer Science',
        attended: 11,
        total: 12,
        colorValue: 0xFF7C4DFF,
      ),
      SubjectAttendanceModel(
        id: 2,
        subject: 'Mathematics',
        attended: 10,
        total: 12,
        colorValue: 0xFF00B4D8,
      ),
      SubjectAttendanceModel(
        id: 3,
        subject: 'Web Development',
        attended: 10,
        total: 12,
        colorValue: 0xFFFF9800,
      ),
      SubjectAttendanceModel(
        id: 4,
        subject: 'English Communication',
        attended: 9,
        total: 12,
        colorValue: 0xFFE91E63,
      ),
      SubjectAttendanceModel(
        id: 5,
        subject: 'Database Systems',
        attended: 11,
        total: 12,
        colorValue: 0xFF0288D1,
      ),
    ],
  );

  // Fetch student attendance summary from Dummy REST API via HTTP GET
  Future<AttendanceSummaryModel> fetchAttendance() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.attendanceEndpoint))
          .timeout(ApiConstants.requestTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return AttendanceSummaryModel.fromJson(data);
      }
    } catch (_) {
      // Fallback
    }

    return _fallbackSummary;
  }
}
