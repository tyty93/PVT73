import '../models/user.dart';
import '../services/user_service.dart';

abstract class UserRepository {
  Future<User> createUser({
    required String id,
    required String name,
    required String email,
  });
  // todo: in future add more ops such as getMyParticipations, getMyOwned, etc..
}

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  Future<User> createUser({
    required String id,
    required String name,
    required String email,
  }) async {
    await _userService.createUser(id: id, name: name, email: email);

    return User(
      id: id,
      name: name,
      email: email,
      participatingEvents: [],
      ownedEvents: [],
    );
  }
}