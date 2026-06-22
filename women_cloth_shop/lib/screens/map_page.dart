import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/glass_bottom_nav_widget.dart';
import 'booking_page.dart';

/// Boutique model representing a try-on store location.
class Boutique {
  final String name;
  final String address;
  final String subtitle;
  final String phone;
  final LatLng position;
  final String badgeText;
  final Color accentColor;
  final List<String> productCategories;
  final double rating;
  final int reviewCount;
  final bool hasTryOn;
  final bool isOpenNow;

  const Boutique({
    required this.name,
    required this.address,
    required this.subtitle,
    required this.phone,
    required this.position,
    required this.badgeText,
    required this.accentColor,
    this.productCategories = const [],
    this.rating = 4.5,
    this.reviewCount = 0,
    this.hasTryOn = true,
    this.isOpenNow = true,
  });
}

/// Boutique Map: Nearby Try-On Stores (Phnom Penh, Cambodia)
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  int _selectedBottomIndex = 1;

  static const Color primaryBrown = Color(0xFF5D4E37);
  static const Color bgBeige = Color(0xFFF6F0E2);
  static const Color darkText = Color(0xFF1D1B18);
  static const Color mutedText = Color(0xFF7C7569);

  // Phnom Penh center (matches map_picker_page.dart)
  LatLng _center = const LatLng(11.5564, 104.9282);
  Boutique? _selectedBoutique;
  List<Boutique> _filteredBoutiques = [];
  String _searchQuery = '';
  String _activeFilter = 'All';
  bool _showList = true;

  final List<Boutique> _boutiques = [
    const Boutique(
      name: 'Neary Woman Fashion - 5th Avenue',
      address: '#572 5th Ave, Bactouk ,Phnom Penh',
      subtitle: 'Open until 8:00 PM',
      phone: '(023) 888 0216',
      position: LatLng(11.5830, 104.8850),
      badgeText: 'Flagship',
      accentColor: Color(0xFFB67D40),
      productCategories: ['Dresses', 'Tops', 'Skirts', 'Accessories'],
      rating: 4.8,
      reviewCount: 234,
      hasTryOn: true,
      isOpenNow: true,
    ),
    const Boutique(
      name: 'Neary Woman Fashion - Toul Kork',
      address: '#168, St. 315, Toul Kork, Phnom Penh',
      subtitle: 'Open until 7:30 PM',
      phone: '(023) 555 0321',
      position: LatLng(11.5680, 104.9050),
      badgeText: 'Atelier',
      accentColor: Color(0xFF8B7560),
      productCategories: ['Custom', 'Designer', 'Bridal'],
      rating: 4.6,
      reviewCount: 189,
      hasTryOn: true,
      isOpenNow: true,
    ),
    const Boutique(
      name: 'Neary Woman Fashion - River',
      address: '#72, Sisowath Quay, Daun Penh, Phnom Penh',
      subtitle: 'Open until 9:00 PM',
      phone: '(023) 555 0487',
      position: LatLng(11.5620, 104.9280),
      badgeText: 'Boutique',
      accentColor: Color(0xFF9B8B7A),
      productCategories: ['Cocktail', 'Evening', 'Suits'],
      rating: 4.7,
      reviewCount: 156,
      hasTryOn: true,
      isOpenNow: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredBoutiques = List.from(_boutiques);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _applyFilters();
    });
  }

  void _applyFilters() {
    _filteredBoutiques = _boutiques.where((b) {
      final matchesSearch = _searchQuery.isEmpty ||
          b.name.toLowerCase().contains(_searchQuery) ||
          b.address.toLowerCase().contains(_searchQuery) ||
          b.badgeText.toLowerCase().contains(_searchQuery) ||
          b.productCategories.any((c) => c.toLowerCase().contains(_searchQuery));

      final matchesFilter = _activeFilter == 'All' ||
          (_activeFilter == 'Try-On' && b.hasTryOn) ||
          (_activeFilter == 'Open Now' && b.isOpenNow);

      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _setFilter(String filter) {
    setState(() {
      _activeFilter = filter;
      _applyFilters();
    });
  }

  void _focusBoutique(Boutique boutique) {
    _mapController.move(boutique.position, 16.0);
    setState(() => _selectedBoutique = boutique);
  }

  void _openBooking(Boutique boutique) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BookingPage(
          productName: 'Fitting at OnlyWomen Boutique',
          productPrice: 'Free',
        ),
      ),
    );
  }

  void _openDirections(Boutique boutique) {
    _mapController.move(boutique.position, 16.0);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigate to ${boutique.name}'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBeige,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildMap(),
          Positioned(
            top: 12,
            left: 16,
            right: 16,
            child: _buildSearchCard(),
          ),
          Positioned(
            top: 80,
            left: 16,
            right: 16,
            child: _buildFilterChips(),
          ),
          Positioned(
            bottom: 90,
            right: 16,
            child: _buildListToggle(),
          ),
          if (_showList)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.35,
              child: _buildBoutiqueListPanel(),
            ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: bgBeige,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Boutique Map',
        style: GoogleFonts.comfortaa(
          color: primaryBrown,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: primaryBrown, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.my_location, color: primaryBrown, size: 22),
          onPressed: () {
            _mapController.move(_center, 13.0);
            setState(() => _selectedBoutique = null);
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _center,
        initialZoom: 13.0,
        minZoom: 10,
        maxZoom: 18,
        onTap: (tapPosition, point) {
          setState(() => _selectedBoutique = null);
        },
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.onlywomen.shop',
        ),
        MarkerLayer(
          markers: _filteredBoutiques.map((b) {
            final isSelected = _selectedBoutique == b;
            return Marker(
              point: b.position,
              width: isSelected ? 60 : 44,
              height: isSelected ? 60 : 44,
              child: GestureDetector(
                onTap: () => _focusBoutique(b),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutBack,
                  decoration: BoxDecoration(
                    color: isSelected ? b.accentColor : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: b.accentColor.withOpacity(0.4),
                        blurRadius: isSelected ? 12 : 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      color: isSelected ? Colors.white : b.accentColor,
                      width: isSelected ? 3 : 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.store_rounded,
                      color: isSelected ? Colors.white : b.accentColor,
                      size: isSelected ? 24 : 18,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search boutiques, area, or category...',
          hintStyle:
              TextStyle(color: mutedText.withOpacity(0.6), fontSize: 14),
          prefixIcon:
              const Icon(Icons.search, color: primaryBrown, size: 22),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: mutedText, size: 18),
                  onPressed: () => _searchController.clear(),
                )
              : null,
          filled: false,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Try-On', 'Open Now'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: filters.map((filter) {
          final isActive = _activeFilter == filter;
          IconData? icon;
          if (filter == 'Try-On') icon = Icons.checkroom;
          if (filter == 'Open Now') icon = Icons.access_time;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => _setFilter(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color:
                      isActive ? primaryBrown : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isActive
                        ? primaryBrown
                        : primaryBrown.withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withOpacity(isActive ? 0.12 : 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color: isActive ? Colors.white : primaryBrown,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      filter,
                      style: TextStyle(
                        color: isActive ? Colors.white : primaryBrown,
                        fontSize: 13,
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListToggle() {
    return GestureDetector(
      onTap: () => setState(() => _showList = !_showList),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          _showList ? Icons.map : Icons.list,
          color: primaryBrown,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildBoutiqueListPanel() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
            child: Row(
              children: [
                Text(
                  'Nearby Boutiques',
                  style: GoogleFonts.comfortaa(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: primaryBrown.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_filteredBoutiques.length}',
                    style: TextStyle(
                      color: primaryBrown,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Phnom Penh',
                  style: TextStyle(color: mutedText, fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredBoutiques.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.store_mall_directory_outlined,
                            size: 48, color: mutedText.withOpacity(0.4)),
                        const SizedBox(height: 12),
                        Text(
                          'No boutiques found',
                          style: TextStyle(color: mutedText, fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Try a different search or filter',
                          style: TextStyle(
                              color: mutedText.withOpacity(0.6), fontSize: 13),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredBoutiques.length,
                    itemBuilder: (context, index) =>
                        _buildBoutiqueCard(_filteredBoutiques[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoutiqueCard(Boutique boutique) {
    final isSelected = _selectedBoutique == boutique;

    return GestureDetector(
      onTap: () => _focusBoutique(boutique),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? boutique.accentColor.withOpacity(0.06)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? boutique.accentColor.withOpacity(0.4)
                : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: boutique.accentColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.store_rounded,
                        color: boutique.accentColor,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                boutique.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: darkText,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: boutique.isOpenNow
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                boutique.isOpenNow ? 'Open' : 'Closed',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: boutique.isOpenNow
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star,
                                size: 14, color: Colors.amber.shade700),
                            const SizedBox(width: 4),
                            Text(
                              '${boutique.rating}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: darkText,
                              ),
                            ),
                            Text(
                              ' (${boutique.reviewCount})',
                              style: TextStyle(
                                fontSize: 11,
                                color: mutedText,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.location_on,
                                size: 13,
                                color: mutedText.withOpacity(0.6)),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                boutique.address,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: mutedText,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children:
                              boutique.productCategories.take(3).map((cat) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color:
                                      boutique.accentColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  cat,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: boutique.accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBrown,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        onPressed: () => _openBooking(boutique),
                        icon: const Icon(Icons.calendar_today, size: 16),
                        label: const Text('Book Fitting',
                            style: TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryBrown,
                          side: const BorderSide(color: primaryBrown),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        onPressed: () => _openDirections(boutique),
                        icon: const Icon(Icons.directions, size: 16),
                        label: const Text('Directions',
                            style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}