import 'event.dart';

class User {
  final String _id;
  String _name;
  String _email;
  List<Event> _participatingEvents;
  List<Event> _ownedEvents;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  List<Event> get participatingEvents => _participatingEvents;
  List<Event> get ownedEvents => _ownedEvents;

  User({
    required String id,
    required String name,
    required String email,
    List<Event>? participatingEvents,
    List<Event>? ownedEvents,
  })  : _id = id,
        _name = name,
        _email = email,
        _participatingEvents = participatingEvents ?? [],
        _ownedEvents = ownedEvents ?? [];

  factory User.fromJson(Map<String, dynamic> json) {
    var participatingEventsList = (json['participatingEvents'] as List)
        .map((eventJson) => Event.fromJson(eventJson))
        .toList();
    var ownedEventsList = (json['ownedEvents'] as List)
        .map((eventJson) => Event.fromJson(eventJson))
        .toList();

    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      participatingEvents: participatingEventsList,
      ownedEvents: ownedEventsList,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'name': _name,
    'email': _email,
    'participatingEvents': _participatingEvents.map((event) => event.toJson()).toList(),
    'ownedEvents': _ownedEvents.map((event) => event.toJson()).toList(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              _id == other._id;

  @override
  int get hashCode => _id.hashCode;
}