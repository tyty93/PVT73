import 'package:flutter/material.dart';

import '../../data/models/event.dart';
import '../../data/models/event_info.dart';
import '../../data/repositories/event_info_repository.dart';
import '../../data/repositories/event_repository.dart';
import '../../data/models/user.dart';




// todo: handles one event, exposes registerToEvent(event)
class EventInfoViewModel extends ChangeNotifier {
  final EventRepository eventRepository;

  EventInfoViewModel({required this.eventRepository});
  

  Event? _event;
  bool _isLoading = false;
  String? _error;
  List<String> _friendsAttending = [];
  bool _isFriendsLoading = false;
  String? _friendsError;

  bool get isFriendsLoading => _isFriendsLoading;
  String? get friendsError => _friendsError;
  List<String> get friendsAttending => _friendsAttending;
  Event? get event => _event;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Might be useful to have this, but then use regular eventRepository
  Future<void> loadEventInfo(int eventId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _event = await eventRepository.fetchEventById(eventId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
Future<void> loadFriendsAttending(int eventId) async {
  _isFriendsLoading = true;
  notifyListeners();

  try {
    final friends = await eventRepository.getFriendsAttending(eventId);
    _friendsAttending = friends;
    _friendsError = null;
  } catch (e, stack) {

    _friendsError = e.toString();
    _friendsAttending = [];
  } finally {
    _isFriendsLoading = false;
    notifyListeners();
  }
}
  
}
