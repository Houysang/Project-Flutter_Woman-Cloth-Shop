// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();
//   final TextEditingController _searchController = TextEditingController();
//   int _selectedBottomIndex = 1;

//   final LatLng _initialCenter = const LatLng(40.7624, -73.9738);

//   final List<Boutique> _boutiques = [
//     Boutique(
//       name: 'OnlyWomen Flagship — 5th Avenue',
//       address: '572 5th Ave, New York, NY 10019',
//       subtitle: 'Open until 8:00 PM',
//       phone: '(212) 555-0216',
//       position: const LatLng(40.7625, -73.9750),
//       badgeText: 'Flagship',
//       accentColor: const Color(0xFFB67D40),
//     ),
//     Boutique(
//       name: 'Soho Concept Atelier',
//       address: '116 Greene St, New York, NY 10012',
//       subtitle: 'Open until 7:30 PM',
//       phone: '(212) 555-0321',
//       position: const LatLng(40.7240, -74.0007),
//       badgeText: 'Atelier',
//       accentColor: const Color(0xFF8B7560),
//     ),
//   ];

//   Set<Marker> get _markers => _boutiques
//       .map(
//         (boutique) => Marker(
//           markerId: MarkerId(boutique.name),
//           position: boutique.position,
//           infoWindow: InfoWindow(
//             title: boutique.name,
//             snippet: boutique.address,
//           ),
//         ),
//       )
//       .toSet();

//   Future<void> _moveToLocation(LatLng position) async {
//     final controller = await _mapController.future;
//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: position, zoom: 15.0),
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController.complete(controller);
//   }

//   void _onBottomNavigationTap(int index) {
//     setState(() {
//       _selectedBottomIndex = index;
//     });
//   }

//   Widget _buildSearchCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.12),
//             blurRadius: 18,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               hintText: 'Enter zip code or city...',
//               prefixIcon: const Icon(Icons.search, color: Color(0xFF5D4E37)),
//               filled: true,
//               fillColor: const Color(0xFFF7F0E4),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(18),
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             width: double.infinity,
//             height: 48,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF5D4E37),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//               onPressed: () {
//                 if (_boutiques.isNotEmpty) {
//                   _moveToLocation(_boutiques.first.position);
//                 }
//               },
//               child: const Text(
//                 'FIND BOUTIQUES',
//                 style: TextStyle(letterSpacing: 1.1),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBoutiqueCard(Boutique boutique) {
//     return GestureDetector(
//       onTap: () => _moveToLocation(boutique.position),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 18),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 18,
//               offset: const Offset(0, 8),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(24),
//               ),
//               child: Container(
//                 height: 170,
//                 width: double.infinity,
//                 color: boutique.accentColor.withOpacity(0.16),
//                 child: Center(
//                   child: Text(
//                     boutique.badgeText,
//                     style: TextStyle(
//                       color: boutique.accentColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     boutique.name,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF1D1B18),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     boutique.address,
//                     style: const TextStyle(
//                       color: Color(0xFF7C7569),
//                       fontSize: 13,
//                     ),
//                   ),
//                   const SizedBox(height: 14),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.access_time,
//                         color: Color(0xFF9F8E7F),
//                         size: 18,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         boutique.subtitle,
//                         style: const TextStyle(
//                           color: Color(0xFF9F8E7F),
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.phone,
//                         color: Color(0xFF9F8E7F),
//                         size: 18,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         boutique.phone,
//                         style: const TextStyle(
//                           color: Color(0xFF9F8E7F),
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF5D4E37),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                           ),
//                           onPressed: () {},
//                           child: const Text('BOOK A FITTING'),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             foregroundColor: const Color(0xFF5D4E37),
//                             side: const BorderSide(color: Color(0xFF5D4E37)),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                           ),
//                           onPressed: () {},
//                           child: const Text('GET DIRECTIONS'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F0E2),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF5F5DC),
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'OnlyWomen Map',
//           style: TextStyle(
//             color: Color(0xFF5D4E37),
//             fontSize: 20,
//             fontFamily: 'Times New Roman',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.menu, color: Color(0xFF5D4E37)),
//           onPressed: () {},
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.lock_outline, color: Color(0xFF5D4E37)),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 6,
//             child: Stack(
//               children: [
//                 GoogleMap(
//                   onMapCreated: _onMapCreated,
//                   initialCameraPosition: CameraPosition(
//                     target: _initialCenter,
//                     zoom: 13.2,
//                   ),
//                   markers: _markers,
//                   myLocationEnabled: false,
//                   zoomControlsEnabled: false,
//                   mapToolbarEnabled: false,
//                 ),
//                 Positioned(
//                   top: 16,
//                   left: 16,
//                   right: 16,
//                   child: _buildSearchCard(),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(32),
//                   topRight: Radius.circular(32),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 18,
//                   vertical: 20,
//                 ),
//                 child: ListView(
//                   children: [
//                     Row(
//                       children: const [
//                         Text(
//                           'Boutiques',
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           'New York',
//                           style: TextStyle(
//                             color: Color(0xFF9F8E7F),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     ..._boutiques.map(_buildBoutiqueCard),
//                     const SizedBox(height: 8),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedBottomIndex,
//         onTap: _onBottomNavigationTap,
//         selectedItemColor: const Color(0xFF5D4E37),
//         unselectedItemColor: Colors.black54,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: 'Collections',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.cut), label: 'Atelier'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Bookings',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
//         ],
//       ),
//     );
//   }
// }

// class Boutique {
//   final String name;
//   final String address;
//   final String subtitle;
//   final String phone;
//   final LatLng position;
//   final String badgeText;
//   final Color accentColor;

//   Boutique({
//     required this.name,
//     required this.address,
//     required this.subtitle,
//     required this.phone,
//     required this.position,
//     required this.badgeText,
//     required this.accentColor,
//   });
// }
