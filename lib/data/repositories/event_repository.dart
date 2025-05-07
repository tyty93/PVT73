import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/event.dart';

abstract class EventRepository {
  Future<List<Event>> fetchEvents();
  Future<void> deleteEvent(int eventId);
  Future<Event> createEvent({
    required String name,
    required String description,
    required DateTime dateTime,
  });
}

class EventRepositoryImpl implements EventRepository {
  final http.Client client;
  final String baseUrl = "https://group-3-75.pvt.dsv.su.se/events";

  // Optional parameter http client for mock tests
  EventRepositoryImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<List<Event>> fetchEvents() async {
    final response = await client.get(
      Uri.parse(baseUrl),
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

  @override
  Future<void> deleteEvent(int eventId) async {
    final response = await client.delete(
        Uri.parse('$baseUrl/$eventId')
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
    required DateTime dateTime,
  }) async {
    // Prepare request body with only necessary fields, no ID
    final Map<String, dynamic> eventData = {
      'name': name,
      'description': description,
      'date': DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dateTime),
    };

    // POST request to create event
    final response = await client.post(
      // send to base url endpoint: /events
      Uri.parse(baseUrl),
      // JSON object being passed
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
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