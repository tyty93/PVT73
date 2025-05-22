import 'package:flutter_application_1/data/services/auth_service.dart';
import '../models/event.dart';
import '../services/event_service.dart';
import '../models/user.dart' as U;
import 'package:firebase_auth/firebase_auth.dart';



abstract class EventRepository {
  Future<List<Event>> fetchAllEvents();
  Future<void> deleteEvent(int eventId);
  Future<Event> createEvent({
    required String name,
    required String description,
    required String theme,
    required String location,
    required DateTime dateTime,
    required int maxAttendees
  });
  Future<Event> fetchEventById(int eventId);
  Future<List<U.User>> getFriendsAttending(int eventId);

}

class EventRepositoryImpl implements EventRepository {
  final AuthService _authService;
  final EventService _eventService;

  EventRepositoryImpl(this._authService, this._eventService);

  @override
  Future<List<Event>> fetchAllEvents() async {
    return _eventService.fetchAllEvents();
  }

  @override
  Future<void> deleteEvent(int eventId) async {
    final idToken = await _authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }
    try {
      await _eventService.deleteEvent(eventId, idToken);
    } catch (e) {
      rethrow; // Rethrow the caught exception as is
    }
  }

  @override
  Future<Event> createEvent({
    required String name,
    required String description,
    required String theme,
    required String location,
    required DateTime dateTime,
    required int maxAttendees,
  }) async {

    final idToken = await _authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }

    return await _eventService.createEvent(
      name: name,
      description: description,
      theme: theme,
      location: location,
      dateTime: dateTime,
      maxAttendees: maxAttendees,
      idToken: idToken,
    );
  }

  @override
  Future<Event> fetchEventById(int id) async {
    return await _eventService.fetchEventById(id);
  }
  Future<List<U.User>> getFriendsAttending(int eventId) async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user?.getIdToken();
    if (token == null) throw Exception("User not authenticated");

    final jsonList = await _eventService.fetchFriendsAttendingEvent(eventId, token);
    return jsonList.map((json) => U.User.fromJson(json)).toList();
  }
  
}