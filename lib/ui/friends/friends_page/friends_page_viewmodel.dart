import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/user.dart';
import 'package:flutter_application_1/data/repositories/user_repository.dart';

class FriendsPageViewmodel extends ChangeNotifier{
  List<User> _pendingRequests = List.empty(growable: true);
  List<User>? _users;
  bool _hasLoadedFriends = false;
  final UserRepository _userRepository;

  FriendsPageViewmodel({required UserRepository userRepository}) 
      : _userRepository = userRepository {
        _loadFriends();
      }

  List<User> get pendingRequests => _pendingRequests;
  List<User>? get users => _users;
  bool get hasLoadedFriends => _hasLoadedFriends;

  Future<void> _loadFriends() async{
    if(_hasLoadedFriends) return;
    _hasLoadedFriends = true;
    _pendingRequests = await _userRepository.fetchPending();
    _users = await _userRepository.fetchFriends();
    notifyListeners();
  }

  void refresh() {
    _hasLoadedFriends = false;
    _loadFriends();
  }

  Future<void> favourite(String uid) async{
    await _userRepository.toggleFavourite(uid);
    refresh();
  }

  Future<void> removeFriend(String uid) async{
    await _userRepository.removeFriend(uid);
    refresh();
  }

  Future<void> addFriend(String uid) async{
    await _userRepository.addFriend(uid);
    refresh();
  }

  Future<void> acceptRequest(String uid) async{
    await _userRepository.acceptRequest(uid);
    refresh();
  }

  Future<void> rejectRequest(String uid) async{
    await _userRepository.rejectRequest(uid);
    refresh();
  }
}