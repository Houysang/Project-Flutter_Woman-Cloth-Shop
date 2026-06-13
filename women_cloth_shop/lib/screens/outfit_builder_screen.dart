import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lookbook_screen.dart';
import '../components/navigation_bar_widget.dart';
import '../components/glass_bottom_nav_widget.dart';

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

  final List<Map<String, String>> clothes = [
    {"name": "Turtleneck", "image": "assets/Cashmere Turtleneck.png"},
    {"name": "Cream Blazer", "image": "assets/Cream Blazer.png"},
    {"name": "Double Jacket", "image": "assets/Double Breasted Jacket.png"},
    {"name": "Silk Blouse", "image": "assets/Silk Blouse.png"},
  ];

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
        toolbarHeight: 0,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: NavigationBarWidget(
                onMenuTap: () {},
              ),
            ),

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
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Image.asset(
                                        item["image"]!,
                                        fit: BoxFit.cover,
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

                    // CLOTHES LIST
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: clothes.length,
                        itemBuilder: (context, index) {
                          final item = clothes[index];

                          return GestureDetector(
                            onTap: () => addItem(item),
                            child: Container(
                              width: 140,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        item["image"]!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF5D4E37),
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(18),
                                      ),
                                    ),
                                    child: Text(
                                      item["name"]!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.comfortaa(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationBarWidget(
                onMenuTap: () => Navigator.maybePop(context),
              ),
              const SizedBox(height: 24),
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
                              selectedItems.first["image"]!,
                              fit: BoxFit.contain,
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
            ],
          ),
        ),
      ),

      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }
}