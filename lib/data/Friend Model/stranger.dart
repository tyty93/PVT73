class Stranger{
  final int _userId;
  String _name;

  int get userId => _userId;
  String get name => _name;

  Stranger({required int userId, required String name})
    :  _userId = userId, _name = name;
  
  factory Stranger.fromJson(Map<String, dynamic> json) {
    return Stranger(
      userId: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': _userId,
    'name': name,
  };
}