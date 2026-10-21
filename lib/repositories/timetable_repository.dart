// lib/repositories/timetable_repository.dart
// Repository for class timetable schedules with REST API integration

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/timetable_model.dart';
import '../services/api_constants.dart';

class TimetableRepository {
  static final Map<String, List<TimetableModel>> _fallbackScheduleByDay = {
    'Wed': [
      TimetableModel(
        id: 1,
        subject: 'Computer Science',
        subjectCode: 'CS301',
        timeSlot: '8:00 AM - 9:00 AM',
        room: 'Room 101',
        faculty: 'Prof. Alan Turing',
        day: 'Wed',
        colorValue: 0xFF7C4DFF,
      ),
      TimetableModel(
        id: 2,
        subject: 'Mathematics',
        subjectCode: 'MATH201',
        timeSlot: '9:15 AM - 10:15 AM',
        room: 'Room 204',
        faculty: 'Dr. Leonard Euler',
        day: 'Wed',
        colorValue: 0xFF00B4D8,
      ),
      TimetableModel(
        id: 3,
        subject: 'Web Development',
        subjectCode: 'CS305',
        timeSlot: '11:00 AM - 12:00 PM',
        room: 'Lab 3',
        faculty: 'Prof. Tim Berners-Lee',
        day: 'Wed',
        colorValue: 0xFFFF9800,
      ),
      TimetableModel(
        id: 4,
        subject: 'English Communication',
        subjectCode: 'HUM102',
        timeSlot: '1:00 PM - 2:00 PM',
        room: 'Room 301',
        faculty: 'Dr. Maya Angelou',
        day: 'Wed',
        colorValue: 0xFFE91E63,
      ),
      TimetableModel(
        id: 5,
        subject: 'Database Systems',
        subjectCode: 'CS304',
        timeSlot: '2:15 PM - 3:15 PM',
        room: 'Room 102',
        faculty: 'Dr. Edgar Codd',
        day: 'Wed',
        colorValue: 0xFF0288D1,
      ),
    ],
    'Mon': [
      TimetableModel(
        id: 6,
        subject: 'Database Systems',
        subjectCode: 'CS304',
        timeSlot: '9:00 AM - 10:00 AM',
        room: 'Room 102',
        faculty: 'Dr. Edgar Codd',
        day: 'Mon',
        colorValue: 0xFF0288D1,
      ),
      TimetableModel(
        id: 7,
        subject: 'Computer Networks',
        subjectCode: 'CS302',
        timeSlot: '10:15 AM - 11:15 AM',
        room: 'Room 105',
        faculty: 'Prof. Vint Cerf',
        day: 'Mon',
        colorValue: 0xFF7C4DFF,
      ),
    ],
    'Tue': [
      TimetableModel(
        id: 9,
        subject: 'Mathematics',
        subjectCode: 'MATH201',
        timeSlot: '8:30 AM - 9:30 AM',
        room: 'Room 204',
        faculty: 'Dr. Leonard Euler',
        day: 'Tue',
        colorValue: 0xFF00B4D8,
      ),
      TimetableModel(
        id: 10,
        subject: 'Software Engineering',
        subjectCode: 'CS306',
        timeSlot: '10:00 AM - 11:00 AM',
        room: 'Room 108',
        faculty: 'Prof. Margaret Hamilton',
        day: 'Tue',
        colorValue: 0xFFFF9800,
      ),
    ],
    'Thu': [
      TimetableModel(
        id: 11,
        subject: 'Computer Science',
        subjectCode: 'CS301',
        timeSlot: '9:00 AM - 10:00 AM',
        room: 'Room 101',
        faculty: 'Prof. Alan Turing',
        day: 'Thu',
        colorValue: 0xFF7C4DFF,
      ),
      TimetableModel(
        id: 12,
        subject: 'English Communication',
        subjectCode: 'HUM102',
        timeSlot: '2:15 PM - 3:15 PM',
        room: 'Room 301',
        faculty: 'Dr. Maya Angelou',
        day: 'Thu',
        colorValue: 0xFFE91E63,
      ),
    ],
    'Fri': [
      TimetableModel(
        id: 13,
        subject: 'Mathematics',
        subjectCode: 'MATH201',
        timeSlot: '9:00 AM - 10:00 AM',
        room: 'Room 204',
        faculty: 'Dr. Leonard Euler',
        day: 'Fri',
        colorValue: 0xFF00B4D8,
      ),
    ],
    'Sat': [
      TimetableModel(
        id: 15,
        subject: 'Club Activities & Mentorship',
        subjectCode: 'ACT101',
        timeSlot: '10:00 AM - 1:00 PM',
        room: 'Student Center',
        faculty: 'Student Mentors',
        day: 'Sat',
        colorValue: 0xFF7C4DFF,
      ),
    ],
    'Sun': [],
  };

  // Fetch timetable for a day from Dummy REST API via HTTP GET
  Future<List<TimetableModel>> fetchTimetable({String day = 'Wed'}) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConstants.timetableEndpoint}?day=$day'))
          .timeout(ApiConstants.requestTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => TimetableModel.fromJson(json as Map<String, dynamic>)).toList();
      }
    } catch (_) {
      // Fallback
    }

    return _fallbackScheduleByDay[day] ?? _fallbackScheduleByDay['Wed'] ?? [];
  }
}
