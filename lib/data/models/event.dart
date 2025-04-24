class Event {
  String _name;
  String _description;
  DateTime _dateTime;

  String get name => _name;
  String get description => _description;
  DateTime get dateTime => _dateTime;

  Event({required String name, required String description, required DateTime dateTime})
      : _name = name, _description = description, _dateTime = dateTime;


  // todo add unit tests:  In practice, the fromJson() and toJson() methods both need to have unit tests in place to verify correct behavior.
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'] as String,
      description: json['description'] as String,
      dateTime: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() => {'name': _name, 'description': _description, 'date': _dateTime};
}