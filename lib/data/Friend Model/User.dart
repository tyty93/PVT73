class User {
  final int _userId;
  String _name;
  String _email;
  bool _favourite;

  int get userId => _userId;
  String get name => _name;
  String get email => _email;
  bool get favourite => _favourite;

  User({required int userId, required String name, required String email, required bool favourite})
    :  _userId = userId, _name = name, _email = email, _favourite = favourite;
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      favourite: json['favourite'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': _userId,
    'name': name,
    'email': email,
  };
}