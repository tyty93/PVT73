import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/event.dart';

abstract class EventRepository {
  // todo: Fill with general interface
  Future<List<Event>> fetchEvents();
}

// Fake data in memory
/*class EventRepositoryImpl implements EventRepository {
  // todo: call external service. For testing: Mock data source for example "mockito"  on local host
  // todo: later, should call our tomcat server? or handle by our databases?
  @override
  Future<List<Event>> fetchEvents() async {
    List<Event> events = [
      Event(name: 'Event1', description: 'Descr1', dateTime: DateTime.now()),
      Event(name: 'Event2', description: 'Descr2', dateTime: DateTime.now()),
      Event(name: 'Event3', description: 'Descr3', dateTime: DateTime.now()),
      Event(name: 'Event4', description: 'Descr4', dateTime: DateTime.now()),
      Event(name: 'Event5', description: 'Descr5', dateTime: DateTime.now()),
      Event(name: 'Event6', description: 'Descr6', dateTime: DateTime.now()),
      Event(name: 'Event7', description: 'Descr7', dateTime: DateTime.now()),
      Event(name: 'Event8', description: 'Descr8', dateTime: DateTime.now()),
      Event(name: 'Event9', description: 'Descr9', dateTime: DateTime.now()),
      Event(name: 'Event10', description: 'Descr10', dateTime: DateTime.now()),
      Event(name: 'Event11', description: 'Descr11', dateTime: DateTime.now()),
    ];
    return events;
  }
}*/

// Fake data from Mockoon - add unit tests: https://www.youtube.com/watch?v=mxTW020pyuc&list=PLAag5C_MlO4L3wxxV_KzwZ9PtXlfFW5ym&index=2 38:30 ish
class EventRepositoryImpl implements EventRepository {
  @override
  Future<List<Event>> fetchEvents() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:3000/events")
    );

    if(response.statusCode == HttpStatus.ok) {
      final String jsonString = response.body;
      final Map<String, dynamic> decodedJson = jsonDecode(jsonString); // the whole json object
      final List<dynamic> eventsJson = decodedJson['events']; // the key 'events' points to an arry of event objects
      final List<Event> events = [];
      for (Map<String, dynamic> eventJson in eventsJson) {
        events.add(Event.fromJson(eventJson));
      }
      return events;
    } else {
      throw Exception("Temporary error message.");
    }
  }
}