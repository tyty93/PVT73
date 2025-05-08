import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../Friend Model/stranger.dart';

import 'dart:developer';

abstract class SearchRepository{
  Future<List<Stranger>> searchUsers(int id, String searchString);
}

class SearchRepositoryImpl implements SearchRepository{
  final http.Client client;
  final String baseUrl = "http://10.0.2.2:8080/demo";

  SearchRepositoryImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<List<Stranger>> searchUsers(int id, String searchString) async{
    final response = await client.get( Uri.parse('$baseUrl/search/users?user_id=$id&query=$searchString'));
    if(response.statusCode == HttpStatus.ok){
      final String jsonString = response.body;
      final List<dynamic> strangersJson = jsonDecode(jsonString);
      final List<Stranger> users = [];
      for(Map<String,dynamic> json in strangersJson){
        users.add(Stranger.fromJson(json));
        log('found $json');
      }
      return users;
    }
    else{
      throw Exception("Failed to fetch strangers");
    }
  }
}