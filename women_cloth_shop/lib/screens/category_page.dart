import 'package:flutter/material.dart';
import '../models/product_data.dart';
import '../screens/category_product/product_list_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String searchText = '';

  final List<Map<String, dynamic>> categories = [
    {'name': 'Dresses', 'icon': Icons.checkroom},
    {'name': 'Tops', 'icon': Icons.style},
    {'name': 'Bags', 'icon': Icons.shopping_bag},
    {'name': 'Shoes', 'icon': Icons.directions_walk},
    {'name': 'Accessories', 'icon': Icons.watch},
  ];

  List<Map<String, String>> get filteredProducts {
    return allProducts.where((p) {
      return p['name']!.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  void openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductListPage(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
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

            const SizedBox(height: 10),

            // 🔥 SEARCH RESULT WITH IMAGE
            if (searchText.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];

                    return ListTile(
                      leading: Image.asset(
                        product['image']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product['name']!),
                      subtitle: Text(product['category']!),
                      onTap: () {
                        openCategory(product['category']!);
                      },
                    );
                  },
                ),
              )
            else
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final cat = categories[index];

                    return InkWell(
                      onTap: () => openCategory(cat['name']),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(cat['icon'], size: 40),
                            Text(cat['name']),
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
    );
  }
}
