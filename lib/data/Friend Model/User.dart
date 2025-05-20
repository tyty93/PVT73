class User {
  final String _userId;
  String _name;
  String _email;
  bool _favourite;
  bool _incomingRequest;
  bool _outgoingRequest;
  bool _isFriend;

  String get userId => _userId;
  String get name => _name;
  String get email => _email;
  bool get favourite => _favourite;
  bool get incomingRequest => _incomingRequest;
  bool get outgoingRequest => _outgoingRequest;
  bool get isFriend => _isFriend;

  set favourite(bool value) => _favourite;

  User({
    required String userId, 
    required String name, 
    required String email, 
    required bool favourite, 
    required bool incomingRequest, 
    required bool outgoingRequest, 
    required bool isFriend
  })
    : _userId = userId, 
      _name = name,
      _email = email,
      _favourite = favourite,
      _incomingRequest = incomingRequest,
      _outgoingRequest = outgoingRequest,
      _isFriend = isFriend;
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      favourite: json['favourite'] as bool,
      incomingRequest: json['incomingRequest'] as bool,
      outgoingRequest: json['outgoingRequest'] as bool,
      isFriend: json['isFriend'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': _userId,
    'name': name,
    'email': email,
  };
}