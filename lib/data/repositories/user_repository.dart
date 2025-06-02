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
  Future<List<Event>> fetchParticipatingEvents();
  Future<User> addParticipation(int eventId);
  Future<void> unregisterFromEvent(int eventId);

  Future<List<User>> searchUsers(String query);

  Future<List<User>> fetchFriends();
  Future<List<User>> fetchPending();
  
  Future<String> addFriend(String personId);
  Future<String> removeFriend(String personId);
  Future<String> acceptRequest(String personId);
  Future<String> rejectRequest(String personId);
  Future<String> toggleFavourite(String personId);
  Future<bool> isUserRegistered(int eventId, String userId);
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
    if (idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    return _userService.fetchOwnedEvents(idToken);
  }


  @override
  Future<User> addParticipation(int eventId) async {
    final idToken = await _authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }
    return _userService.addParticipation(eventId, idToken);
  }

  @override
Future<List<Event>> fetchParticipatingEvents() async {
  final idToken = await _authService.getIdToken();
  if (idToken == null) {
    throw Exception('No token available. User might not be authenticated.');
  }

  return _userService.fetchParticipatingEvents(idToken);
}

  @override
  Future<void> unregisterFromEvent(int eventId) async {
    final idToken = await _authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }
    return _userService.removeParticipation(eventId, idToken);
  }

   @override
  Future<List<User>> searchUsers(String query) async{
    final idToken = await _authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return _userService.searchUsers(idToken, query);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<List<User>> fetchFriends() async{
    final idToken = await _authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return _userService.fetchFriends(idToken);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<List<User>> fetchPending() async{
    final idToken = await _authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return _userService.fetchPendingRequests(idToken);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<String> addFriend(String personId) async{
    final idToken = await _authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return _userService.addFriend(idToken, personId);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<String> removeFriend(String personId) async{
    final idToken = await _authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return _userService.removeFriend(idToken, personId);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<String> acceptRequest(String personId) async{
    final idToken = await _authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return _userService.acceptRequest(idToken, personId);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<String> rejectRequest(String personId) async{
    final idToken = await _authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return _userService.rejectRequest(idToken, personId);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<String> toggleFavourite(String personId) async{
    final idToken = await _authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return _userService.toggleFavourite(idToken, personId);
    }
    catch(e){
      rethrow;
    }
  }
  Future<bool> isUserRegistered(int eventId, String userId) async {
    final participations = await _userService.getParticipations();

    return participations.any((p) =>
      p['eventId'] == eventId && p['userId'] == userId);
  }
}