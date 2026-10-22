import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/timetable_model.dart';
import '../services/api_constants.dart';

class TimetableRepository {
  Future<List<TimetableModel>> fetchTimetable({String day = 'Wed'}) async {
    final response = await http
        .get(Uri.parse('${ApiConstants.timetableEndpoint}?day=$day'))
        .timeout(ApiConstants.requestTimeout);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TimetableModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load timetable (Status Code: ${response.statusCode})');
    }
  }
}
