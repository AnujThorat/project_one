// lib/repositories/event_repository.dart
// Repository for campus events and student clubs with REST API integration

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import '../services/api_constants.dart';

class EventRepository {
  static final List<EventModel> _fallbackEvents = [
    EventModel(
      id: 1,
      title: 'Cultural Fest 2025',
      date: 'Apr 25, 2025',
      time: '10:00 AM',
      location: 'College Ground',
      category: 'Cultural',
      description:
          'Join us for the premier annual cultural festival featuring dance, battle of bands, fashion runway, and food stalls.',
      organizer: 'Student Council',
      colorValue: 0xFFE91E63,
      isBookmarked: true,
    ),
    EventModel(
      id: 2,
      title: 'Hackathon 2025',
      date: 'May 5, 2025',
      time: '9:00 AM',
      location: 'Computer Lab 3',
      category: 'Technical',
      description:
          '24-hour non-stop coding hackathon. Build innovative AI, Web3, and IoT solutions with exciting cash prizes.',
      organizer: 'Coding & Tech Club',
      colorValue: 0xFF0288D1,
      isBookmarked: false,
    ),
    EventModel(
      id: 3,
      title: 'Inter-College Football',
      date: 'May 12, 2025',
      time: '4:00 PM',
      location: 'Sports Ground',
      category: 'Sports',
      description:
          'Championship final clash between Riverside College and Metro University. Come cheer for your college team!',
      organizer: 'Sports Committee',
      colorValue: 0xFF43A047,
      isBookmarked: false,
    ),
    EventModel(
      id: 4,
      title: 'Robotics Workshop',
      date: 'May 18, 2025',
      time: '2:00 PM',
      location: 'Innovation Hub',
      category: 'Clubs',
      description:
          'Hands-on workshop on autonomous mobile robotics, sensor integration, and Arduino microcontrollers.',
      organizer: 'Robotics Society',
      colorValue: 0xFF8E24AA,
      isBookmarked: true,
    ),
    EventModel(
      id: 5,
      title: 'Annual Drama Night',
      date: 'May 22, 2025',
      time: '6:30 PM',
      location: 'Main Auditorium',
      category: 'Cultural',
      description:
          'An evening of theatrical brilliance featuring student-written stage plays and musical performances.',
      organizer: 'Theatre Club',
      colorValue: 0xFFE91E63,
      isBookmarked: false,
    ),
  ];

  // Fetch all events from Dummy REST API via HTTP GET
  Future<List<EventModel>> fetchEvents({String category = 'All'}) async {
    try {
      final url = category == 'All'
          ? ApiConstants.eventsEndpoint
          : '${ApiConstants.eventsEndpoint}?category=${Uri.encodeComponent(category)}';

      final response = await http
          .get(Uri.parse(url))
          .timeout(ApiConstants.requestTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => EventModel.fromJson(json as Map<String, dynamic>)).toList();
      }
    } catch (_) {
      // Fallback
    }

    if (category == 'All') {
      return List<EventModel>.from(_fallbackEvents);
    }
    return _fallbackEvents
        .where((e) => e.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  // Toggle bookmark
  Future<bool> toggleBookmark(int id) async {
    final index = _fallbackEvents.indexWhere((e) => e.id == id);
    if (index != -1) {
      final current = _fallbackEvents[index];
      _fallbackEvents[index] = current.copyWith(isBookmarked: !current.isBookmarked);
      return _fallbackEvents[index].isBookmarked;
    }
    return false;
  }
}
