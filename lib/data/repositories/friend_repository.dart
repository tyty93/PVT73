import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/data/services/auth_service.dart';
import 'package:flutter_application_1/data/services/friend_service.dart';
import 'package:http/http.dart' as http;

import '../Friend Model/User.dart';

import 'dart:developer';

abstract class FriendRepository {
  Future<List<User>> fetchFriends();
  Future<List<User>> fetchPending();
  
  Future<String> addFriend(String personId);
  Future<String> removeFriend(String personId);
  Future<String> acceptRequest(String personId);
  Future<String> rejectRequest(String personId);
  Future<String> toggleFavourite(String personId);
  //Friends page
  
  //Future<List<User>> fetchUsers(int id);
  //Future<User> fetchUser(int userId, int personId);

  //Search page
  Future<List<User>> searchUsers(int id, String searchString);

  //Profile info page
  //Future<String> toggleFavourite(int userId, int personId);
  //Future<String> removeFriend(int userId, int personId);
  //Future<String> addFriend(int userId, int personId);
  //Future<String> acceptRequest(int userId, int personId);
  //Future<String> rejectRequest(int userId, int personId);
}

class FriendRepositoryImpl implements FriendRepository {
  final http.Client client;
  final String baseUrl = "http://10.0.2.2:8080/demo";

  final FriendService friendService;
  final AuthService authService;

  FriendRepositoryImpl(this.friendService, this.authService, {
    http.Client? client,
  }) : client = client ?? http.Client();

  /*@override
  Future<List<User>> fetchPendingRequests(int id) async{
    final response = await client.get( Uri.parse('$baseUrl/friends/pending?uid=$id'));

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
  }*/

  /*@override
  Future<List<User>> fetchUsers(int id) async{
    final response = await client.get( Uri.parse('$baseUrl/friend/getFriends?uid=$id'),);

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
  }*/

  /*@override
  Future<User> fetchUser(int userId, int personId) async{
    final response = await client.get(Uri.parse('$baseUrl/ProfileInfo/person?user_id=2&friend_id=$personId'));

    if(response.statusCode == HttpStatus.ok && response.body.toString() != "null"){
      final String json = response.body;
      final dynamic userJson = jsonDecode(json);
      return User.fromJson(userJson);
    }
    throw Exception('Failed to fetch user');
  }*/

 /* @override
  Future<String> toggleFavourite(int userId, int personId) async{
    final response = await http.patch(Uri.parse('$baseUrl/friend/Favourite?user_id=$userId&friend_id=$personId'));

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }*/

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
  
  /*@override
  Future<String> removeFriend(int userId, int personId) async{
    final response = await http.delete(Uri.parse('$baseUrl/friends/remove?user_id=$userId&friend_id=$personId'));

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }*/

  /*@override
  Future<String> addFriend(int userId, int personId) async{
    final response = await http.post(Uri.parse('$baseUrl/friends/add?user_id=$userId&friend_id=$personId'));

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }*/

  /*@override
  Future<String> acceptRequest(int userId, int personId) async{
    final response = await http.post(Uri.parse('$baseUrl/friends/accept?user_id=$userId&friend_id=$personId'));

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }

  @override
  Future<String> rejectRequest(int userId, int personId) async{
    final response = await http.delete(Uri.parse('$baseUrl/friends/reject?user_id=$userId&friend_id=$personId'));

    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    else{
      throw Exception("Request failed");
    }
  }*/
  
  
  @override
  Future<List<User>> fetchFriends() async{
    final idToken = await authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return friendService.fetchFriends(idToken);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<List<User>> fetchPending() async{
    final idToken = await authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return friendService.fetchPendingRequests(idToken);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<String> addFriend(String personId) async{
    final idToken = await authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return friendService.addFriend(idToken, personId);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<String> removeFriend(String personId) async{
    final idToken = await authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return friendService.removeFriend(idToken, personId);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<String> acceptRequest(String personId) async{
    final idToken = await authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return friendService.acceptRequest(idToken, personId);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<String> rejectRequest(String personId) async{
    final idToken = await authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return friendService.rejectRequest(idToken, personId);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<String> toggleFavourite(String personId) async{
    final idToken = await authService.getIdToken();
    if(idToken == null){
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return friendService.toggleFavourite(idToken, personId);
    }
    catch(e){
      rethrow;
    }
  }
}