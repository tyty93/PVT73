import 'package:flutter_application_1/data/services/auth_service.dart';
import '../models/event.dart';
import '../services/event_service.dart';
import 'package:firebase_auth/firebase_auth.dart';



abstract class EventRepository {
  Future<List<Event>> fetchAllEvents();
  Future<void> deleteEvent(int eventId);
  Future<Event> createEvent({
    required String name,
    required String description,
    required String location,
    required DateTime dateTime,
    required int maxAttendees,
    required int cost,
    required String paymentInfo,
  });
  Future<Event> fetchEventById(int eventId);
  Future<List<String>> getFriendsAttending(int eventId);
  Future<void> editEvent(Event event);

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
      rethrow;
    }
  }

  @override
  Future<Event> createEvent({
    required String name,
    required String description,
    required String location,
    required DateTime dateTime,
    required int maxAttendees,
    required int cost,
    required String paymentInfo,
  }) async {

    final idToken = await _authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }

    return await _eventService.createEvent(
      name: name,
      description: description,
      location: location,
      dateTime: dateTime,
      maxAttendees: maxAttendees,
      cost: cost,
      paymentInfo: paymentInfo,
      idToken: idToken,
    );
  }

  @override
  Future<Event> fetchEventById(int id) async {
    return await _eventService.fetchEventById(id);
  }
  @override
  Future<List<String>> getFriendsAttending(int eventId) async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user?.getIdToken();
    if (token == null) throw Exception("User not authenticated");

    final jsonList = await _eventService.fetchFriendsAttendingEvent(eventId, token);
    return jsonList.map((json) => json['name'] as String).toList();
  }

  @override
  Future<void> editEvent(Event event) async{
    final idToken = await _authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }
    try {
      await _eventService.editEvent(event, idToken);
    } catch (e) {
      rethrow;
    }
  }
  
}