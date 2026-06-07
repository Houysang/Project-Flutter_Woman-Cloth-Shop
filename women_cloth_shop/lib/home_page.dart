import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/navigation_bar_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

    @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  final List<String> trendingImages = const [
    'assets/images/fashion1.jpg',
    'assets/images/fashion2.jpg',
    'assets/images/fashion3.jpg',
    'assets/images/fashion4.jpg',
    'assets/images/fashion5.jpg',
    'assets/images/fashion6.jpg',
    'assets/images/fashion7.jpg',
    'assets/images/fashion8.jpg',
    'assets/images/fashion9.jpg',
    'assets/images/fashion10.jpg',
  ];

  final List<String> productNames = const [
    'Silk Blouse',
    'Elegant Dress',
    'Summer Top',
    'Office Skirt',
    'Leather Bag',
    'Classic Heels',
    'Casual Shirt',
    'Evening Gown',
    'Mini Dress',
    'Luxury Handbag',
  ];

  final List<String> prices = const [
    '\$59',
    '\$79',
    '\$49',
    '\$55',
    '\$89',
    '\$120',
    '\$45',
    '\$140',
    '\$68',
    '\$110',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      extendBody: true,
      bottomNavigationBar: _glassBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NavigationBarWidget(),
              const SizedBox(height: 20),
              _searchBar(),
              const SizedBox(height: 25),
              _categories(),
              const SizedBox(height: 25),
              _sectionTitle("Promotion"),
              const SizedBox(height: 15),
              _featuredCard(),
              const SizedBox(height: 30),
              _sectionTitle("Trending"),
              const SizedBox(height: 15),
              _trending(),
              const SizedBox(height: 40),
              _seasonEditSection(),
              const SizedBox(height: 40),
              _sectionTitle("Products"),
                const SizedBox(height: 15),
              _productGrid(),
              const SizedBox(height: 30),

              // NEW SECTIONS
              _aboutMe(),
              const SizedBox(height: 30),
              _footer(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning,",
              style: GoogleFonts.comfortaa(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Text(
              "Sarah ✨",
              style: GoogleFonts.comfortaa(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          child: Icon(Icons.person_outline, color: darkText),
        ),
      ],
    );
  }
Widget _productGrid() {
  return MasonryGridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    mainAxisSpacing: 14,
    crossAxisSpacing: 14,
    itemCount: trendingImages.length,
    itemBuilder: (context, index) {
      return _productCard(
        image: trendingImages[index],
        title: productNames[index],
        price: prices[index],
      );
    },
  );
}

Widget _productCard({
  required String image,
  required String title,
  required String price,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // IMAGE SECTION WITH STACK
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 0.75,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              // Favorite Heart Icon
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),

        // DETAILS SECTION
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.comfortaa(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: darkText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                price,
                style: GoogleFonts.comfortaa(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              const SizedBox(height: 12),
              // ADD TO CART BUTTON
              SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag_outlined, size: 16),
                  label: const Text("Add", style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
  // ---------------- SEARCH ----------------
  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: accent),
          hintText: "Search collections...",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  // ---------------- DAILY VIBE ----------------
Widget _dailyVibe() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF6F0EA),
          Color(0xFFF3E8DF),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: [
        // ICON BADGE
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.wb_sunny_outlined,
            color: Colors.orange,
            size: 20,
          ),
        ),

        const SizedBox(width: 12),

        // TEXT
        const Expanded(
          child: Text(
            "Today's vibe: Soft neutrals & cozy elegance ✨",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ),

        const SizedBox(width: 10),

        // SMALL MOOD DOT (COZY DETAIL)
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
      ],
    ),
  );
}
  // ---------------- TRENDING (UPDATED) ----------------
Widget _trending() {
  return SizedBox(
    height: 320,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: trendingImages.length,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemBuilder: (_, i) {
        return Container(
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE SECTION
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(22),
                      ),
                      child: Image.asset(
                        trendingImages[i],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),

                    // soft gradient overlay (cozy feel)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(22),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.35),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // HEART BUTTON (top right floating)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                          iconSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // TEXT SECTION
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productNames[i],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.comfortaa(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: darkText,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      prices[i],
                      style: GoogleFonts.comfortaa(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ADD TO CART BUTTON (modern pill style)
                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_bag_outlined, size: 16),
                        label: const Text(
                          "Add",
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    ),
  );
}
  // ---------------- ABOUT ME (NEW) ----------------
Widget _aboutMe() {
return Container(
padding: const EdgeInsets.all(24),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(25),
gradient: const LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [
Color(0xFFF4ECE5),
Color(0xFFEFE8E1),
],
),
boxShadow: [
BoxShadow(
color: Colors.black12,
blurRadius: 12,
offset: Offset(0, 6),
),
],
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
"About Me",
style: GoogleFonts.comfortaa(
fontSize: 22,
fontWeight: FontWeight.bold,
color: darkText,
),
),
    const SizedBox(height: 12),

    Text(
      "Hello, I'm Sarah ✨",
      style: GoogleFonts.comfortaa(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: darkText,
      ),
    ),

    const SizedBox(height: 10),

    const Text(
      "Passionate about timeless fashion and effortless elegance. "
      "I love curating soft neutral palettes, cozy textures, and "
      "modern essentials that inspire confidence every day. "
      "This collection is thoughtfully selected to help you build "
      "a wardrobe that feels both beautiful and authentic.",
      style: TextStyle(
        color: Colors.black87,
        height: 1.6,
      ),
    ),
  ],
),

);
}


  // ---------------- FOOTER (NEW) ----------------
Widget _footer() {
return Container(
width: double.infinity,
padding: const EdgeInsets.symmetric(
horizontal: 20,
vertical: 30,
),
decoration: BoxDecoration(
// color: const Color(0xFFEFE8E1),
borderRadius: BorderRadius.circular(25),
),
child: Column(
children: [
Text(
"NEARY",
style: GoogleFonts.cormorantGaramond(
fontSize: 28,
fontWeight: FontWeight.bold,
letterSpacing: 2,
color: darkText,
),
),
    const SizedBox(height: 8),

    Text(
      "Fashion & Lifestyle",
      style: GoogleFonts.comfortaa(
        fontSize: 12,
        color: Colors.black54,
        letterSpacing: 2,
      ),
    ),

    const SizedBox(height: 20),

    const Text(
      "Curating cozy elegance, timeless fashion, and everyday confidence for modern women.",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black54,
        height: 1.6,
      ),
    ),

    const SizedBox(height: 25),

    const Divider(),

    const SizedBox(height: 20),

    Row(
      children: const [
        Icon(Icons.email_outlined,
            color: Colors.black54, size: 18),
        SizedBox(width: 10),
        Text(
          "hello@nearyfashion.com",
          style: TextStyle(color: Colors.black87),
        ),
      ],
    ),

    const SizedBox(height: 12),

    Row(
      children: const [
        Icon(Icons.phone_outlined,
            color: Colors.black54, size: 18),
        SizedBox(width: 10),
        Text(
          "+1 (555) 123-4567",
          style: TextStyle(color: Colors.black87),
        ),
      ],
    ),

    const SizedBox(height: 12),

    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Icon(Icons.location_on_outlined,
            color: Colors.black54, size: 18),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "123 Fashion Avenue,\nNew York, NY 10001",
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ],
    ),

    const SizedBox(height: 25),

    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.facebook_outlined,
            color: Colors.black54),
        SizedBox(width: 20),
        Icon(Icons.camera_alt_outlined,
            color: Colors.black54),
        SizedBox(width: 20),
        Icon(Icons.alternate_email,
            color: Colors.black54),
        SizedBox(width: 20),
        Icon(Icons.chat_outlined,
            color: Colors.black54),
      ],
    ),

    const SizedBox(height: 25),

    const Divider(),

    const SizedBox(height: 15),

    const Text(
      "© 2026 NEARY. All rights reserved.",
      style: TextStyle(
        color: Colors.black45,
        fontSize: 12,
      ),
    ),

    const SizedBox(height: 5),

    const Text(
      "Made with ❤ using Flutter",
      style: TextStyle(
        color: Colors.black45,
        fontSize: 12,
      ),
    ),
  ],
),
);
}

  // ---------------- OTHER SECTIONS (UNCHANGED) ----------------
  Widget _miniCard(String img) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

Widget _moodCard() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF3E9DF),
          Color(0xFFEFE8E1),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TOP ROW
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "YOUR STYLE MOOD",
              style: GoogleFonts.comfortaa(
                letterSpacing: 2,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            const Icon(
              Icons.auto_awesome,
              size: 18,
              color: Colors.black45,
            ),
          ],
        ),

        const SizedBox(height: 14),

        // MAIN TITLE
        Text(
          "Soft Minimalist",
          style: GoogleFonts.comfortaa(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),

        const SizedBox(height: 8),

        // DESCRIPTION
        const Text(
          "Neutral tones & effortless elegance for your everyday wardrobe.",
          style: TextStyle(
            color: Colors.black54,
            height: 1.4,
          ),
        ),

        const SizedBox(height: 14),

        // MOOD TAGS (NEW COZY FEATURE)
        Row(
          children: [
            _moodTag("Neutral"),
            const SizedBox(width: 8),
            _moodTag("Clean"),
            const SizedBox(width: 8),
            _moodTag("Elegant"),
          ],
        ),
      ],
    ),
  );
}

Widget _moodTag(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black12),
    ),
    child: Text(
      text,
      style: GoogleFonts.comfortaa(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    ),
  );
}
  Widget _categories() {
    final items = ["All", "Dresses", "Tops", "Skirts", "Bags"];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: i == 0 ? accent : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black12),
            ),
            alignment: Alignment.center,
            child: Text(
              items[i],
              style: TextStyle(
                color: i == 0 ? Colors.white : darkText,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _featuredCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          image: AssetImage('assets/images/f1.gif'),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(20),
      child: Text(
        "Autumn Essentials\n2026",
        style: GoogleFonts.comfortaa(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _seasonEditSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "The Seasons Edit",
          style: GoogleFonts.comfortaa(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Curated essentials that define the modern wardrobe, selected by our editorial team.",
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 20),

        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: const DecorationImage(
              image: AssetImage('assets/images/summercollection1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(child: _miniCard('assets/images/collection2.jpg')),
            const SizedBox(width: 12),
            Expanded(child: _miniCard('assets/images/collection3.jpg')),
          ],
        ),
      ],
    );
  }

  // ---------------- BOTTOM NAV ----------------
  Widget _glassBottomNav() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white.withOpacity(0.85),
            selectedItemColor: accent,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
    );
  }
}