import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/product_catalog.dart';
import '../screens/product_detail_page.dart';
import '../screens/search_results_page.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  List<String> _names = [];
  List<String> _ids = [];
  bool _show = false;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);
  static const String _allNames =
      "Silk Blouse, Elegant Dress, Summer Top, Summer Dress, Elegant Top, Casual Shirt, Mini Skirt, Luxury Bag, Oversized Shirt, Crop Top, Silk Blouse, Summer Floral Dress, Elegant Evening Dress, Casual Day Dress, Oversized Shirt, Crop Top, Silk Blouse, Pleated Mini Skirt, A-Line Midi Skirt, Wrap Skirt, Leather Shoulder Bag, Tote Bag, Clutch Evening Bag";

  void _search(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _names = [];
        _ids = [];
        _show = false;
      });
      return;
    }

    final q = query.toLowerCase().trim();
    final all = ProductCatalog.getAllProducts();
    final found = <String>[];
    final foundIds = <String>[];

    for (final e in all.entries) {
      final v = e.value.toString().toLowerCase();
      if (v.contains(q)) {
        found.add(e.value['name'] as String? ?? '?');
        foundIds.add(e.key);
      }
    }

    setState(() {
      _names = found;
      _ids = foundIds;
      _show = found.isNotEmpty;
    });
  }

  void _go(String id) {
    _controller.clear();
    _focusNode.unfocus();
    setState(() {
      _names = [];
      _ids = [];
      _show = false;
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => ProductDetailPage(productId: id)));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
          ],
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: _search,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: const Icon(Icons.search, color: accent),
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  setState(() {
                    _show = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SearchResultsPage(
                              query: _controller.text.trim())));
                }
              },
            ),
            hintText: "Search collections...",
            hintStyle: GoogleFonts.comfortaa(fontSize: 13, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                    onPressed: () {
                      _controller.clear();
                      _focusNode.unfocus();
                      setState(() {
                        _names = [];
                        _ids = [];
                        _show = false;
                      });
                    })
                : null,
          ),
          style: GoogleFonts.comfortaa(fontSize: 13),
        ),
      ),
      if (_show)
        Container(
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6))
            ],
          ),
          constraints: const BoxConstraints(maxHeight: 300),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 6),
                itemCount: _names.length > 5 ? 5 : _names.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, indent: 16, endIndent: 16),
                itemBuilder: (_, i) => ListTile(
                  onTap: () => _go(_ids[i]),
                  title: Text(_names[i],
                      style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: darkText)),
                ),
              ),
            ),
            if (_names.length > 5)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 2, 12, 6),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      _focusNode.unfocus();
                      final q = _controller.text.trim();
                      setState(() {
                        _show = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SearchResultsPage(query: q)));
                    },
                    child: Text('View all ${_names.length} results',
                        style: GoogleFonts.comfortaa(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: accent)),
                  ),
                ),
              ),
          ]),
        ),
    ]);
  }
}
