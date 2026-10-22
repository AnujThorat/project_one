import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/attendance_model.dart';
import '../services/api_constants.dart';

class AttendanceRepository {
  Future<AttendanceSummaryModel> fetchAttendance() async {
    final response = await http
        .get(Uri.parse(ApiConstants.attendanceEndpoint))
        .timeout(ApiConstants.requestTimeout);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return AttendanceSummaryModel.fromJson(data);
    } else {
      throw Exception('Failed to load attendance (Status Code: ${response.statusCode})');
    }
  }
}
