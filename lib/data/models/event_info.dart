import 'event.dart'; 

class EventInfo {
  final Event event;           
  final String ownerEmail;     

  EventInfo({required this.event, required this.ownerEmail});

  factory EventInfo.fromJson(Map<String, dynamic> json) {
    return EventInfo(
      event: Event.fromJson(json),
      ownerEmail: json['ownerEmail'] ?? 'noemail@example.com',
    );
  }

  int get eventId => event.eventId;
  String get name => event.name;
  String get description => event.description;
  DateTime get dateTime => event.dateTime;
  String get location => event.location;
  int get maxAttendees => event.maxAttendees;
}