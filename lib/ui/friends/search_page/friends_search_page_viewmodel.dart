import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/data/models/user.dart';
import 'package:flutter_application_1/data/repositories/user_repository.dart';

class FriendsSearchPageViewmodel extends ChangeNotifier{
  final UserRepository _userRepository;
  List<User>? _users;
  bool _hasLoadedStrangers = false;
  
  String search;
  

  FriendsSearchPageViewmodel({required UserRepository userRepository, this.search = ''}) 
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