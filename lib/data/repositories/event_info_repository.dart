import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/event_info.dart';

abstract class EventInfoRepository {
  Future<EventInfo> fetchEventById(int id);
}

class EventInfoRepositoryImpl implements EventInfoRepository {
  final http.Client client;

  EventInfoRepositoryImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<EventInfo> fetchEventById(int id) async {
    final response = await client.get(Uri.parse("https://group-3-75.pvt.dsv.su.se/events/$id"));

    if (response.statusCode == HttpStatus.ok) {
      print("getting eventinfo worked");
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      print(jsonMap);
      return EventInfo.fromJson(jsonMap);
    } else {
      print("getting eventinfo failed");
      throw Exception("Failed to fetch event details.");
    }
  }
}
