
import 'event.dart';

class User {
  final String _id;
  String _name;
  String _email;
  List<Event> _participatingEvents;
  List<Event> _ownedEvents;

  bool _favourite;
  bool _incomingRequest;
  bool _outgoingRequest;
  bool _isFriend;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  List<Event> get participatingEvents => _participatingEvents;
  List<Event> get ownedEvents => _ownedEvents;
  bool get favourite => _favourite;
  bool get incomingRequest => _incomingRequest;
  bool get outgoingRequest => _outgoingRequest;
  bool get isFriend => _isFriend;
  

  User({
    required String id,
    required String name,
    required String email,
    List<Event>? participatingEvents,
    List<Event>? ownedEvents,
    bool favourite = false,
    bool incomingRequest = false,
    bool outgoingRequest = false,
    bool isFriend = false,
  })  : _id = id,
        _name = name,
        _email = email,
        _participatingEvents = participatingEvents ?? [],
        _ownedEvents = ownedEvents ?? [],
        _favourite = favourite,
        _incomingRequest = incomingRequest,
        _outgoingRequest = outgoingRequest,
        _isFriend = isFriend;

  factory User.fromJson(Map<String, dynamic> json) {

    List<Event> participatingEventsList = List.empty(growable: true);
    for (var e in (json['participationList'] as List)) {
      participatingEventsList.add(Event.fromJson(e['event']));
    }
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

  factory User.relationFromJson(Map<String, dynamic> json){
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      favourite: json['favourite'] as bool,
      incomingRequest: json['incomingRequest'] as bool,
      outgoingRequest: json['outgoingRequest'] as bool,
      isFriend: json['isFriend'] as bool,
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