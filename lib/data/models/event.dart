class Event {
  String _name;
  String _description;
  DateTime _dateTime;

  String get name => _name;
  String get description => _description;
  DateTime get dateTime => _dateTime;

  Event({required String name, required String description, required DateTime dateTime})
      : _name = name, _description = description, _dateTime = dateTime;

  /* todo code to parse json here? */
}