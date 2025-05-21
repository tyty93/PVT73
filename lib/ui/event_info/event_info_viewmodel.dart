import 'package:flutter/material.dart';

import '../../data/models/event.dart';
import '../../data/models/event_info.dart';
import '../../data/repositories/event_info_repository.dart';
import '../../data/repositories/event_repository.dart';



// todo: handles one event, exposes registerToEvent(event)
class EventInfoViewModel extends ChangeNotifier {
  final EventRepository eventRepository;

  EventInfoViewModel({required this.eventRepository});
  

  Event? _event;
  bool _isLoading = false;
  String? _error;

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
}
