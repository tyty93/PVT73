
/*class UserInfoViewmodel extends ChangeNotifier{
  User? _user;
  int userId;
  bool _hasLoadedUser = false;
  final FriendRepository _userRepository;

  UserInfoViewmodel({required FriendRepository friendRepository, required this.userId}) 
      : _userRepository = friendRepository{
        _loadUser(userId);
      }

  User? get user => _user;
  bool get hasLoadedFriends => _hasLoadedUser;

  Future<void> _loadUser(int uid) async{
    if(_hasLoadedUser) return;
    _hasLoadedUser = true;
    _user = await _userRepository.fetchUser(2, uid);
    notifyListeners();
  }

  void refresh(int uid) {
    _hasLoadedUser = false;
    _loadUser(uid);
  }

  void favourite(int uid){
    _userRepository.toggleFavourite(2, uid);
  }

  void removeFriend(int uid){
    _userRepository.removeFriend(2, uid);
  }

  void addFriend(int uid){
    _userRepository.addFriend(2, uid);
  }

  void acceptRequest(int uid){
    _userRepository.acceptRequest(2, uid);
  }

  void rejectRequest(int uid){
    _userRepository.rejectRequest(2, uid);
  }
}*/