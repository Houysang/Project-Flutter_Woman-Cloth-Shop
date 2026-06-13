import 'package:flutter/material.dart';
import 'lookbook_screen.dart';

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
  int bottomIndex = 0; // track bottom nav selection

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
      backgroundColor: Colors.white,

      // 🔥 Custom Header styled like “OnlyWomen”
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5DC),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF5D4E37)),
          onPressed: () {},
        ),
        title: const Text(
          "OnlyWomen",
          style: TextStyle(
            color: Color(0xFF5D4E37),
            fontSize: 22,
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_bag_outlined, color: Color(0xFF5D4E37)),
          ),
        ],
      ),

      body: Column(
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
                        child: const Center(
                          child: Text(
                            "Pre-Styled",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
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
                      child: const Center(
                        child: Text(
                          "Build Outfit",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
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
                        ? const Center(
                            child: Text("Tap clothes to add"),
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
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5D4E37),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: saveOutfit,
                        child: const Text("Save Outfit"),
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
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
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

      // 🔥 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex,
        onTap: (index) {
          setState(() => bottomIndex = index);
          // handle navigation logic here
        },
        selectedItemColor: const Color(0xFF5D4E37),
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Collections",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brush),
            label: "Atelier",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
      ),
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
      backgroundColor: Colors.white,

      // 🔥 Custom Header styled like “OnlyWomen”
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5DC),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF5D4E37)),
          onPressed: () {},
        ),
        title: const Text(
          "OnlyWomen",
          style: TextStyle(
            color: Color(0xFF5D4E37),
            fontSize: 22,
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_bag_outlined, color: Color(0xFF5D4E37)),
          ),
        ],
      ),

      body: Center(
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
              : const Center(
                  child: Text(
                    "No outfit selected",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ),
      ),

      // 🔥 Bottom Navigation Bar also in Preview Page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // handle navigation logic here
        },
        selectedItemColor: const Color(0xFF5D4E37),
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Collections",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brush),
            label: "Atelier",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
      ),
    );
  }
}