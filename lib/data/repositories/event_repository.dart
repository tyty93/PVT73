import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/event.dart';

abstract class EventRepository {
  Future<List<Event>> fetchEvents();

  Future<void> deleteEvent(int eventId);
}

// This implementation currently fetches all events stored in ../demo/events
class EventRepositoryImpl implements EventRepository {
  final http.Client client;

  // Optional parameter http client for mock tests
  EventRepositoryImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<List<Event>> fetchEvents() async {
    final response = await client.get(
        Uri.parse("https://group-3-75.pvt.dsv.su.se/events/all")
    );

    if(response.statusCode == HttpStatus.ok) {
      final String jsonString = response.body;
      final List<dynamic> eventsJson = jsonDecode(jsonString); // Directly decode as a list
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

  }
}