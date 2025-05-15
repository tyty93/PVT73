import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/data/services/auth_service.dart';
import 'package:flutter_application_1/data/services/friend_service.dart';
import 'package:http/http.dart' as http;

import '../Friend Model/User.dart';

import 'dart:developer';

abstract class FriendRepository {
  Future<List<User>> searchUsers(String query);

  Future<List<User>> fetchFriends();
  Future<List<User>> fetchPending();
  
  Future<String> addFriend(String personId);
  Future<String> removeFriend(String personId);
  Future<String> acceptRequest(String personId);
  Future<String> rejectRequest(String personId);
  Future<String> toggleFavourite(String personId);
}

class FriendRepositoryImpl implements FriendRepository {
  final FriendService friendService;
  final AuthService authService;

  FriendRepositoryImpl(this.friendService, this.authService);

  @override
  Future<List<User>> searchUsers(String query) async{
    final idToken = await authService.getIdToken();
    if (idToken == null) {
      throw Exception('No token available. User might not be authenticated.');
    }
    try{
      return friendService.searchUsers(idToken, query);
    }
    catch(e){
      rethrow;
    }
  }

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