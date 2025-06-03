import 'package:intl/intl.dart';

class Event {
  final int _eventId;
  String _name;
  String _description;
  String _location;
  int _maxAttendees;
  int _cost;
  String _paymentInfo;
  DateTime _dateTime;

  String? _ownerEmail;
  String? _ownerId;
  String? _ownerName;

  int get eventId => _eventId;
  String get name => _name;
  String get description => _description;
  String get location => _location;
  int get maxAttendees => _maxAttendees;
  int get cost => _cost;
  String get paymentInfo => _paymentInfo;
  DateTime get dateTime => _dateTime;

  String? get ownerEmail => _ownerEmail;
  String? get ownerId => _ownerId;
  String? get ownerName => _ownerName;

  Event({
    required int eventId,
    required String name,
    required String description,
    required String location,
    required int maxAttendees,
    required int cost,
    required String paymentInfo,
    required DateTime dateTime,
    String? ownerEmail,
    String? ownerId,
    String? ownerName,
  }) : _eventId = eventId,
       _name = name,
       _description = description,
       _location = location,
       _maxAttendees = maxAttendees,
       _cost = cost,
       _paymentInfo = paymentInfo,
       _dateTime = dateTime,
       _ownerEmail = ownerEmail,
       _ownerId = ownerId,
       _ownerName = ownerName;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      maxAttendees: json['maxAttendees'] as int,
      cost: json['cost'] as int,
      paymentInfo: json['paymentInfo'] as String,
      dateTime: DateTime.parse(json['eventDateTime'] as String),
      ownerEmail: json['ownerEmail'] as String,
      ownerId: json['ownerId'] as String,
      ownerName: json['ownerName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': _name,
    'description': _description,
    'location': _location,
    'maxAttendees': _maxAttendees,
    'cost': _cost,
    'paymentInfo': _paymentInfo,
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

  set name(String name) {
    _name = name;
  }

  set description(String description) {
    _description = description;
  }

  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
  }

  set maxAttendees(int maxA) {
    _maxAttendees = maxA;
  }

  set cost(int cost) {
    _cost = cost;
  }

  set paymentInfo(String paymentInfo) {
    _paymentInfo = paymentInfo;
  }

  set location(String location) {
    _location = location;
  }
}
