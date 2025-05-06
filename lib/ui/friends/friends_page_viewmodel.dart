import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../data/Friend Model/User.dart';
import '../../data/repositories/friend_repository.dart';

class FriendsPageViewmodel extends ChangeNotifier{
  List<User>? _users;
  bool _hasLoadedFriends = false;
  final FriendRepository _friendRepository;

  FriendsPageViewmodel({required FriendRepository friendRepository}) 
      : _friendRepository = friendRepository {
        _loadFriends();
      }

  List<User>? get friends => _users;
  bool get hasLoadedFriends => _hasLoadedFriends;

  Future<void> _loadFriends() async{
    if(_hasLoadedFriends) return;
    _hasLoadedFriends = true;
    _users = await _friendRepository.fetchUsers(2);
  }

  void refresh() {
    _hasLoadedFriends = false;
    _loadFriends();
  }
}