import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final http.Client client;
  final String baseUrl = "https://group-3-75.pvt.dsv.su.se/users";

  // Optional parameter http client for mock tests
  UserService({http.Client? client}) : client = client ?? http.Client();

  Future<void> createUser({
    required String id,
    required String name,
    required String email,
  }) async {
    final url = Uri.parse(baseUrl);

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'name': name,
        'email': email
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to create user");
    }
  }
}