class EventInfo {
  final int id;
  final String name;
  final String description;
  final String? theme;
  final String? location;
  final int? maxAttendees;
  final DateTime dateTime;
  final String ownerEmail;

  EventInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.dateTime,
    this.theme,
    this.location,
    this.maxAttendees,
    required this.ownerEmail,
  });

  factory EventInfo.fromJson(Map<String, dynamic> json) {
    return EventInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      theme: json['theme'] as String?, // Optional
      location: json['location'] as String?, // Optional
      maxAttendees: json['maxAttendees'] as int?, // Optional
      dateTime: DateTime.parse(json['eventDateTime'] as String),
      ownerEmail: json['ownerEmail'] ?? 'noemail@example.com',
    );
  }
}
