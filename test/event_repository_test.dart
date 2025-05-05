import 'dart:io';

import 'package:flutter_application_1/data/models/event.dart';
import 'package:flutter_application_1/data/repositories/event_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'event_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late EventRepository eventRepository;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    eventRepository = EventRepositoryImpl(client: mockHttpClient);
  });

  group("Event repository - ", () {
    group("fetchEvents", () {
      test(
        "Given EventRepository class, when fetchEvents is called and status code is HttpStatus.ok then a Future<List<Event>> should be returned ",
        () async {
          // Stub
          when(
            mockHttpClient.get(
              Uri.parse("https://group-3-75.pvt.dsv.su.se/events/all"),
            ),
          ).thenAnswer(
            (_) async => Response('''
              [
                  {
                    "id":53,
                    "name":"Event 4",
                    "description":"Description of event 1",
                    "date":"2025-05-01T14:00:00"
                  },
                  {
                    "id":54,
                    "name":"Event 4",
                    "description":"Description of event 1",
                    "date":"2025-05-05T14:00:00"
                  }
              ]
              ''',
              HttpStatus.ok,
            ),
          );

          final actual = await eventRepository.fetchEvents();

          expect(actual, isA<List<Event>>());
        },
      );

      test(
        "Given EventRepository class, when fetchEvents is called and status code is NOT HttpStatus.ok then an exception should be thrown",
        () async {
          when(
            mockHttpClient.get(
              Uri.parse("https://group-3-75.pvt.dsv.su.se/events/all"),
            ),
          ).thenAnswer((_) async => Response('Not found', HttpStatus.notFound));

          final actual = eventRepository.fetchEvents();

          expect(actual, throwsException);
        },
      );
    });
    group("deleteEvent", () {
      test("Should successfully delete an existing event", () {

      });
    });
  });
}
