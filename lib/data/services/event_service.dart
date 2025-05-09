/* Handles event-centric http requests to {server}/events endpoint (EventController)*/

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/event.dart';

// todo swap from http://10.0.2.2:8080 to SU server at release
class EventService {
  final http.Client _client;
  final String _baseUrl = "http://10.0.2.2:8080/events";

  // Optional parameter http client for mock tests
  EventService({http.Client? client}) : _client = client ?? http.Client();

  Future<Event> createEvent({
    required String name,
    required String description,
    required String theme,
    required String location,
    required DateTime dateTime,
    required int maxAttendees,
    required String idToken,
  }) async {

    // Prepare request body with only necessary fields, no ID
    final Map<String, dynamic> eventData = {
      'name': name,
      'description': description,
      'theme': theme,
      'location': location,
      'maxAttendees': maxAttendees,
      'eventDateTime': DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dateTime)
    };

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
}