import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_1/data/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/event.dart';

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
  Future<List<Event>> fetchCreatedEvents();
}

class EventRepositoryImpl implements EventRepository {
  final http.Client _client;
  final String _baseUrl = "https://group-3-75.pvt.dsv.su.se/events";
  final AuthService _authService;
  // Optional parameter http client for mock tests
  EventRepositoryImpl(this._authService, [http.Client? client])
      : _client = client ?? http.Client();
  // Currently fetches all events from the event table
  @override
  Future<List<Event>> fetchAllEvents() async {
    final response = await _client.get(
      Uri.parse(_baseUrl),
    );

    if(response.statusCode == HttpStatus.ok) {
      final String jsonString = response.body;
      final List<dynamic> eventsJson = jsonDecode(jsonString);
      final List<Event> events = [];
      for (Map<String, dynamic> eventJson in eventsJson) {
        events.add(Event.fromJson(eventJson));
      }
      return events;
    } else {
      throw Exception("Failed to fetch events.");
    }
  }

  // todo implement
  @override
  Future<List<Event>> fetchCreatedEvents() async {
    List<Event> list = [];
    return list;
  }

  @override
  Future<void> deleteEvent(int eventId) async {
    final response = await _client.delete(
        Uri.parse('$_baseUrl/$eventId')
    );
    if(response.statusCode == HttpStatus.ok) {
      return;
    } else {
      throw Exception('Failed to delete event');
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
    // Prepare request body with only necessary fields, no ID
    final Map<String, dynamic> eventData = {
      'name': name,
      'description': description,
      'theme': theme,
      'location': location,
      'date': DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dateTime),
      'maxAttendees': maxAttendees
    };

    final idToken = await _authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }
    // POST request to create event
    final response = await _client.post(
      // retrieve current user JWT token
      // send to base url endpoint: /events
      Uri.parse(_baseUrl),
      // JSON object being passed
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
      body: jsonEncode(eventData),
    );

    if(response.statusCode == HttpStatus.ok) {
      // Assuming backend response returns the created object
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // Return the Event with the updated eventId (or other fields as needed)
      return Event.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to create event');
    }
  }
}