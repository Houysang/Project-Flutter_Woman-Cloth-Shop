import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

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

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);
  static const Color backgroundColor = Color(0xFFF9F7F2);

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: darkText),
        title: Text(
          'Pick Location',
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
      ),
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    address.isEmpty ? Icons.touch_app : Icons.location_on,
                    color: accent,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address.isEmpty ? "Tap map to select location" : address,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: darkText,
                    ),
                  ),
                  if (address.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      "$city, $country",
                      style: GoogleFonts.comfortaa(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _confirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "CONFIRM LOCATION",
                        style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
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
