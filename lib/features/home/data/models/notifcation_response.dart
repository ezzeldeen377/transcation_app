class NotificationResponse {
  final String message;
  final List<Notification> notifications;

  NotificationResponse({
    required this.message,
    required this.notifications,
  });

  // Factory constructor to create a NotificationResponse instance from a map (JSON)
  factory NotificationResponse.fromMap(Map<String, dynamic> map) {
    return NotificationResponse(
      message: map['message'],
      notifications: List<Notification>.from(
        map['notifications'].map((x) => Notification.fromMap(x)),
      ),
    );
  }

  // Method to convert the NotificationResponse instance back to a map
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'notifications': List<dynamic>.from(notifications.map((x) => x.toMap())),
    };
  }
}

class Notification {
  final int id;
  final String title;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a Notification instance from a map (JSON)
  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'],
      title: map['title'],
      message: map['message'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  // Method to convert the Notification instance back to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
