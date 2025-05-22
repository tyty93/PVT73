import 'package:flutter_application_1/data/models/user.dart';

class Relation {
  User _user;
  bool _favourite;
  bool _incomingRequest;
  bool _outgoingRequest;
  bool _isFriend;

  User get user => _user;
  bool get favourite => _favourite;
  bool get incomingRequest => _incomingRequest;
  bool get outgoingRequest => _outgoingRequest;
  bool get isFriend => _isFriend;

  set favourite(bool value) => _favourite;

  Relation({
    required User user,
    required bool favourite, 
    required bool incomingRequest, 
    required bool outgoingRequest, 
    required bool isFriend
  })
    : _user = user,
      _favourite = favourite,
      _incomingRequest = incomingRequest,
      _outgoingRequest = outgoingRequest,
      _isFriend = isFriend;
  
  factory Relation.fromJson(Map<String, dynamic> json) {
    
    return Relation(
      user: User(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
      ),
      favourite: json['favourite'] as bool,
      incomingRequest: json['incomingRequest'] as bool,
      outgoingRequest: json['outgoingRequest'] as bool,
      isFriend: json['isFriend'] as bool,
    );
  }

  void toggleFavourite(){
    favourite = !favourite;
  }
}