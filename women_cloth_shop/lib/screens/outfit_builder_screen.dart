import 'package:flutter/material.dart';

class OutfitBuilderScreen extends StatefulWidget {
  const OutfitBuilderScreen({super.key});

  @override
  State<OutfitBuilderScreen> createState() => _OutfitBuilderScreenState();
}

class _OutfitBuilderScreenState extends State<OutfitBuilderScreen> {
  bool isBuildYourOwn = true;

  List<Map<String, dynamic>> selectedItems = [];

  final List<Map<String, dynamic>> items = [
    {"name": "Cream Blazer", "price": 180, "image": "assets/Cream Blazer.png"},
    {"name": "Silk Blouse", "price": 120, "image": "assets/Silk Blouse.png"},
    {
      "name": "Cashmere Turtleneck",
      "price": 145,
      "image": "assets/Cashmere Turtleneck.png",
    },
    {
      "name": "Double Breasted Jacket",
      "price": 170,
      "image": "assets/Double Breasted Jacket.png",
    },
  ];

  void toggleItem(Map<String, dynamic> item) {
    setState(() {
      if (selectedItems.any((e) => e["name"] == item["name"])) {
        selectedItems.removeWhere((e) => e["name"] == item["name"]);
      } else {
        selectedItems.add(item);
      }
    });
  }

  void clearAll() {
    setState(() {
      selectedItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF9F6),
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text("OnlyWomen", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_bag_outlined, color: Colors.black),
          ),
        ],
      ),

      backgroundColor: const Color(0xFFFAF9F6),

      body: Column(
        children: [
          // ================= HEADER =================
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "LOOKBOOK • OUTFIT BUILDER",
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // ================= TOGGLE =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isBuildYourOwn = false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isBuildYourOwn
                              ? const Color(0xFF5D4E37)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Pre-Styled",
                            style: TextStyle(
                              color: !isBuildYourOwn
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isBuildYourOwn = true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isBuildYourOwn
                              ? const Color(0xFF5D4E37)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            "Build Your Own",
                            style: TextStyle(color: Colors.white),
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

          // ================= MODEL AREA =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 320,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E4DC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // MODEL IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/Model Preview.png",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // SELECTED ITEMS ON MODEL
                  ...selectedItems.map((item) {
                    return Positioned(
                      top: 120,
                      left: 60,
                      right: 60,
                      child: Image.asset(item["image"], height: 140),
                    );
                  }),

                  // CENTER + BUTTON
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 160,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 45, color: Colors.white),
                            SizedBox(height: 10),
                            Text(
                              "ADD ITEM",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // CLEAR + SAVE
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: clearAll,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              "CLEAR",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5D4E37),
                            ),
                            child: const Text(
                              "SAVE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ================= GRID =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = selectedItems.any(
                    (e) => e["name"] == item["name"],
                  );

                  return GestureDetector(
                    onTap: () => toggleItem(item),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF5D4E37)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              item["image"],
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            item["name"],
                            style: const TextStyle(fontSize: 12),
                          ),

                          Text(
                            "\$${item["price"]}",
                            style: const TextStyle(fontSize: 12),
                          ),

                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
