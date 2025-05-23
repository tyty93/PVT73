


// todo commented out because no need to fetch event by id, we can pass the data directly from the home page
// todo othewise, can just use EventRepository which already is the Single Source of Truth for all event-related data
/*abstract class EventInfoRepository {
  Future<EventInfo> fetchEventById(int id);
}

class EventInfoRepositoryImpl implements EventInfoRepository {
  final http.Client client;

  EventInfoRepositoryImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<EventInfo> fetchEventById(int id) async {
    final response = await client.get(Uri.parse("https://group-3-75.pvt.dsv.su.se/events/$id"));

    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return EventInfo.fromJson(jsonMap);
    } else {
      throw Exception("Failed to fetch event details.");
    }
  }
}*/
