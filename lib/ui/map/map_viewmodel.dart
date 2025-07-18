import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/event_info/event_info_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../data/repositories/event_repository.dart';
//import '../../data/models/event.dart';

class MapViewModel extends ChangeNotifier {
  final Location _location = Location();
  final Completer<GoogleMapController> _mapController = Completer();
  final EventRepository eventRepository;

  LatLng? _currentLocation;
  bool _followUser = false;
  final Set<Marker> _markers = {};

  LatLng? get currentLocation => _currentLocation;
  bool get followUser => _followUser;
  Set<Marker> get markers => _markers;

  bool _initialized = false;

  MapViewModel({required this.eventRepository});

  void init() {
    if (_initialized) return;
    _initialized = true;
    _getLocationUpdates();
  }

  void onMapCreated(GoogleMapController controller, BuildContext context) {
    _mapController.complete(controller);
    _fetchEventMarkers(context); // Nytt, ej testat
  }

  Future<void> _getLocationUpdates() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);

        _markers.removeWhere((m) => m.markerId.value == "userLocation");
        _markers.add(Marker(
          markerId: const MarkerId("userLocation"),
          position: _currentLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          onTap: () => debugPrint("User location tapped"),
        ));

        notifyListeners();

        if (_followUser) {
          _cameraToPosition(_currentLocation!);
        }
      }
    });
  }

  Future<void> _cameraToPosition(LatLng position) async {
    final controller = await _mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: position, zoom: 15),
    ));
  }

  void toggleFollowUser() {
    _followUser = !_followUser;
    notifyListeners();
  }

 Future<void> _fetchEventMarkers(BuildContext context) async {
  const String apiKey = 'AIzaSyCZJdZi3_6p0ivanHol3DqGFuqJ-aSm3_o';

  try {
    final events = await eventRepository.fetchAllEvents();
    debugPrint('Fetched events: ${events.length}'); 
    for (final event in events) {
      final LatLng? position = await getLatLngFromAddress(event.location, apiKey);
      debugPrint('Event: ${event.name}, Address: ${event.location}, LatLng: $position'); 
      if (position != null) {
        _markers.add(
          Marker(
            markerId: MarkerId(event.name.toString()),
            position: position,
            onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, 
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets, 
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center, 
                        children: [
                          Text(
                            event.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            event.description,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity, 
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); 
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventInfoPage(event: event),
                                  ),
                                );
                              },
                              child: const Text('Go to event page'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
            },
          ),
        );
        debugPrint('Marker added for event: ${event.name} at $position'); 
      } else {
        debugPrint('Failed to get LatLng for address: ${event.location}');
      }
    }
    debugPrint('Total markers: ${_markers.length}'); 
    notifyListeners();
  } catch (e) {
    debugPrint("Error fetching events: $e");
  }
}

  Future<LatLng?> getLatLngFromAddress(String address, String apiKey) async {
  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=$apiKey');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == 'OK') {
      final location = data['results'][0]['geometry']['location'];
      return LatLng(location['lat'], location['lng']);
    } else {
      debugPrint('Geocoding failed: ${data['status']}');
    }
  } else {
    debugPrint('HTTP request failed with status: ${response.statusCode}');
  }
  return null;
  }
}