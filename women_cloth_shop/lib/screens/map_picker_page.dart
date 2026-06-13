import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  LatLng selected = const LatLng(11.5564, 104.9282);

  String address = "";
  String city = "Phnom Penh";
  String country = "Cambodia";

  void _confirm() {
    Navigator.pop(context, {
      "address": address,
      "city": city,
      "country": country,
      "lat": selected.latitude,
      "lng": selected.longitude,
    });
  }

  /// Returns a clean area/neighborhood name and the city.
  /// Returns (streetArea, city).
  (String, String) _getLocationDetails(LatLng point) {
    final lat = point.latitude;
    final lng = point.longitude;

    if (lat > 11.58 && lng > 104.88) {
      return ("Toul Kork", "Phnom Penh");
    } else if (lat > 11.565 && lng > 104.9) {
      return ("Boeung Keng Kang (BKK)", "Phnom Penh");
    } else if (lat > 11.55 && lng > 104.92) {
      return ("Daun Penh", "Phnom Penh");
    } else if (lat > 11.54) {
      return ("7 Makara", "Phnom Penh");
    } else if (lat > 11.52) {
      return ("Chamkar Mon", "Phnom Penh");
    } else if (lat > 11.48) {
      return ("Mean Chey", "Phnom Penh");
    } else {
      return ("Phnom Penh", "Phnom Penh");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Location")),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: selected,
              initialZoom: 13,
              onTap: (tapPosition, point) {
                setState(() {
                  selected = point;

                  // ✅ SMART LOCAL AREA DETECTION
                  final (area, cityName) = _getLocationDetails(point);
                  address = area;
                  city = cityName;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png",
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: selected,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                  BoxShadow(color: Colors.black26, blurRadius: 10),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    address.isEmpty ? "Tap map to select location" : address,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _confirm,
                    child: const Text("Confirm Location"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
