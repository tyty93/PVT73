import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:flutter_application_1/data/repositories/event_repository.dart';
import 'package:flutter_application_1/data/services/event_service.dart';
import 'package:flutter_application_1/data/services/auth_service.dart';
import 'package:flutter_application_1/data/models/event.dart';

import 'event_repository_test.mocks.dart';

@GenerateMocks([EventService, AuthService])
void main() {
  late EventRepository eventRepository;
  late MockEventService mockEventService;
  late MockAuthService mockAuthService;

  setUp(() {
    mockEventService = MockEventService();
    mockAuthService = MockAuthService();
    eventRepository = EventRepositoryImpl(mockAuthService, mockEventService);
  });

  group('EventRepository -', () {
    group('fetchAllEvents', () {
      test(
        'Given EventRepository, When fetchAllEvents is called, Then return List<Event>',
        () async {
          // Arrange
          final mockEvents = [
            Event(
              eventId: 1,
              name: "Test Event 1",
              description: "Description 1",
              location: "Location 1",
              maxAttendees: 10,
              cost: 100,
              paymentInfo: "Swish to 1234567890",
              dateTime: DateTime(2025, 5, 1, 14),
              ownerEmail: "test1@test.com",
              ownerId: "user1",
              ownerName: "Test User 1"
            ),
            Event(
              eventId: 2,
              name: "Test Event 2",
              description: "Description 2",
              location: "Location 2",
              maxAttendees: 20,
              cost: 200,
              paymentInfo: "Swish to 0987654321",
              dateTime: DateTime(2025, 5, 5, 14),
              ownerEmail: "test2@test.com",
              ownerId: "user2",
              ownerName: "Test User 2"
            ),
          ];

          when(mockEventService.fetchAllEvents())
              .thenAnswer((_) async => mockEvents);

          // Act
          final result = await eventRepository.fetchAllEvents();

          // Assert
          expect(result, isA<List<Event>>());
          expect(result.length, 2);
          verify(mockEventService.fetchAllEvents()).called(1);
        },
      );
    });

    group('createEvent', () {
      test(
        'Given authenticated user, When createEvent is called, Then return created Event',
        () async {
          // Arrange
          const testToken = 'test_token';
          final testEvent = Event(
            eventId: 1,
            name: "New Event",
            description: "New Description",
            location: "New Location",
            maxAttendees: 15,
            cost: 150,
            paymentInfo: "Swish to 1234567890",
            dateTime: DateTime(2025, 6, 1, 14),
            ownerEmail: "creator@test.com",
            ownerId: "creator1",
            ownerName: "Event Creator"
          );

          when(mockAuthService.getIdToken()).thenAnswer((_) async => testToken);
          when(mockEventService.createEvent(
            name: anyNamed('name'),
            description: anyNamed('description'),
            location: anyNamed('location'),
            dateTime: anyNamed('dateTime'),
            maxAttendees: anyNamed('maxAttendees'),
            cost: anyNamed('cost'),
            paymentInfo: anyNamed('paymentInfo'),
            idToken: testToken,
            ownerEmail: anyNamed('ownerEmail'),
            ownerId: anyNamed('ownerId'),
            ownerName: anyNamed('ownerName'),
          )).thenAnswer((_) async => testEvent);

          // Act
          final result = await eventRepository.createEvent(
            name: "New Event",
            description: "New Description",
            location: "New Location",
            dateTime: DateTime(2025, 6, 1, 14),
            maxAttendees: 15,
            cost: 150,
            paymentInfo: "Swish to 1234567890"
          );

          // Assert
          expect(result, isA<Event>());
          verify(mockAuthService.getIdToken()).called(1);
          verify(mockEventService.createEvent(
            name: "New Event",
            description: "New Description",
            location: "New Location",
            dateTime: DateTime(2025, 6, 1, 14),
            maxAttendees: 15,
            cost: 150,
            paymentInfo: "Swish to 1234567890",
            idToken: testToken,
            ownerEmail: null,
            ownerId: null,
            ownerName: null
          )).called(1);
        },
      );
    });
  });
}