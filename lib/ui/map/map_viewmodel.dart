import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../data/repositories/event_repository.dart';
//import '../../data/models/event.dart';

class MapViewModel extends ChangeNotifier {
  final Location _location = Location();
  final Completer<GoogleMapController> _mapController = Completer();
  final EventRepository eventRepository;

  LatLng? _currentLocation;
  bool _followUser = true;
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

  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
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

  void addMarker(LatLng position) {
    _markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () => _showPlaceInfo(position),
      ),
    );
    notifyListeners();
  }

  void _showPlaceInfo(LatLng position) {
    debugPrint("Custom Pin at ${position.latitude}, ${position.longitude}");
  }


  // To-Do: Change event model/repository to fetch adress, that can be turned into LatLng.
  /*Future<void> _fetchEventMarkers() async {
    try {
      final events = await eventRepository.fetchEvents();
      for (final event in events) {
        _markers.add(
          Marker(
            markerId: MarkerId(event.id.toString()),
            position: LatLng(event.latitude, event.longitude),
            infoWindow: InfoWindow(
              title: event.name,
              snippet: event.description,
            ),
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching events: $e");
    }
  }*/
}