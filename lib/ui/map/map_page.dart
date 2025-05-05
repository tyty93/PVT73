import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'map_viewmodel.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MapViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.currentLocation == null) {
            viewModel.init(); // lazy init
            return const Center(child: Text("Loading..."));
          }

          return Stack(
            children: [
              GoogleMap(
                onMapCreated: viewModel.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: viewModel.currentLocation!,
                  zoom: 15,
                ),
                markers: viewModel.markers,
                onLongPress: viewModel.addMarker,
              ),
              Positioned(
                top: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: viewModel.toggleFollowUser,
                  child: Icon(viewModel.followUser ? Icons.location_on : Icons.location_off),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}