import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import '../services/api_constants.dart';

class EventRepository {
  Future<List<EventModel>> fetchEvents({String category = 'All'}) async {
    final url = category == 'All'
        ? ApiConstants.eventsEndpoint
        : '${ApiConstants.eventsEndpoint}?category=${Uri.encodeComponent(category)}';

    final response = await http
        .get(Uri.parse(url))
        .timeout(ApiConstants.requestTimeout);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => EventModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load events (Status Code: ${response.statusCode})');
    }
  }

  Future<bool> toggleBookmark(int id) async {
    return false;
  }
}
