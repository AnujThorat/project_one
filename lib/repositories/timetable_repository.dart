// lib/repositories/timetable_repository.dart
// Repository for class timetable schedules

import '../models/timetable_model.dart';

class TimetableRepository {
  static final Map<String, List<TimetableModel>> _scheduleByDay = {
    'Wed': [
      TimetableModel(
        id: 1,
        subject: 'Computer Science',
        subjectCode: 'CS301',
        timeSlot: '8:00 AM - 9:00 AM',
        room: 'Room 101',
        faculty: 'Prof. Alan Turing',
        day: 'Wed',
        colorValue: 0xFF7C4DFF, // Purple
      ),
      TimetableModel(
        id: 2,
        subject: 'Mathematics',
        subjectCode: 'MATH201',
        timeSlot: '9:15 AM - 10:15 AM',
        room: 'Room 204',
        faculty: 'Dr. Leonard Euler',
        day: 'Wed',
        colorValue: 0xFF00B4D8, // Teal/Cyan
      ),
      TimetableModel(
        id: 3,
        subject: 'Web Development',
        subjectCode: 'CS305',
        timeSlot: '11:00 AM - 12:00 PM',
        room: 'Lab 3',
        faculty: 'Prof. Tim Berners-Lee',
        day: 'Wed',
        colorValue: 0xFFFF9800, // Amber/Orange
      ),
      TimetableModel(
        id: 4,
        subject: 'English Communication',
        subjectCode: 'HUM102',
        timeSlot: '1:00 PM - 2:00 PM',
        room: 'Room 301',
        faculty: 'Dr. Maya Angelou',
        day: 'Wed',
        colorValue: 0xFFE91E63, // Pink
      ),
      TimetableModel(
        id: 5,
        subject: 'Database Systems',
        subjectCode: 'CS304',
        timeSlot: '2:15 PM - 3:15 PM',
        room: 'Room 102',
        faculty: 'Dr. Edgar Codd',
        day: 'Wed',
        colorValue: 0xFF0288D1, // Blue
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
      TimetableModel(
        id: 8,
        subject: 'Operating Systems',
        subjectCode: 'CS303',
        timeSlot: '1:00 PM - 2:00 PM',
        room: 'Room 201',
        faculty: 'Dr. Linus Torvalds',
        day: 'Mon',
        colorValue: 0xFF00B4D8,
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
      TimetableModel(
        id: 11,
        subject: 'Web Development Lab',
        subjectCode: 'CS305L',
        timeSlot: '1:30 PM - 3:30 PM',
        room: 'Lab 3',
        faculty: 'Prof. Tim Berners-Lee',
        day: 'Tue',
        colorValue: 0xFFE91E63,
      ),
    ],
    'Thu': [
      TimetableModel(
        id: 12,
        subject: 'Computer Science',
        subjectCode: 'CS301',
        timeSlot: '9:00 AM - 10:00 AM',
        room: 'Room 101',
        faculty: 'Prof. Alan Turing',
        day: 'Thu',
        colorValue: 0xFF7C4DFF,
      ),
      TimetableModel(
        id: 13,
        subject: 'Operating Systems Lab',
        subjectCode: 'CS303L',
        timeSlot: '11:00 AM - 1:00 PM',
        room: 'Lab 2',
        faculty: 'Dr. Linus Torvalds',
        day: 'Thu',
        colorValue: 0xFF00B4D8,
      ),
      TimetableModel(
        id: 14,
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
        id: 15,
        subject: 'Mathematics',
        subjectCode: 'MATH201',
        timeSlot: '9:00 AM - 10:00 AM',
        room: 'Room 204',
        faculty: 'Dr. Leonard Euler',
        day: 'Fri',
        colorValue: 0xFF00B4D8,
      ),
      TimetableModel(
        id: 16,
        subject: 'Database Systems Lab',
        subjectCode: 'CS304L',
        timeSlot: '10:30 AM - 12:30 PM',
        room: 'Lab 1',
        faculty: 'Dr. Edgar Codd',
        day: 'Fri',
        colorValue: 0xFF0288D1,
      ),
      TimetableModel(
        id: 17,
        subject: 'Project Seminar',
        subjectCode: 'CS399',
        timeSlot: '2:00 PM - 4:00 PM',
        room: 'Auditorium B',
        faculty: 'Department Faculty',
        day: 'Fri',
        colorValue: 0xFFFF9800,
      ),
    ],
    'Sat': [
      TimetableModel(
        id: 18,
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

  Future<List<TimetableModel>> fetchTimetable({String day = 'Wed'}) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return _scheduleByDay[day] ?? _scheduleByDay['Wed'] ?? [];
  }
}
