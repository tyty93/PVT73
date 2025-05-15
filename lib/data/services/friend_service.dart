import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Friend Model/User.dart';
import 'dart:developer';

class FriendService {
  final http.Client client;
  final String baseUrl = "https://group-3-75.pvt.dsv.su.se/app/users";

  FriendService({http.Client? client}) : client = client ?? http.Client();

  Future<List<User>> fetchFriends(String idToken) async{
    final response = await client.get(
      Uri.parse('$baseUrl/me/friends'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if(response.statusCode == HttpStatus.ok){
      final String jsonString = response.body;
      final List<dynamic> friendsJson = jsonDecode(jsonString);
      final List<User> friends = [];
      for (Map<String,dynamic> friendJson in friendsJson){
        friends.add(User.fromJson(friendJson));
        log(friendJson.toString());
      }
      return friends;
    } else {
      throw Exception("Failed to fetch friends");
    }
  }

  Future<List<User>> fetchPendingRequests(String idToken) async{
    final response = await client.get(
      Uri.parse('$baseUrl/me/friends/pending'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );

    if(response.statusCode == HttpStatus.ok){
      final String jsonString = response.body;
      final List<dynamic> friendsJson = jsonDecode(jsonString);
      final List<User> requests = [];
      for (Map<String,dynamic> friendJson in friendsJson){
        requests.add(User.fromJson(friendJson));
        log("Pending request$friendJson");
      }
      return requests;
    }
    else{
      throw Exception("Failed to fetch pending requests");
    }
  }

  Future<String> addFriend(String idToken, String personId) async{
    final response = await client.post(
      Uri.parse('$baseUrl/friend/add/$personId'),
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
    final response = await client.delete(
      Uri.parse('$baseUrl/friend/remove/$personId'),
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
    final response = await client.post(
      Uri.parse('$baseUrl/friend/accept/$personId'),
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
    final response = await client.delete(
      Uri.parse('$baseUrl/friend/reject/$personId'),
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
    final response = await client.patch(
      Uri.parse('$baseUrl/friend/favourite/$personId'),
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
    final response = await client.get(
      Uri.parse('$baseUrl/search/$query'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      },
    );
    if(response.statusCode == HttpStatus.ok){
      final String jsonString = response.body;
      final List<dynamic> usersJson = jsonDecode(jsonString);
      final List<User> friends = [];
      for (Map<String,dynamic> userJson in usersJson){
        friends.add(User.fromJson(userJson));
        log(userJson.toString());
      }
      return friends;
    }
    else{
      throw Exception("Request failed");
    }
  }
}