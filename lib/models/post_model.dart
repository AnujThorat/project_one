// lib/models/post_model.dart
// Exactly matches GetAllPostsModel structure with JSONPlaceholder compatibility

class GetAllPostsModel {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  // Extra metadata fields to support rich campus announcement display
  final String? authorName;
  final String? authorRole; // e.g. "Faculty", "Student Body", "Admin"
  final String? date;       // e.g. "Apr 25, 2025"
  final String? category;   // e.g. "Academics", "Events", "General", "Career"

  GetAllPostsModel({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.authorName,
    this.authorRole,
    this.date,
    this.category,
  });

  // Factory constructor to parse JSON from API or local storage
  factory GetAllPostsModel.fromJson(Map<String, dynamic> json) {
    return GetAllPostsModel(
      userId: json['userId'] is int
          ? json['userId'] as int
          : int.tryParse(json['userId']?.toString() ?? ''),
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? ''),
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      authorName: json['authorName']?.toString() ?? 'Dr. Sarah Mitchell',
      authorRole: json['authorRole']?.toString() ?? 'Faculty',
      date: json['date']?.toString() ?? 'Apr 25, 2025',
      category: json['category']?.toString() ?? 'Academics',
    );
  }

  // Convert model to JSON map for POST / PUT requests
  Map<String, dynamic> toJson() {
    return {
      'userId': userId ?? 1,
      if (id != null) 'id': id,
      'title': title ?? '',
      'body': body ?? '',
      if (authorName != null) 'authorName': authorName,
      if (authorRole != null) 'authorRole': authorRole,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
    };
  }

  // Create a copy with updated fields
  GetAllPostsModel copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
    String? authorName,
    String? authorRole,
    String? date,
    String? category,
  }) {
    return GetAllPostsModel(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      authorName: authorName ?? this.authorName,
      authorRole: authorRole ?? this.authorRole,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }
}
