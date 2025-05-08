import 'package:flutter/material.dart';

import '../../data/models/event_info.dart';
import '../../data/repositories/event_info_repository.dart';

class EventInfoViewModel extends ChangeNotifier {
  final EventInfoRepository eventRepository;

  EventInfoViewModel({required this.eventRepository});

  EventInfo? _event;
  bool _isLoading = false;
  String? _error;

  EventInfo? get event => _event;
  bool get isLoading => _isLoading;
  String? get error => _error;

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
