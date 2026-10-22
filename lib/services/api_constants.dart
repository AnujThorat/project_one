class ApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8080/api';

  static const String jsonPlaceholderPostsUrl = 'https://jsonplaceholder.typicode.com/posts';

  static const String postsEndpoint = '$baseUrl/posts';
  static const String eventsEndpoint = '$baseUrl/events';
  static const String timetableEndpoint = '$baseUrl/timetable';
  static const String attendanceEndpoint = '$baseUrl/attendance';
  static const String profileEndpoint = '$baseUrl/profile';
  static const String loginEndpoint = '$baseUrl/login';

  static const Duration requestTimeout = Duration(seconds: 5);
}
