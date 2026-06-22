import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lookbook_screen.dart';
import 'chat_page.dart';
import '../components/glass_bottom_nav_widget.dart';
import '../components/floating_chat_button.dart';
import '../data/outfit_data.dart';

class OutfitBuilderPage extends StatefulWidget {
  final String? presetTitle;
  final String? presetImage;

  const OutfitBuilderPage({
    super.key,
    this.presetTitle,
    this.presetImage,
  });

  @override
  State<OutfitBuilderPage> createState() => _OutfitBuilderPageState();
}

class _OutfitBuilderPageState extends State<OutfitBuilderPage> {
  int selectedTab = 1;
  int bottomIndex = 0;
  int categoryIndex = 0;

  static const List<Map<String, dynamic>> _categories = [
    {"label": "Dresses", "icon": Icons.woman_2_outlined},
    {"label": "Tops", "icon": Icons.checkroom_outlined},
    {"label": "Skirts", "icon": Icons.layers_outlined},
    {"label": "Pants", "icon": Icons.straighten_outlined},
  ];

  List<Map<String, String>> get clothes => OutfitData.categoryClothes[categoryIndex];

  List<Map<String, String>> selectedItems = [];

  @override
  void initState() {
    super.initState();

    if (widget.presetTitle?.isNotEmpty == true &&
        widget.presetImage?.isNotEmpty == true) {
      selectedItems.add({
        "name": widget.presetTitle!,
        "image": widget.presetImage!,
      });
    }
  }

  void addItem(Map<String, String> item) {
    setState(() {
      if (!selectedItems.any((e) => e["image"] == item["image"])) {
        selectedItems.add(item);
      }
    });
  }

  void removeItem(String image) {
    setState(() {
      selectedItems.removeWhere((e) => e["image"] == image);
    });
  }

  void saveOutfit() {
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select at least one item"),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OutfitPreviewPage(selectedItems: List.from(selectedItems)),
      ),
    ).then((_) {
      setState(() {
        selectedItems.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2D2926)),
        title: Text(
          'Outfit Builder',
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D2926),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),

                // TAB SWITCH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => selectedTab = 0);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LookbookPage(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectedTab == 0
                                    ? const Color(0xFF5D4E37)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  "Pre-Styled",
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: selectedTab == 0
                                        ? Colors.white
                                        : const Color(0xFF2D2926),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedTab == 1
                                  ? const Color(0xFF5D4E37)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                "Build Outfit",
                                style: GoogleFonts.comfortaa(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: selectedTab == 1
                                      ? Colors.white
                                      : const Color(0xFF2D2926),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        // SELECTED AREA
                        Container(
                          margin: const EdgeInsets.all(16),
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: selectedItems.isEmpty
                              ? Center(
                                  child: Text(
                                    "Tap clothes to add",
                                    style: GoogleFonts.comfortaa(
                                      color: const Color(0xFF6E655B),
                                    ),
                                  ),
                                )
                              : Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  alignment: WrapAlignment.center,
                                  children: selectedItems.map((item) {
                                    return Stack(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: Image.asset(
                                            item["image"]!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Container(
                                                  color: Colors.grey.shade300,
                                                  child: const Icon(Icons.broken_image, size: 40),
                                                ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 6,
                                          top: 6,
                                          child: GestureDetector(
                                            onTap: () =>
                                                removeItem(item["image"]!),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                        ),

                        // BUTTONS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade400,
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedItems.clear();
                                });
                              },
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.comfortaa(fontSize: 13),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5D4E37),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: saveOutfit,
                              child: Text(
                                "Save Outfit",
                                style: GoogleFonts.comfortaa(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // CATEGORY SELECTOR
                        SizedBox(
                          height: 36,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: _categories.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final cat = _categories[index];
                              final isSelected = categoryIndex == index;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => categoryIndex = index),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF5D4E37)
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        cat["icon"] as IconData,
                                        size: 16,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF2D2926),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        cat["label"] as String,
                                        style: GoogleFonts.comfortaa(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(0xFF2D2926),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 12),

                        // CLOTHES GRID (3 per row)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: clothes.length,
                            itemBuilder: (context, index) {
                              final item = clothes[index];
                              return GestureDetector(
                                onTap: () => addItem(item),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Image.asset(
                                            item["image"]!,
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Container(
                                                  color: Colors.grey.shade200,
                                                  child: const Icon(Icons.broken_image, size: 30),
                                                ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF5D4E37),
                                          borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(14),
                                          ),
                                        ),
                                        child: Text(
                                          item["name"]!,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.comfortaa(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating chat button
          const Positioned(
            right: 20,
            bottom: 20,
            child: FloatingChatButton(),
          ),
        ],
      ),
      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }
}

//
// ================= PREVIEW PAGE =================
//
class OutfitPreviewPage extends StatelessWidget {
  final List<Map<String, String>> selectedItems;

  const OutfitPreviewPage({
    super.key,
    required this.selectedItems,
  });

  String? getPreviewImage(List<Map<String, String>> items) {
    if (items.isEmpty) return null;

    // Single item - match by name or fallback to its own image
    if (items.length == 1) {
      final name = items[0]["name"]!;
      if (OutfitData.outfitCombinations.containsKey(name)) {
        return OutfitData.outfitCombinations[name];
      }
      return items[0]["image"];
    }

    // Deduplicate: get unique items by name
    final uniqueItems = <Map<String, String>>[];
    final seenNames = <String>{};
    for (final item in items) {
      if (seenNames.add(item["name"]!)) {
        uniqueItems.add(item);
      }
    }

    if (uniqueItems.length >= 2) {
      // Try combination as "firstUnique|secondUnique"
      final key = "${uniqueItems[0]["name"]}|${uniqueItems[1]["name"]}";
      if (OutfitData.outfitCombinations.containsKey(key)) {
        return OutfitData.outfitCombinations[key];
      }

      // Try reverse order
      final reverseKey = "${uniqueItems[1]["name"]}|${uniqueItems[0]["name"]}";
      if (OutfitData.outfitCombinations.containsKey(reverseKey)) {
        return OutfitData.outfitCombinations[reverseKey];
      }
    }

    // Fallback to first unique item's image
    return uniqueItems.first["image"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2D2926)),
        title: Text(
          'Outfit Preview',
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D2926),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Outfit Preview",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D2926),
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 320,
                        height: 450,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: selectedItems.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  getPreviewImage(selectedItems) ??
                                      selectedItems.first["image"]!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: Colors.grey.shade300,
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "No outfit selected",
                                  style: GoogleFonts.comfortaa(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Send to Chat button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              initialOutfitItems: selectedItems,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.chat_bubble_outline, size: 18),
                      label: const Text("Send to Chat"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D4E37),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating chat button
          const Positioned(
            right: 20,
            bottom: 20,
            child: FloatingChatButton(),
          ),
        ],
      ),
      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }
}