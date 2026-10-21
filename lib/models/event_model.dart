// lib/models/event_model.dart
// Model representing college events and club activities

class EventModel {
  final int id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String category; // 'Cultural', 'Technical', 'Sports', 'Clubs'
  final String description;
  final String organizer;
  final int colorValue;
  final bool isBookmarked;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.description,
    required this.organizer,
    required this.colorValue,
    this.isBookmarked = false,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] is int ? json['id'] as int : int.parse(json['id'].toString()),
      title: json['title']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      category: json['category']?.toString() ?? 'General',
      description: json['description']?.toString() ?? '',
      organizer: json['organizer']?.toString() ?? 'College Council',
      colorValue: json['colorValue'] is int ? json['colorValue'] as int : 0xFF6366F1,
      isBookmarked: json['isBookmarked'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'time': time,
      'location': location,
      'category': category,
      'description': description,
      'organizer': organizer,
      'colorValue': colorValue,
      'isBookmarked': isBookmarked,
    };
  }

  EventModel copyWith({
    int? id,
    String? title,
    String? date,
    String? time,
    String? location,
    String? category,
    String? description,
    String? organizer,
    int? colorValue,
    bool? isBookmarked,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      category: category ?? this.category,
      description: description ?? this.description,
      organizer: organizer ?? this.organizer,
      colorValue: colorValue ?? this.colorValue,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
