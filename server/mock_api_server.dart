// ignore_for_file: avoid_print
// server/mock_api_server.dart
// Lightweight Standalone REST API Mock Server for CampusConnect
// Built using dart:io without external dependencies.
// Run using: dart run server/mock_api_server.dart

import 'dart:convert';
import 'dart:io';

const int port = 8080;

// In-Memory Database
final Map<String, dynamic> db = {
  'posts': [
    {
      'userId': 1,
      'id': 1,
      'title': 'Mid-Semester Exam Schedule',
      'body':
          'The exam schedule for mid-semester examinations has been released. Please check the official portal for detailed dates and seat allocations.',
      'authorName': 'Dr. Sarah Mitchell',
      'authorRole': 'Faculty',
      'date': 'Apr 25, 2025',
      'category': 'Academics',
    },
    {
      'userId': 1,
      'id': 2,
      'title': 'Cultural Fest 2025',
      'body':
          'Join us for the biggest cultural fest of the year! Registrations are now open for music, dance, and literary events.',
      'authorName': 'Student Council',
      'authorRole': 'Student Body',
      'date': 'Apr 24, 2025',
      'category': 'Events',
    },
    {
      'userId': 1,
      'id': 3,
      'title': 'Library Timings Updated',
      'body':
          'Library will remain open till 8 PM from Monday to Friday during exam week to provide extended study hours.',
      'authorName': 'Prof. James Carter',
      'authorRole': 'Faculty',
      'date': 'Apr 22, 2025',
      'category': 'General',
    },
    {
      'userId': 1,
      'id': 4,
      'title': 'Placement Drive at TechNova',
      'body':
          'TechNova is conducting a placement drive for final year students. Interested candidates can register through the career portal. Don\'t miss this opportunity!',
      'authorName': 'Career & Placement Cell',
      'authorRole': 'Faculty',
      'date': 'Apr 20, 2025',
      'category': 'Career',
    },
  ],
  'events': [
    {
      'id': 1,
      'title': 'Cultural Fest 2025',
      'date': 'Apr 25, 2025',
      'time': '10:00 AM',
      'location': 'College Ground',
      'category': 'Cultural',
      'description':
          'Join us for the premier annual cultural festival featuring dance, battle of bands, fashion runway, and food stalls.',
      'organizer': 'Student Council',
      'colorValue': 0xFFE91E63,
      'isBookmarked': true,
    },
    {
      'id': 2,
      'title': 'Hackathon 2025',
      'date': 'May 5, 2025',
      'time': '9:00 AM',
      'location': 'Computer Lab 3',
      'category': 'Technical',
      'description':
          '24-hour non-stop coding hackathon. Build innovative AI, Web3, and IoT solutions with exciting cash prizes.',
      'organizer': 'Coding & Tech Club',
      'colorValue': 0xFF0288D1,
      'isBookmarked': false,
    },
    {
      'id': 3,
      'title': 'Inter-College Football',
      'date': 'May 12, 2025',
      'time': '4:00 PM',
      'location': 'Sports Ground',
      'category': 'Sports',
      'description':
          'Championship final clash between Riverside College and Metro University. Come cheer for your college team!',
      'organizer': 'Sports Committee',
      'colorValue': 0xFF43A047,
      'isBookmarked': false,
    },
    {
      'id': 4,
      'title': 'Robotics Workshop',
      'date': 'May 18, 2025',
      'time': '2:00 PM',
      'location': 'Innovation Hub',
      'category': 'Clubs',
      'description':
          'Hands-on workshop on autonomous mobile robotics, sensor integration, and Arduino microcontrollers.',
      'organizer': 'Robotics Society',
      'colorValue': 0xFF8E24AA,
      'isBookmarked': true,
    },
    {
      'id': 5,
      'title': 'Annual Drama Night',
      'date': 'May 22, 2025',
      'time': '6:30 PM',
      'location': 'Main Auditorium',
      'category': 'Cultural',
      'description':
          'An evening of theatrical brilliance featuring student-written stage plays and musical performances.',
      'organizer': 'Theatre Club',
      'colorValue': 0xFFE91E63,
      'isBookmarked': false,
    },
  ],
  'timetable': {
    'Wed': [
      {
        'id': 1,
        'subject': 'Computer Science',
        'subjectCode': 'CS301',
        'timeSlot': '8:00 AM - 9:00 AM',
        'room': 'Room 101',
        'faculty': 'Prof. Alan Turing',
        'day': 'Wed',
        'colorValue': 0xFF7C4DFF,
      },
      {
        'id': 2,
        'subject': 'Mathematics',
        'subjectCode': 'MATH201',
        'timeSlot': '9:15 AM - 10:15 AM',
        'room': 'Room 204',
        'faculty': 'Dr. Leonard Euler',
        'day': 'Wed',
        'colorValue': 0xFF00B4D8,
      },
      {
        'id': 3,
        'subject': 'Web Development',
        'subjectCode': 'CS305',
        'timeSlot': '11:00 AM - 12:00 PM',
        'room': 'Lab 3',
        'faculty': 'Prof. Tim Berners-Lee',
        'day': 'Wed',
        'colorValue': 0xFFFF9800,
      },
      {
        'id': 4,
        'subject': 'English Communication',
        'subjectCode': 'HUM102',
        'timeSlot': '1:00 PM - 2:00 PM',
        'room': 'Room 301',
        'faculty': 'Dr. Maya Angelou',
        'day': 'Wed',
        'colorValue': 0xFFE91E63,
      },
      {
        'id': 5,
        'subject': 'Database Systems',
        'subjectCode': 'CS304',
        'timeSlot': '2:15 PM - 3:15 PM',
        'room': 'Room 102',
        'faculty': 'Dr. Edgar Codd',
        'day': 'Wed',
        'colorValue': 0xFF0288D1,
      },
    ],
    'Mon': [
      {
        'id': 6,
        'subject': 'Database Systems',
        'subjectCode': 'CS304',
        'timeSlot': '9:00 AM - 10:00 AM',
        'room': 'Room 102',
        'faculty': 'Dr. Edgar Codd',
        'day': 'Mon',
        'colorValue': 0xFF0288D1,
      },
      {
        'id': 7,
        'subject': 'Computer Networks',
        'subjectCode': 'CS302',
        'timeSlot': '10:15 AM - 11:15 AM',
        'room': 'Room 105',
        'faculty': 'Prof. Vint Cerf',
        'day': 'Mon',
        'colorValue': 0xFF7C4DFF,
      },
      {
        'id': 8,
        'subject': 'Operating Systems',
        'subjectCode': 'CS303',
        'timeSlot': '1:00 PM - 2:00 PM',
        'room': 'Room 201',
        'faculty': 'Dr. Linus Torvalds',
        'day': 'Mon',
        'colorValue': 0xFF00B4D8,
      },
    ],
    'Tue': [
      {
        'id': 9,
        'subject': 'Mathematics',
        'subjectCode': 'MATH201',
        'timeSlot': '8:30 AM - 9:30 AM',
        'room': 'Room 204',
        'faculty': 'Dr. Leonard Euler',
        'day': 'Tue',
        'colorValue': 0xFF00B4D8,
      },
      {
        'id': 10,
        'subject': 'Software Engineering',
        'subjectCode': 'CS306',
        'timeSlot': '10:00 AM - 11:00 AM',
        'room': 'Room 108',
        'faculty': 'Prof. Margaret Hamilton',
        'day': 'Tue',
        'colorValue': 0xFFFF9800,
      },
    ],
    'Thu': [
      {
        'id': 11,
        'subject': 'Computer Science',
        'subjectCode': 'CS301',
        'timeSlot': '9:00 AM - 10:00 AM',
        'room': 'Room 101',
        'faculty': 'Prof. Alan Turing',
        'day': 'Thu',
        'colorValue': 0xFF7C4DFF,
      },
      {
        'id': 12,
        'subject': 'English Communication',
        'subjectCode': 'HUM102',
        'timeSlot': '2:15 PM - 3:15 PM',
        'room': 'Room 301',
        'faculty': 'Dr. Maya Angelou',
        'day': 'Thu',
        'colorValue': 0xFFE91E63,
      },
    ],
    'Fri': [
      {
        'id': 13,
        'subject': 'Mathematics',
        'subjectCode': 'MATH201',
        'timeSlot': '9:00 AM - 10:00 AM',
        'room': 'Room 204',
        'faculty': 'Dr. Leonard Euler',
        'day': 'Fri',
        'colorValue': 0xFF00B4D8,
      },
      {
        'id': 14,
        'subject': 'Database Systems Lab',
        'subjectCode': 'CS304L',
        'timeSlot': '10:30 AM - 12:30 PM',
        'room': 'Lab 1',
        'faculty': 'Dr. Edgar Codd',
        'day': 'Fri',
        'colorValue': 0xFF0288D1,
      },
    ],
    'Sat': [
      {
        'id': 15,
        'subject': 'Club Activities & Mentorship',
        'subjectCode': 'ACT101',
        'timeSlot': '10:00 AM - 1:00 PM',
        'room': 'Student Center',
        'faculty': 'Student Mentors',
        'day': 'Sat',
        'colorValue': 0xFF7C4DFF,
      },
    ],
    'Sun': [],
  },
  'attendance': {
    'totalAttended': 42,
    'totalClasses': 48,
    'subjects': [
      {
        'id': 1,
        'subject': 'Computer Science',
        'attended': 11,
        'total': 12,
        'colorValue': 0xFF7C4DFF,
      },
      {
        'id': 2,
        'subject': 'Mathematics',
        'attended': 10,
        'total': 12,
        'colorValue': 0xFF00B4D8,
      },
      {
        'id': 3,
        'subject': 'Web Development',
        'attended': 10,
        'total': 12,
        'colorValue': 0xFFFF9800,
      },
      {
        'id': 4,
        'subject': 'English Communication',
        'attended': 9,
        'total': 12,
        'colorValue': 0xFFE91E63,
      },
      {
        'id': 5,
        'subject': 'Database Systems',
        'attended': 11,
        'total': 12,
        'colorValue': 0xFF0288D1,
      },
    ],
  },
  'profile': {
    'name': 'Alex Johnson',
    'rollNo': 'CS-2022-084',
    'semester': 6,
    'department': 'Computer Science & Engineering',
    'college': 'Riverside College',
    'cgpa': 8.94,
    'attendance': 87,
    'credits': 124,
    'email': 'alex.johnson@riverside.edu',
    'phone': '+1 (555) 019-2834',
  },
};

void main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, port);
  print('====================================================');
  print('🎓 CampusConnect Mock REST API Server is RUNNING');
  print('📡 Listening on: http://localhost:$port');
  print('📡 Endpoints available:');
  print('   • GET/POST       http://localhost:$port/api/posts');
  print('   • GET/PUT/DELETE http://localhost:$port/api/posts/{id}');
  print('   • GET            http://localhost:$port/api/events');
  print('   • GET            http://localhost:$port/api/timetable');
  print('   • GET            http://localhost:$port/api/attendance');
  print('   • GET            http://localhost:$port/api/profile');
  print('   • POST           http://localhost:$port/api/login');
  print('====================================================');

  await for (HttpRequest request in server) {
    handleRequest(request);
  }
}

Future<void> handleRequest(HttpRequest request) async {
  final res = request.response;

  // Add CORS Headers for Flutter Web / Emulators
  res.headers.add('Access-Control-Allow-Origin', '*');
  res.headers.add('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.headers.add('Access-Control-Allow-Headers', 'Origin, Content-Type, Authorization, Accept');
  res.headers.contentType = ContentType.json;

  // Handle pre-flight OPTIONS request
  if (request.method == 'OPTIONS') {
    res.statusCode = HttpStatus.ok;
    await res.close();
    return;
  }

  final path = request.uri.path;
  final method = request.method;
  print('[$method] $path${request.uri.hasQuery ? "?${request.uri.query}" : ""}');

  try {
    // ----------------------------------------------------
    // 1. POSTS CRUD: /api/posts & /api/posts/:id
    // ----------------------------------------------------
    if (path == '/api/posts' || path.startsWith('/api/posts/')) {
      final List<Map<String, dynamic>> postsList = db['posts'] as List<Map<String, dynamic>>;

      if (path == '/api/posts' && method == 'GET') {
        res.statusCode = HttpStatus.ok;
        res.write(jsonEncode(postsList));
        await res.close();
        return;
      }

      if (path == '/api/posts' && method == 'POST') {
        final content = await utf8.decoder.bind(request).join();
        final body = jsonDecode(content) as Map<String, dynamic>;

        final int newId = postsList.isNotEmpty
            ? (postsList.map((p) => p['id'] as int).reduce((a, b) => a > b ? a : b) + 1)
            : 1;

        final newPost = {
          'userId': body['userId'] ?? 1,
          'id': newId,
          'title': body['title'] ?? 'Untitled',
          'body': body['body'] ?? '',
          'authorName': body['authorName'] ?? 'Alex Johnson',
          'authorRole': body['authorRole'] ?? 'Student Council',
          'date': body['date'] ?? 'Apr 26, 2025',
          'category': body['category'] ?? 'Academics',
        };

        postsList.insert(0, newPost);
        res.statusCode = HttpStatus.created;
        res.write(jsonEncode(newPost));
        await res.close();
        return;
      }

      // Check for /api/posts/:id
      final segments = request.uri.pathSegments;
      if (segments.length == 3 && segments[1] == 'posts') {
        final id = int.tryParse(segments[2]);
        if (id == null) {
          res.statusCode = HttpStatus.badRequest;
          res.write(jsonEncode({'error': 'Invalid post id'}));
          await res.close();
          return;
        }

        if (method == 'GET') {
          final found = postsList.firstWhere((p) => p['id'] == id, orElse: () => {});
          if (found.isEmpty) {
            res.statusCode = HttpStatus.notFound;
            res.write(jsonEncode({'error': 'Post not found'}));
          } else {
            res.statusCode = HttpStatus.ok;
            res.write(jsonEncode(found));
          }
          await res.close();
          return;
        }

        if (method == 'PUT') {
          final content = await utf8.decoder.bind(request).join();
          final body = jsonDecode(content) as Map<String, dynamic>;
          final index = postsList.indexWhere((p) => p['id'] == id);

          if (index != -1) {
            final existing = postsList[index];
            existing['title'] = body['title'] ?? existing['title'];
            existing['body'] = body['body'] ?? existing['body'];
            if (body['category'] != null) existing['category'] = body['category'];
            postsList[index] = existing;

            res.statusCode = HttpStatus.ok;
            res.write(jsonEncode(existing));
          } else {
            final updated = {
              'id': id,
              'userId': body['userId'] ?? 1,
              'title': body['title'] ?? '',
              'body': body['body'] ?? '',
              'authorName': 'Faculty / Admin',
              'authorRole': 'Faculty',
              'date': 'Apr 26, 2025',
              'category': body['category'] ?? 'General',
            };
            postsList.insert(0, updated);
            res.statusCode = HttpStatus.ok;
            res.write(jsonEncode(updated));
          }
          await res.close();
          return;
        }

        if (method == 'DELETE') {
          postsList.removeWhere((p) => p['id'] == id);
          res.statusCode = HttpStatus.ok;
          res.write(jsonEncode({'success': true, 'message': 'Post $id deleted successfully'}));
          await res.close();
          return;
        }
      }
    }

    // ----------------------------------------------------
    // 2. EVENTS: /api/events
    // ----------------------------------------------------
    if (path == '/api/events' && method == 'GET') {
      final category = request.uri.queryParameters['category'];
      final List<Map<String, dynamic>> events = db['events'] as List<Map<String, dynamic>>;

      if (category != null && category.isNotEmpty && category.toLowerCase() != 'all') {
        final filtered = events
            .where((e) => e['category'].toString().toLowerCase() == category.toLowerCase())
            .toList();
        res.statusCode = HttpStatus.ok;
        res.write(jsonEncode(filtered));
      } else {
        res.statusCode = HttpStatus.ok;
        res.write(jsonEncode(events));
      }
      await res.close();
      return;
    }

    // ----------------------------------------------------
    // 3. TIMETABLE: /api/timetable
    // ----------------------------------------------------
    if (path == '/api/timetable' && method == 'GET') {
      final day = request.uri.queryParameters['day'] ?? 'Wed';
      final Map<String, dynamic> timetable = db['timetable'] as Map<String, dynamic>;
      final list = timetable[day] ?? timetable['Wed'] ?? [];

      res.statusCode = HttpStatus.ok;
      res.write(jsonEncode(list));
      await res.close();
      return;
    }

    // ----------------------------------------------------
    // 4. ATTENDANCE: /api/attendance
    // ----------------------------------------------------
    if (path == '/api/attendance' && method == 'GET') {
      final attendance = db['attendance'];
      res.statusCode = HttpStatus.ok;
      res.write(jsonEncode(attendance));
      await res.close();
      return;
    }

    // ----------------------------------------------------
    // 5. PROFILE: /api/profile
    // ----------------------------------------------------
    if (path == '/api/profile' && method == 'GET') {
      final profile = db['profile'];
      res.statusCode = HttpStatus.ok;
      res.write(jsonEncode(profile));
      await res.close();
      return;
    }

    // ----------------------------------------------------
    // 6. LOGIN: /api/login
    // ----------------------------------------------------
    if (path == '/api/login' && method == 'POST') {
      final content = await utf8.decoder.bind(request).join();
      final body = jsonDecode(content) as Map<String, dynamic>;

      res.statusCode = HttpStatus.ok;
      res.write(jsonEncode({
        'token': 'mock_campusconnect_token_xyz987',
        'status': 'success',
        'user': {
          'email': body['email'] ?? 'alex.johnson@riverside.edu',
          'name': 'Alex Johnson',
          'rollNo': 'CS-2022-084',
        }
      }));
      await res.close();
      return;
    }

    // Default 404
    res.statusCode = HttpStatus.notFound;
    res.write(jsonEncode({'error': 'Endpoint not found', 'path': path}));
    await res.close();
  } catch (e, stack) {
    print('Server Error: $e\n$stack');
    res.statusCode = HttpStatus.internalServerError;
    res.write(jsonEncode({'error': e.toString()}));
    await res.close();
  }
}
