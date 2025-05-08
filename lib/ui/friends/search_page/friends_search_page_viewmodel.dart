import 'package:flutter/widgets.dart';

import '../../../data/Friend Model/stranger.dart';
import 'package:flutter_application_1/data/repositories/search_repository.dart';

class FriendsSearchPageViewmodel extends ChangeNotifier{
  List<Stranger>? _users;
  bool _hasLoadedStrangers = false;
  String search;
  final SearchRepository _searchRepository;

  FriendsSearchPageViewmodel({required SearchRepository searchRepository, this.search = ''}) 
      : _searchRepository = searchRepository {
        _loadUsers(search);
      }
  
  List<Stranger>? get users => _users;
  bool get hasLoadedStrangers => _hasLoadedStrangers;

  Future<void> _loadUsers(String search) async{
    if(_hasLoadedStrangers) return;
    _hasLoadedStrangers = true;
    _users = await _searchRepository.searchUsers(2, search);
    notifyListeners();
  }

  void refresh(String search) {
    _hasLoadedStrangers = false;
    _loadUsers(search);
  }
  
}