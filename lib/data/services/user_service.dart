/* Handles user-centric http requests to {server}/users endpoint (UserController)*/
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/event.dart';
import '../models/user.dart';

class UserService {
  final http.Client _client;
  final String _baseUrl = "https://group-3-75.pvt.dsv.su.se/app/users";

  // Optional parameter http client for mock tests
  UserService({http.Client? client}) : _client = client ?? http.Client();

  Future<User> createUser({
    required String id,
    required String name,
    required String email,
  }) async {
    final url = Uri.parse(_baseUrl);

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'name': name,
        'email': email
      }),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Failed to create user");
    }

    final userJson = jsonDecode(response.body);
    return User.fromJson(userJson);
  }

  Future<List<Event>> fetchOwnedEvents(String idToken) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/me/events'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if(response.statusCode == HttpStatus.ok) {
      final String jsonString = response.body;
      final List<dynamic> eventsJson = jsonDecode(jsonString); // List of events owned by current user
      final List<Event> events = [];
      for (Map<String, dynamic> eventJson in eventsJson) {
        events.add(Event.fromJson(eventJson));
      }
      return events;
    } else {
      throw Exception("Failed to fetch events you own.");
    }
  }

  // Returns the updated user
  Future<User> addParticipation(
    int eventId,
    String idToken
  ) async {
    final url = Uri.parse("$_baseUrl/me/participations/$eventId");

    final response = await _client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final userJson = jsonDecode(response.body);
      return User.fromJson(userJson);
    } else {
      throw Exception('Failed to add participation: ${response.statusCode}');
    }
  }

  Future<User> removeParticipation(int eventId, String idToken) async {
    final url = Uri.parse("$_baseUrl/me/participations/$eventId");

    final response = await _client.delete(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final userJson = jsonDecode(response.body);
      return User.fromJson(userJson);
    } else {
      throw Exception('Failed to remove participation: ${response.statusCode}');
    }
  }

}