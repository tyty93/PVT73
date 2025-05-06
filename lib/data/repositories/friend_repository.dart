import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Friend Model/User.dart';

import 'dart:developer';

abstract class FriendRepository {
  Future<List<User>> fetchUsers(int id);

}

class FriendRepositoryImpl implements FriendRepository {
  final http.Client client;
  final String baseUrl = "http://10.0.2.2:8080/demo/friend";

  FriendRepositoryImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<List<User>> fetchUsers(int id) async{
    final response = await client.get( Uri.parse('$baseUrl/getFriends?uid=2'),);

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




}