/* Handles user-centric http requests to {server}/users endpoint (UserController)*/
import 'dart:convert';
import 'dart:developer';
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

  Future<List<User>> fetchFriends(String idToken) async{
    final response = await _client.get(
      Uri.parse('$_baseUrl/me/friends'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if(response.statusCode == HttpStatus.ok){
      final String jsonString = response.body;
      final List<dynamic> friendsJson = jsonDecode(jsonString);
      final List<User> friends = [];
      for (Map<String,dynamic> friendJson in friendsJson){
        friends.add(User.relationFromJson(friendJson));
        log(friendJson.toString());
      }
      return friends;
    } else {
      throw Exception("Failed to fetch friends");
    }
  }

  Future<List<User>> fetchPendingRequests(String idToken) async{
    final response = await _client.get(
      Uri.parse('$_baseUrl/me/friends/pending'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if(response.statusCode == HttpStatus.ok){
      final String jsonString = response.body;
      final List<dynamic> friendsJson = jsonDecode(jsonString);
      final List<User> requests = [];
      for (Map<String,dynamic> friendJson in friendsJson){
        requests.add(User.relationFromJson(friendJson));
        log("Pending request$friendJson");
      }
      return requests;
    }
    else{
      throw Exception("Failed to fetch pending requests");
    }
  }

  Future<String> addFriend(String idToken, String personId) async{
    final response = await _client.post(
      Uri.parse('$_baseUrl/friend/add/$personId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }

  Future<String> removeFriend(String idToken, String personId) async{
    final response = await _client.delete(
      Uri.parse('$_baseUrl/friend/remove/$personId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }

  Future<String> acceptRequest(String idToken, String personId) async{
    final response = await _client.post(
      Uri.parse('$_baseUrl/friend/accept/$personId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }

  Future<String> rejectRequest(String idToken, String personId) async{
    final response = await _client.delete(
      Uri.parse('$_baseUrl/friend/reject/$personId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }

  Future<String> toggleFavourite(String idToken, String personId) async{
    final response = await _client.patch(
      Uri.parse('$_baseUrl/friend/favourite/$personId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }

  Future<List<User>> searchUsers(String idToken, String query) async{
    final response = await _client.get(
      Uri.parse('$_baseUrl/search/$query'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );
    if(response.statusCode == HttpStatus.ok){
      final String jsonString = response.body;
      final List<dynamic> usersJson = jsonDecode(jsonString);
      final List<User> friends = [];
      for (Map<String,dynamic> userJson in usersJson){
        friends.add(User.relationFromJson(userJson));
        log(userJson.toString());
      }
      return friends;
    }
    else{
      throw Exception("Request failed");
    }
  }
}