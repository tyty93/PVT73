import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/data/Friend%20Model/User.dart';
import 'package:flutter_application_1/data/repositories/friend_repository.dart';

class FriendsSearchPageViewmodel extends ChangeNotifier{
  final FriendRepository _userRepository;
  List<User>? _users;
  bool _hasLoadedStrangers = false;
  
  String search;
  

  FriendsSearchPageViewmodel({required FriendRepository userRepository, this.search = ''}) 
      : _userRepository = userRepository;
  
  List<User>? get users => _users;
  bool get hasLoadedStrangers => _hasLoadedStrangers;

  Future<void> _loadUsers(String search) async{
    if(_hasLoadedStrangers) return;
    _hasLoadedStrangers = true;
    _users = await _userRepository.searchUsers(search);
    notifyListeners();
  }

  void refresh(String search) {
    _hasLoadedStrangers = false;
    _loadUsers(search);
  }
  
}