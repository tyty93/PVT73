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
    required String location,
    required DateTime dateTime,
    required int maxAttendees,
    required int cost,
    required String paymentInfo,
    required String idToken,
    String? ownerEmail,
    String? ownerId,
    String? ownerName,


  }) async {

    // Prepare request body with only necessary fields, no ID
    final Map<String, dynamic> eventData = {
      'name': name,
      'description': description,
      'location': location,
      'maxAttendees': maxAttendees,
      'cost': cost,
      'paymentInfo': paymentInfo,    
      'eventDateTime': DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dateTime),

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
    final String jsonString = utf8.decode(response.bodyBytes);
    final List<dynamic> eventsJson = jsonDecode(jsonString);
    final List<Event> events = [];

    for (Map<String, dynamic> eventJson in eventsJson) {
      events.add(Event(
        eventId: eventJson['id'],
        name: eventJson['name'] ?? 'Unnamed Event',
        description: eventJson['description'] ?? 'No description available',
        location: eventJson['location'] ?? 'Unknown Address',
        maxAttendees: eventJson['maxAttendees'] ?? 0,
        cost: eventJson['cost'],
        paymentInfo: eventJson['paymentInfo'],
        dateTime: DateTime.parse(eventJson['eventDateTime']),
        ownerEmail: eventJson['ownerEmail'] ?? 'Unknown Email', 
        ownerId: eventJson['ownerId'] ?? 'Unknown ID',
        ownerName: eventJson['ownerName'] ?? 'Unknown Name',

      ));
    }
    return events;
  } else {
    throw Exception("Failed to fetch events.");
  }
}

  Future<List<Map<String, dynamic>>> fetchFriendsAttendingEvent(int eventId, String idToken) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$eventId/friends'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
    );
    print('Response body: ${response.body}'); 
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch friends attending');
    }
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

    Future<void> editEvent(Event event, String idToken) async{
      final Map<String, dynamic> eventData = {
        'id': event.eventId,
        'name': event.name,
        'description': event.description,
        'location': event.location,
        'maxAttendees': event.maxAttendees,
        'cost': event.cost,
        'paymentInfo': event.paymentInfo,    
        'eventDateTime': DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(event.dateTime)
      };
      
      final response = await _client.patch(
          Uri.parse('$_baseUrl/edit'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $idToken',
          },
          body: jsonEncode(eventData),
      );
      if(response.statusCode == HttpStatus.ok) {
        return;
      } else {
        throw Exception(response.statusCode);
      }
    }
}