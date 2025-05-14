/* Handles event-centric http requests to {server}/events endpoint (EventController)*/

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/event.dart';

// http://10.0.2.2:8080 for testing
// https://group-3-75.pvt.dsv.su.se for production
class EventService {
  final http.Client _client;
  final String _baseUrl = "https://group-3-75.pvt.dsv.su.se/app/events";

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

  Future<void> deleteEvent(int eventId, String idToken) async {
    print('$_baseUrl/$eventId');
    final response = await _client.delete(
        Uri.parse('$_baseUrl/$eventId'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $idToken',
        }
    );
    if(response.statusCode == HttpStatus.ok) {
      return;
    } else {
      throw Exception('Failed to delete event with eventId: $eventId');
    }
  }

  // Ändrat om i detta för att location ska sparas med rätt encoding. ÅÄÖ funkar ej annars, vilket gör att geocoding inte kan hitta rätt koordinater.
  Future<List<Event>> fetchAllEvents() async {
  final response = await _client.get(
    Uri.parse(_baseUrl),
  );

  if (response.statusCode == HttpStatus.ok) {
    final String jsonString = response.body;
    final List<dynamic> eventsJson = jsonDecode(jsonString);
    final List<Event> events = [];

    for (Map<String, dynamic> eventJson in eventsJson) {
      // Normalize the location field
      final normalizedLocation = _normalizeAddress(eventJson['location']);

      events.add(Event(
        eventId: eventJson['id'],
        name: eventJson['name'] ?? 'Unnamed Event',
        description: eventJson['description'] ?? 'No description available',
        theme: eventJson['theme'] ?? '',
        location: normalizedLocation,
        maxAttendees: eventJson['maxAttendees'] ?? 0,
        dateTime: DateTime.parse(eventJson['eventDateTime']),
      ));
    }
    return events;
  } else {
    throw Exception("Failed to fetch events.");
  }
}

  String _normalizeAddress(String? address) {
    if (address == null || address.isEmpty) {
      return 'Unknown Address';
    }

    // Decode and re-encode the address to ensure proper UTF-8 handling
    final decodedAddress = utf8.decode(address.runes.toList());
    return decodedAddress;
  }


  // todo fix:
  Future<Event> fetchEventById(int id) async {
    /*final response = await _client.get(Uri.parse($baseUrl"/"$id));

    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return EventInfo.fromJson(jsonMap);
    } else {
      throw Exception("Failed to fetch event details.");
    }*/
    throw UnimplementedError('fetchEventById is not implemented yet.');  }
}