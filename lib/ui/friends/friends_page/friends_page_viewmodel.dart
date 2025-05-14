import 'package:flutter/material.dart';

import '../../../data/Friend Model/User.dart';
import '../../../data/repositories/friend_repository.dart';

class FriendsPageViewmodel extends ChangeNotifier{
  List<User> _pendingRequests = List.empty(growable: true);
  List<User>? _users;
  bool _hasLoadedFriends = false;
  final FriendRepository _userRepository;

  FriendsPageViewmodel({required FriendRepository userRepository}) 
      : _userRepository = userRepository {
        _loadFriends();
      }

  List<User> get pendingRequests => _pendingRequests;
  List<User>? get users => _users;
  bool get hasLoadedFriends => _hasLoadedFriends;

  Future<void> _loadFriends() async{
    if(_hasLoadedFriends) return;
    _hasLoadedFriends = true;
    _pendingRequests = await _userRepository.fetchPendingRequests(2);
    _users = await _userRepository.fetchUsers(2);
    notifyListeners();
  }

  void refresh() {
    _hasLoadedFriends = false;
    _loadFriends();
  }

  Future<void> favourite(int uid) async{
    await _userRepository.toggleFavourite(2, uid);
    refresh();
  }

  Future<void> removeFriend(int uid) async{
    await _userRepository.removeFriend(2, uid);
    refresh();
  }

  Future<void> addFriend(int uid) async{
    await _userRepository.addFriend(2, uid);
    refresh();
  }

  void acceptRequest(int uid){
    _userRepository.acceptRequest(2, uid);
    refresh();
  }
}