import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  final String category;

  const ProductListPage({
    super.key,
    required this.category,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String searchText = '';

  final List<Map<String, String>> allProducts = [
    // ================= DRESSES =================
    {
      'name': 'Floral Dress',
      'category': 'Dresses',
      'price': '\$49',
      'image': 'assets/images/dress1.png',
    },
    {
      'name': 'Summer Dress',
      'category': 'Dresses',
      'price': '\$55',
      'image': 'assets/images/dress2.png',
    },
    {
      'name': 'Elegant Midi Dress',
      'category': 'Dresses',
      'price': '\$65',
      'image': 'assets/images/dress3.png',
    },

    // ================= TOPS =================
    {
      'name': 'White Top',
      'category': 'Tops',
      'price': '\$25',
      'image': 'assets/images/top1.png',
    },
    {
      'name': 'Black Crop Top',
      'category': 'Tops',
      'price': '\$30',
      'image': 'assets/images/top2.png',
    },
    {
      'name': 'Casual Blouse',
      'category': 'Tops',
      'price': '\$28',
      'image': 'assets/images/top3.png',
    },

    // ================= BAGS =================
    {
      'name': 'Leather Bag',
      'category': 'Bags',
      'price': '\$80',
      'image': 'assets/images/bag1.png',
    },
    {
      'name': 'Mini Handbag',
      'category': 'Bags',
      'price': '\$65',
      'image': 'assets/images/bag2.png',
    },
    {
      'name': 'Luxury Tote Bag',
      'category': 'Bags',
      'price': '\$95',
      'image': 'assets/images/bag3.png',
    },

    // ================= SHOES =================
    {
      'name': 'Premuim Shoes',
      'category': 'Shoes',
      'price': '\$90',
      'image': 'assets/images/shoe1.png',
    },
    {
      'name': 'High Heels',
      'category': 'Shoes',
      'price': '\$120',
      'image': 'assets/images/shoe2.png',
    },
    {
      'name': 'Sneakers',
      'category': 'Shoes',
      'price': '\$75',
      'image': 'assets/images/shoe3.png',
    },

    // ================= ACCESSORIES =================
    {
      'name': 'Gold Watch',
      'category': 'Accessories',
      'price': '\$150',
      'image': 'assets/images/accessory1.png',
    },
    {
      'name': 'Necklace',
      'category': 'Accessories',
      'price': '\$60',
      'image': 'assets/images/accessory2.png',
    },
    {
      'name': 'Bracelet',
      'category': 'Accessories',
      'price': '\$40',
      'image': 'assets/images/accessory3.png',
    },
  ];

  List<Map<String, String>> get filteredProducts {
    return allProducts.where((product) {
      return product['category'] == widget.category &&
          product['name']!.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(fontSize: 14),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // SEARCH BAR
            TextField(
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),

                // ✅ FRAME / BORDER STYLE
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.brown,
                    width: 2,
                  ),
                ),

                // optional background
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),

            const SizedBox(height: 12),

            // LIST
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        // IMAGE (LEFT SIDE)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            product['image']!,
                            width: 90,
                            height: 90,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // INFO (RIGHT SIDE)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                product['price']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Tap to view details",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(Icons.arrow_forward_ios, size: 14),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
