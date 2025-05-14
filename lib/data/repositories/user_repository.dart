import 'package:flutter_application_1/data/services/auth_service.dart';

import '../models/event.dart';
import '../models/user.dart';
import '../services/user_service.dart';

abstract class UserRepository {
  Future<User> createUser({
    required String id,
    required String name,
    required String email,
  });
  // Is indeed SSOT for the User data because this list of Events pertain to those fields in the User object
  Future<List<Event>> fetchOwnedEvents();
  //Future<List<Event>> fetchParticipatingInEvents();

}

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;
  final AuthService _authService;

  UserRepositoryImpl(this._userService, this._authService);

  @override
  Future<User> createUser({
    required String id,
    required String name,
    required String email,
  }) async {
    return _userService.createUser(id: id, name: name, email: email);
  }

  @override
  Future<List<Event>> fetchOwnedEvents() async {
    final idToken = await _authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }
    return _userService.fetchOwnedEvents(idToken);
  }
}