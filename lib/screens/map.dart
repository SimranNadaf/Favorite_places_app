import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;

  const MapScreen(
      {super.key,
      this.location = const PlaceLocation(
          latitude: 18.516726, longitude: 73.856255, address: ""),
      this.isSelecting = true});


  @override
  State<StatefulWidget> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {

  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick Your Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: widget.isSelecting == false ? null : (location){
          setState(() {
            _pickedLocation = location;
          });
        },
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.location.latitude, widget.location.longitude),
            zoom: 17,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('m1'),
              position: _pickedLocation ??
                  LatLng(widget.location.latitude, widget.location.longitude),
            ),
          }),
    );
  }
}
