
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../data/models/event.dart';
import '../../data/repositories/event_repository.dart';

class EventsViewmodel extends ChangeNotifier {
  List<Event>? _events;
  bool _hasLoadedEvents = false;
  final EventRepository _eventRepository;

  // todo: check if better to expose loadEvents and not call it in constructor
  EventsViewmodel({required EventRepository eventRepository}) :
        _eventRepository = eventRepository {
    _loadEvents(); // initialize list
  }

  List<Event>? get events => _events;
  bool get hasLoadedEvents => _hasLoadedEvents;

  // todo: catch exceptions thrown from repository
  Future<void> _loadEvents() async {
    if (_hasLoadedEvents) return;
    _hasLoadedEvents = true;
    _events = await _eventRepository.fetchEvents();
    _events?.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // Events sorted by date by default
    notifyListeners();
  }

  // Can be used to re-fetch data. For example triggered by onTaps or pull-down-to-refresh or polling.
  void refreshEvents() {
    _hasLoadedEvents = false;
    _loadEvents();
  }

  Future<void> deleteEvent(Event event) async {
    // find the event in the list, based on equality of its id compared to argument events id
    final removedEvent = events?.firstWhereOrNull((e) => e.eventId == event.eventId);

    // safety guard, return if nothing to remove
    if (removedEvent == null) return;

    // optimistic removal locally to update listviews quickly
    events?.remove(removedEvent);
    notifyListeners();

    try {
      // attempt removal by id in backend
      await _eventRepository.deleteEvent(event.eventId);
    } catch (e) {
      // if remote removal failed, re-add the removed event to local list
      events?.add(removedEvent);
      notifyListeners();
      throw Exception('Failed to delete event: $e');
    }
  }

  // todo: pass the userId along with the event data.
  // todo (on the backend): look up the User from the DB using that ID, and set it on the Event before saving.
  // idea: inject AuthService in to Event viewmodel. Extract user id.
  Future<void> createEvent({
    required String name,
    required String description,
    required DateTime dateTime,
  }) async {
    try {
      // create event on backend and receive the created event (with ID)
      final createdEvent = await _eventRepository.createEvent(
        name: name,
        description: description,
        dateTime: dateTime,
      );

      // add only the confirmed event from backend
      _events ??= []; // if events is null, ensure its at least an empty list
      _events!.add(createdEvent);
      _events!.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add event: $e');
    }
  }
}
