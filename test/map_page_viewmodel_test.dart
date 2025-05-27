import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_application_1/ui/map/map_page.dart';
import 'package:flutter_application_1/ui/map/map_viewmodel.dart';

class MockMapViewModel extends Mock implements MapViewModel {
  LatLng? _currentLocation = const LatLng(59.3293, 18.0686);
  bool _followUser = false;
  final Set<Marker> _markers;

  MockMapViewModel() : _markers = {
    Marker(
      markerId: const MarkerId('test_marker'),
      position: const LatLng(59.3293, 18.0686),
      infoWindow: const InfoWindow(title: 'Test Marker'),
    )
  };

  @override
  LatLng? get currentLocation => _currentLocation;
  
  @override
  Set<Marker> get markers => _markers;
  
  @override
  bool get followUser => _followUser;

  void setCurrentLocation(LatLng? location) {
    _currentLocation = location;
  }

  void setFollowUser(bool value) {
    _followUser = value;
  }
}

void main() {
  late MockMapViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockMapViewModel();
  });

  group('MapPage Widget -', () {
    testWidgets(
      'Given MapPage, When currentLocation is null, Then loading indicator is shown',
      (WidgetTester tester) async {
        mockViewModel.setCurrentLocation(null);

        await tester.pumpWidget(
          ChangeNotifierProvider<MapViewModel>.value(
            value: mockViewModel,
            child: const MaterialApp(home: MapPage()),
          ),
        );

        expect(find.text('Loading...'), findsOneWidget);
      },
    );

    testWidgets(
      'Given MapPage, When currentLocation is set, Then GoogleMap and follow button are shown',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider<MapViewModel>.value(
            value: mockViewModel,
            child: const MaterialApp(home: MapPage()),
          ),
        );

        expect(find.byType(GoogleMap), findsOneWidget);
        expect(find.byType(FloatingActionButton), findsOneWidget);
      },
    );

    testWidgets(
      'Given MapPage, When followUser is true, Then FloatingActionButton shows location_on icon',
      (WidgetTester tester) async {
        mockViewModel.setFollowUser(true);

        await tester.pumpWidget(
          ChangeNotifierProvider<MapViewModel>.value(
            value: mockViewModel,
            child: const MaterialApp(home: MapPage()),
          ),
        );

        expect(find.byIcon(Icons.location_on), findsOneWidget);
        expect(find.byIcon(Icons.location_off), findsNothing);
      },
    );

    testWidgets(
      'Given MapPage, When followUser is false, Then FloatingActionButton shows location_off icon',
      (WidgetTester tester) async {
        mockViewModel.setFollowUser(false);

        await tester.pumpWidget(
          ChangeNotifierProvider<MapViewModel>.value(
            value: mockViewModel,
            child: const MaterialApp(home: MapPage()),
          ),
        );

        expect(find.byIcon(Icons.location_off), findsOneWidget);
        expect(find.byIcon(Icons.location_on), findsNothing);
      },
    );

    testWidgets(
      'Given MapPage, When FloatingActionButton is tapped, Then toggleFollowUser is called',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider<MapViewModel>.value(
            value: mockViewModel,
            child: const MaterialApp(home: MapPage()),
          ),
        );

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        verify(mockViewModel.toggleFollowUser()).called(1);
      },
    );

    testWidgets(
      'Given MapPage, When markers are present, Then they are shown on the map',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ChangeNotifierProvider<MapViewModel>.value(
            value: mockViewModel,
            child: const MaterialApp(home: MapPage()),
          ),
        );

        final googleMap = tester.widget<GoogleMap>(find.byType(GoogleMap));
        expect(googleMap.markers, equals(mockViewModel.markers));
        expect(googleMap.markers.length, 1);
      },
    );
  });
}