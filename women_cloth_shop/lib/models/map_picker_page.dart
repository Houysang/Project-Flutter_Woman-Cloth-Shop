import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  LatLng selectedLocation = const LatLng(11.5564, 104.9282); // Phnom Penh

  String address = "";

  Future<void> _getAddress(LatLng pos) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);

    final place = placemarks.first;

    setState(() {
      address =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
    });
  }

  void _onConfirm() {
    Navigator.pop(context, {
      "lat": selectedLocation.latitude,
      "lng": selectedLocation.longitude,
      "address": address,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Location"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLocation,
              zoom: 14,
            ),
            onTap: (pos) async {
              setState(() {
                selectedLocation = pos;
              });
              await _getAddress(pos);
            },
            markers: {
              Marker(
                markerId: const MarkerId("selected"),
                position: selectedLocation,
              )
            },
          ),

          // bottom info box
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(blurRadius: 10, color: Colors.black26)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(address.isEmpty
                      ? "Tap on map to select location"
                      : address),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: address.isEmpty ? null : _onConfirm,
                    child: const Text("Confirm Location"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
