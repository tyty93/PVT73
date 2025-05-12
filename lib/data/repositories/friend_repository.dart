import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Friend Model/User.dart';

import 'dart:developer';

abstract class FriendRepository {
  Future<List<User>> fetchUsers(int id);
  Future<User> fetchUser(int userId, int personId);
  Future<List<User>> searchUsers(int id, String searchString);
  Future<void> toggleFavourite(int userId, int personId);
  Future<void> removeFriend(int userId, int personId);
  Future<void> addFriend(int userId, int personId);
}

class FriendRepositoryImpl implements FriendRepository {
  final http.Client client;
  final String baseUrl = "http://10.0.2.2:8080/demo";

  FriendRepositoryImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<List<User>> fetchUsers(int id) async{
    final response = await client.get( Uri.parse('$baseUrl/friend/getFriends?uid=2'),);

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

  @override
  Future<User> fetchUser(int userId, int personId) async{
    final response = await client.get(Uri.parse('$baseUrl/ProfileInfo/person?user_id=2&friend_id=$personId'));

    if(response.statusCode == HttpStatus.ok && response.body.toString() != "null"){
      final String json = response.body;
      final dynamic userJson = jsonDecode(json);
      return User.fromJson(userJson);
    }
    throw Exception('Failed to fetch user');
  }

  @override
  Future<String> toggleFavourite(int userId, int personId) async{
    final response = await http.patch(Uri.parse('$baseUrl/friend/Favourite?user_id=$userId&friend_id=$personId'));

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }

  @override
  Future<List<User>> searchUsers(int id, String searchString) async{
    final response = await client.get( Uri.parse('$baseUrl/search/users?user_id=$id&query=$searchString'));
    if(response.statusCode == HttpStatus.ok){
      final String jsonString = response.body;
      final List<dynamic> strangersJson = jsonDecode(jsonString);
      final List<User> users = [];
      for(Map<String,dynamic> json in strangersJson){
        users.add(User.fromJson(json));
        log('found $json');
      }
      return users;
    }
    else{
      throw Exception("Failed to fetch strangers");
    }
  }
  
  @override
  Future<String> removeFriend(int userId, int personId) async{
    final response = await http.delete(Uri.parse('$baseUrl/friends/remove?user_id=$userId&friend_id=$personId'));

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }

  @override
  Future<String> addFriend(int userId, int personId) async{
    final response = await http.post(Uri.parse('$baseUrl/friends/add?user_id=$userId&friend_id=$personId'));

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }
}