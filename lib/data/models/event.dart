import 'package:intl/intl.dart';

class Event {
  final int _eventId;
  String _name;
  String _description;
  String _theme;
  String _location;
  int _maxAttendees;
  DateTime _dateTime;

  String? _ownerEmail;
  String? _ownerId;

  int get eventId => _eventId;
  String get name => _name;
  String get description => _description;
  String get theme => _theme;
  String get location => _location;
  int get maxAttendees => _maxAttendees;
  DateTime get dateTime => _dateTime;

  String? get ownerEmail => _ownerEmail;
  String? get ownerId => _ownerId;

  Event({
    required int eventId,
    required String name,
    required String description,
    required String theme,
    required String location,
    required int maxAttendees,
    required DateTime dateTime,
    String? ownerEmail,
    String? ownerId,
  })  : _eventId = eventId,
        _name = name,
        _description = description,
        _theme = theme,
        _location = location,
        _maxAttendees = maxAttendees,
        _dateTime = dateTime,
        _ownerEmail = ownerEmail,
        _ownerId = ownerId;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      theme: json['theme'] as String,
      location: json['location'] as String,
      maxAttendees: json['maxAttendees'] as int,
      dateTime: DateTime.parse(json['eventDateTime'] as String),
      ownerEmail: json['ownerEmail'] as String, 
      ownerId: json['ownerId'] as String,
    );
  }

  // check how this is used, if at all. Had to omit id because it is auto-generated!
  // create event is not toJson'ing antything, its just usuing jsonEncode(data)..
  Map<String, dynamic> toJson() => {
    'name': _name,
    'description': _description,
    'theme': _theme,
    'location': _location,
    'maxAttendees': _maxAttendees,
    'eventDateTime': DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(_dateTime),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Event &&
              runtimeType == other.runtimeType &&
              _eventId == other._eventId;

  @override
  int get hashCode => _eventId.hashCode;

  get getOwnerEmail => ownerEmail;
}