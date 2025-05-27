import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:flutter_application_1/data/repositories/event_repository.dart';
import 'package:flutter_application_1/data/repositories/user_repository.dart';
import 'package:flutter_application_1/ui/event/event_page_viewmodel.dart';
import 'package:flutter_application_1/data/models/event.dart';

import 'events_page_viewmodel_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<EventRepository>(as: #MockEventsPageEventRepository),
  MockSpec<UserRepository>(as: #MockEventsPageUserRepository),
])
void main() {
  late MockEventsPageEventRepository mockEventRepository;
  late MockEventsPageUserRepository mockUserRepository;
  late EventsViewmodel viewModel;

  setUp(() {
    mockEventRepository = MockEventsPageEventRepository();
    mockUserRepository = MockEventsPageUserRepository();
    
    when(mockEventRepository.fetchAllEvents())
        .thenAnswer((_) async => []);
    when(mockUserRepository.fetchParticipatingEvents())
        .thenAnswer((_) async => []);

    viewModel = EventsViewmodel(
      eventRepository: mockEventRepository,
      userRepository: mockUserRepository,
    );
  });

  group('EventsViewModel - ', () {
    test(
      "Given ViewModel, When refreshEvents is called, Then availableEvents should be updated",
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

        // Reset the mock to clear the constructor call
        clearInteractions(mockEventRepository);
        when(mockEventRepository.fetchAllEvents())
            .thenAnswer((_) async => mockEvents);

        // Act
        await viewModel.refreshEvents();

        // Assert
        expect(viewModel.hasLoadedEvents, true);
        expect(viewModel.availableEvents, isNotNull);
        expect(viewModel.availableEvents!.length, 2);
        verify(mockEventRepository.fetchAllEvents()).called(1);
      },
    );

    test(
      "Given ViewModel, When events are loaded, Then they should be sorted by date",
      () async {
        // Arrange
        final mockEvents = [
          Event(
            eventId: 2,
            name: "Later Event",
            description: "Description",
            location: "Location",
            maxAttendees: 10,
            cost: 100,
            paymentInfo: "Swish",
            dateTime: DateTime(2025, 5, 5),
            ownerEmail: "test@test.com",
            ownerId: "user1",
            ownerName: "Test User"
          ),
          Event(
            eventId: 1,
            name: "Earlier Event",
            description: "Description",
            location: "Location",
            maxAttendees: 10,
            cost: 100,
            paymentInfo: "Swish",
            dateTime: DateTime(2025, 5, 1),
            ownerEmail: "test@test.com",
            ownerId: "user1",
            ownerName: "Test User"
          ),
        ];

        when(mockEventRepository.fetchAllEvents())
            .thenAnswer((_) async => mockEvents);

        // Act
        await viewModel.refreshEvents();

        // Assert
        expect(viewModel.availableEvents!.first.dateTime
            .isBefore(viewModel.availableEvents!.last.dateTime), true);
      },
    );
  });
}