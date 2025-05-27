import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/event.dart';
import '../../data/repositories/event_repository.dart';
import '../../data/repositories/user_repository.dart';

class EventInfoViewModel extends ChangeNotifier {
  final EventRepository eventRepository;
  final UserRepository userRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  EventInfoViewModel({
    required this.eventRepository,
    required this.userRepository,
  });

  Event? _event;
  bool _isLoading = false;
  String? _error;

  List<String> _friendsAttending = [];
  bool _isFriendsLoading = false;
  String? _friendsError;

  bool _isRegistered = false;

  // Getters
  bool get isRegistered => _isRegistered;
  bool get isFriendsLoading => _isFriendsLoading;
  String? get friendsError => _friendsError;
  List<String> get friendsAttending => _friendsAttending;
  Event? get event => _event;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Event loading
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

  // Friends attending
  Future<void> loadFriendsAttending(int eventId) async {
    _isFriendsLoading = true;
    notifyListeners();

    try {
      final friends = await eventRepository.getFriendsAttending(eventId);
      _friendsAttending = friends;
      _friendsError = null;
    } catch (e) {
      _friendsError = e.toString();
      _friendsAttending = [];
    } finally {
      _isFriendsLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkIfRegistered(int eventId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    _isRegistered = await userRepository.isUserRegistered(eventId, userId);
    notifyListeners();
  }

  Future<void> registerToEvent(int eventId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await userRepository.addParticipation(eventId);
    _isRegistered = true;
    notifyListeners();
  }

  Future<void> unregisterFromEvent(int eventId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await userRepository.unregisterFromEvent(eventId);
    _isRegistered = false;
    notifyListeners();
  }
}