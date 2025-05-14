/*import 'package:flutter_application_1/data/repositories/event_repository.dart';
import 'package:flutter_application_1/ui/event/event_page_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockEventRepository extends Mock implements UserRepository {}

void main() {
  late MockEventRepository mockEventRepository;
  late EventsViewmodel viewModel;

  setUp(() {
    mockEventRepository = MockEventRepository();
    viewModel = EventsViewmodel(eventRepository: mockEventRepository);
  });

  group('ViewModel construction - ', () {
    test(
      "Given ViewModel class, When instantiated, Then hasLoadedEvents should be false",
          () {
        final bool expected = false;
        final bool actual = viewModel.hasLoadedEvents;

        expect(actual, expected);
      },
    );
  });
}*/
