// lib/services/api_constants.dart
// Centralized API configuration and endpoints for CampusConnect

class ApiConstants {
  // Base URL for the Dummy API Server (Supports localhost on Windows/Web/Desktop)
  static const String baseUrl = 'http://127.0.0.1:8080/api';

  // Public Fallback URLs
  static const String jsonPlaceholderPostsUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Specific REST endpoints
  static const String postsEndpoint = '$baseUrl/posts';
  static const String eventsEndpoint = '$baseUrl/events';
  static const String timetableEndpoint = '$baseUrl/timetable';
  static const String attendanceEndpoint = '$baseUrl/attendance';
  static const String profileEndpoint = '$baseUrl/profile';
  static const String loginEndpoint = '$baseUrl/login';

  // Timeout durations
  static const Duration requestTimeout = Duration(seconds: 5);
}
