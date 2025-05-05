class Event {
  final int _eventId;
  String _name;
  String _description;
  DateTime _dateTime;

  int get eventId => _eventId;
  String get name => _name;
  String get description => _description;
  DateTime get dateTime => _dateTime;

  Event({required int eventId, required String name, required String description, required DateTime dateTime})
      : _eventId = eventId, _name = name, _description = description, _dateTime = dateTime;


  // todo add unit tests:  In practice, the fromJson() and toJson() methods both need to have unit tests in place to verify correct behavior.
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      dateTime: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'eventId': _eventId,
    'name': _name,
    'description': _description,
    'date': _dateTime.toIso8601String()
  };
}