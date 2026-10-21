// lib/repositories/post_repository.dart
// Post repository implementing FULL CRUD operations with Dummy REST API & JSONPlaceholder

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../services/api_constants.dart';

class PostRepository {
  // Required exact API URL signature
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  static const String mockApiUrl = ApiConstants.postsEndpoint;

  // In-memory fallback campus announcements store
  static final List<GetAllPostsModel> _localPosts = [
    GetAllPostsModel(
      userId: 1,
      id: 1,
      title: 'Mid-Semester Exam Schedule',
      body:
          'The exam schedule for mid-semester examinations has been released. Please check the official portal for detailed dates and seat allocations.',
      authorName: 'Dr. Sarah Mitchell',
      authorRole: 'Faculty',
      date: 'Apr 25, 2025',
      category: 'Academics',
    ),
    GetAllPostsModel(
      userId: 1,
      id: 2,
      title: 'Cultural Fest 2025',
      body:
          'Join us for the biggest cultural fest of the year! Registrations are now open for music, dance, and literary events.',
      authorName: 'Student Council',
      authorRole: 'Student Body',
      date: 'Apr 24, 2025',
      category: 'Events',
    ),
    GetAllPostsModel(
      userId: 1,
      id: 3,
      title: 'Library Timings Updated',
      body:
          'Library will remain open till 8 PM from Monday to Friday during exam week to provide extended study hours.',
      authorName: 'Prof. James Carter',
      authorRole: 'Faculty',
      date: 'Apr 22, 2025',
      category: 'General',
    ),
    GetAllPostsModel(
      userId: 1,
      id: 4,
      title: 'Placement Drive at TechNova',
      body:
          'TechNova is conducting a placement drive for final year students. Interested candidates can register through the career portal. Don\'t miss this opportunity!',
      authorName: 'Career & Placement Cell',
      authorRole: 'Faculty',
      date: 'Apr 20, 2025',
      category: 'Career',
    ),
  ];

  // 1. GET - Fetch all posts from Dummy API or fallback
  Future<List<GetAllPostsModel>> fetchPosts() async {
    // Attempt 1: Fetch from Dummy REST API Server
    try {
      final response = await http
          .get(Uri.parse(mockApiUrl))
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => GetAllPostsModel.fromJson(json as Map<String, dynamic>)).toList();
      }
    } catch (_) {
      // Fall through to Attempt 2
    }

    // Attempt 2: Fetch from JSONPlaceholder API
    try {
      final response = await http
          .get(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final apiPosts = data.take(4).map((item) {
          final int id = item['id'] as int;
          return GetAllPostsModel(
            userId: item['userId'] as int? ?? 1,
            id: id + 100,
            title: item['title']?.toString() ?? '',
            body: item['body']?.toString() ?? '',
            authorName: 'Prof. Alan Turing',
            authorRole: 'Faculty',
            date: 'Apr 18, 2025',
            category: 'Academics',
          );
        }).toList();

        final combined = List<GetAllPostsModel>.from(_localPosts)..addAll(apiPosts);
        return combined;
      }
    } catch (_) {
      // Offline fallback
    }

    return List<GetAllPostsModel>.from(_localPosts);
  }

  // 2. POST - Create new post
  Future<GetAllPostsModel> createPost({
    required String title,
    required String body,
    int userId = 1,
    String authorName = 'Student Council',
    String authorRole = 'Student Body',
    String category = 'Academics',
  }) async {
    final payload = {
      'title': title,
      'body': body,
      'userId': userId,
      'authorName': authorName,
      'authorRole': authorRole,
      'category': category,
      'date': 'Apr 26, 2025',
    };

    // Attempt 1: POST to Dummy REST API Server
    try {
      final response = await http
          .post(
            Uri.parse(mockApiUrl),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 201 || response.statusCode == 200) {
        final created = GetAllPostsModel.fromJson(jsonDecode(response.body));
        _localPosts.insert(0, created);
        return created;
      }
    } catch (_) {
      // Fall through
    }

    // Attempt 2: POST to JSONPlaceholder API
    try {
      final response = await http
          .post(
            Uri.parse(apiUrl),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({'title': title, 'body': body, 'userId': userId}),
          )
          .timeout(const Duration(seconds: 4));

      final int newId = (response.statusCode == 201 || response.statusCode == 200)
          ? (_localPosts.isNotEmpty ? _localPosts.map((e) => e.id ?? 0).reduce((a, b) => a > b ? a : b) + 1 : 101)
          : DateTime.now().millisecondsSinceEpoch % 10000;

      final newPost = GetAllPostsModel(
        userId: userId,
        id: newId,
        title: title,
        body: body,
        authorName: authorName,
        authorRole: authorRole,
        date: 'Apr 26, 2025',
        category: category,
      );

      _localPosts.insert(0, newPost);
      return newPost;
    } catch (_) {
      final newPost = GetAllPostsModel(
        userId: userId,
        id: DateTime.now().millisecondsSinceEpoch % 10000,
        title: title,
        body: body,
        authorName: authorName,
        authorRole: authorRole,
        date: 'Apr 26, 2025',
        category: category,
      );
      _localPosts.insert(0, newPost);
      return newPost;
    }
  }

  // 3. PUT - Update existing post
  Future<GetAllPostsModel> updatePost({
    required int id,
    required String title,
    required String body,
    int userId = 1,
    String? category,
  }) async {
    final payload = {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
      'category': category ?? 'General',
    };

    // Attempt 1: PUT to Dummy REST API Server
    try {
      final response = await http
          .put(
            Uri.parse('$mockApiUrl/$id'),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final updated = GetAllPostsModel.fromJson(jsonDecode(response.body));
        final index = _localPosts.indexWhere((p) => p.id == id);
        if (index != -1) _localPosts[index] = updated;
        return updated;
      }
    } catch (_) {
      // Fall through
    }

    // Attempt 2: PUT to JSONPlaceholder API
    try {
      await http
          .put(
            Uri.parse('$apiUrl/$id'),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({'id': id, 'title': title, 'body': body, 'userId': userId}),
          )
          .timeout(const Duration(seconds: 4));

      final index = _localPosts.indexWhere((p) => p.id == id);
      if (index != -1) {
        final existing = _localPosts[index];
        final updated = existing.copyWith(
          title: title,
          body: body,
          category: category ?? existing.category,
        );
        _localPosts[index] = updated;
        return updated;
      }
    } catch (_) {
      // Fallback
    }

    final index = _localPosts.indexWhere((p) => p.id == id);
    if (index != -1) {
      final existing = _localPosts[index];
      final updated = existing.copyWith(
        title: title,
        body: body,
        category: category ?? existing.category,
      );
      _localPosts[index] = updated;
      return updated;
    }

    return GetAllPostsModel(
      id: id,
      userId: userId,
      title: title,
      body: body,
      category: category ?? 'General',
    );
  }

  // 4. DELETE - Delete a post
  Future<void> deletePost(int id) async {
    // Attempt 1: DELETE from Dummy REST API Server
    try {
      final response = await http
          .delete(Uri.parse('$mockApiUrl/$id'))
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200 || response.statusCode == 204) {
        _localPosts.removeWhere((p) => p.id == id);
        return;
      }
    } catch (_) {
      // Fall through
    }

    // Attempt 2: DELETE from JSONPlaceholder API
    try {
      final response = await http
          .delete(Uri.parse('$apiUrl/$id'))
          .timeout(const Duration(seconds: 4));

      if (response.statusCode != 200 && response.statusCode != 204) {
        _localPosts.removeWhere((p) => p.id == id);
        return;
      }
      _localPosts.removeWhere((p) => p.id == id);
    } catch (_) {
      _localPosts.removeWhere((p) => p.id == id);
    }
  }
}
