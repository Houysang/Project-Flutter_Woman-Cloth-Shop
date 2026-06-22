class OutfitData {
  /// Outfit combination images for the outfit builder
  /// Keys are "TopName|BottomName" for combinations, or single item name for dresses
  static const Map<String, String> outfitCombinations = {
    // Dresses (single items) - actual files are .png
    "Summer Floral Dress": "assets/images_outfit/dress1.png",
    "Elegant Evening Dress": "assets/images_outfit/dress2.png",
    "Casual Day Dress": "assets/images_outfit/dress3.png",
    "Elegant Blue Evening Dress": "assets/images_outfit/dress4.png",
    "Casual Yellow Day Dress": "assets/images_outfit/dress5.png",
    "Girly Pink Day Dress": "assets/images_outfit/dress6.png",

    // Top + Skirt combinations for "Oversized Shirt"
    "Oversized Shirt|Short Skirt Blue": "assets/images_outfit/image1_1.png",
    "Oversized Shirt|Short Skirt": "assets/images_outfit/image1_2.png",
    "Oversized Shirt|Short Skirt White": "assets/images_outfit/image1_3.png",
    "Oversized Shirt|Long Skirt": "assets/images_outfit/image1_4.png",
    "Oversized Shirt|Long Skirt White": "assets/images_outfit/image1_5.png",
    "Oversized Shirt|Long Skirt Flower": "assets/images_outfit/image1_6.png",

    // Top + Skirt combinations for "Crop Top"
    "Crop Top|Short Skirt Blue": "assets/images_outfit/image2_1.png",
    "Crop Top|Short Skirt": "assets/images_outfit/image2_2.png",
    "Crop Top|Short Skirt White": "assets/images_outfit/image2_3.png",
    "Crop Top|Long Skirt": "assets/images_outfit/image2_4.png",
    "Crop Top|Long Skirt White": "assets/images_outfit/image2_5.png",
    "Crop Top|Long Skirt Flower": "assets/images_outfit/image2_6.png",

    // Top + Skirt combinations for "Silk Blouse"
    "Silk Blouse|Short Skirt Blue": "assets/images_outfit/image3_1.png",
    "Silk Blouse|Short Skirt": "assets/images_outfit/image3_2.png",
    "Silk Blouse|Short Skirt White": "assets/images_outfit/image3_3.png",
    "Silk Blouse|Long Skirt": "assets/images_outfit/image3_4.png",
    "Silk Blouse|Long Skirt White": "assets/images_outfit/image3_5.png",
    "Silk Blouse|Long Skirt Flower": "assets/images_outfit/image3_6.png",

    // Top + Skirt combinations for "Oversized Short Shirt"
    "Oversized Short Shirt|Short Skirt Blue": "assets/images_outfit/image4_1.png",
    "Oversized Short Shirt|Short Skirt": "assets/images_outfit/image4_2.png",
    "Oversized Short Shirt|Short Skirt White": "assets/images_outfit/image4_3.png",
    "Oversized Short Shirt|Long Skirt": "assets/images_outfit/image4_4.png",
    "Oversized Short Shirt|Long Skirt White": "assets/images_outfit/image4_5.png",
    "Oversized Short Shirt|Long Skirt Flower": "assets/images_outfit/image4_6.png",

    // Top + Skirt combinations for "Crop Top Blue"
    "Crop Top Blue|Short Skirt Blue": "assets/images_outfit/image5_1.png",
    "Crop Top Blue|Short Skirt": "assets/images_outfit/image5_2.png",
    "Crop Top Blue|Short Skirt White": "assets/images_outfit/image5_3.png",
    "Crop Top Blue|Long Skirt": "assets/images_outfit/image5_4.png",
    "Crop Top Blue|Long Skirt White": "assets/images_outfit/image5_5.png",
    "Crop Top Blue|Long Skirt Flower": "assets/images_outfit/image5_6.png",

    // Top + Skirt combinations for "Silk Blouse Pink"
    "Silk Blouse Pink|Short Skirt Blue": "assets/images_outfit/image6_1.png",
    "Silk Blouse Pink|Short Skirt": "assets/images_outfit/image6_2.png",
    "Silk Blouse Pink|Short Skirt White": "assets/images_outfit/image6_3.png",
    "Silk Blouse Pink|Long Skirt": "assets/images_outfit/image6_4.png",
    "Silk Blouse Pink|Long Skirt White": "assets/images_outfit/image6_5.png",
    "Silk Blouse Pink|Long Skirt Flower": "assets/images_outfit/image6_6.png",

    // Top + Pants combinations for "Oversized Shirt"
    "Oversized Shirt|White Short Pant": "assets/images_outfit/image1_7.png",
    "Oversized Shirt|Pink Short Pant": "assets/images_outfit/image1_8.png",
    "Oversized Shirt|Short Jean": "assets/images_outfit/image1_9.png",
    "Oversized Shirt|White Long Pant": "assets/images_outfit/image1_10.png",
    "Oversized Shirt|Long Jean": "assets/images_outfit/image1_11.png",
    "Oversized Shirt|Long Pink Pilate Pant": "assets/images_outfit/image1_12.png",

    // Top + Pants combinations for "Crop Top"
    "Crop Top|White Short Pant": "assets/images_outfit/image2_7.png",
    "Crop Top|Pink Short Pant": "assets/images_outfit/image2_9.png",
    "Crop Top|Short Jean": "assets/images_outfit/image2_9.png",
    "Crop Top|White Long Pant": "assets/images_outfit/image2_10.png",
    "Crop Top|Long Jean": "assets/images_outfit/image2_11.png",
    "Crop Top|Long Pink Pilate Pant": "assets/images_outfit/image2_12.png",

    // Top + Pants combinations for "Silk Blouse"
    "Silk Blouse|White Short Pant": "assets/images_outfit/image3_7.png",
    "Silk Blouse|Pink Short Pant": "assets/images_outfit/image3_8.png",
    "Silk Blouse|Short Jean": "assets/images_outfit/image3_9.png",
    "Silk Blouse|White Long Pant": "assets/images_outfit/image3_10.png",
    "Silk Blouse|Long Jean": "assets/images_outfit/image3_11.png",
    "Silk Blouse|Long Pink Pilate Pant": "assets/images_outfit/image3_12.png",

    // Top + Pants combinations for "Oversized Short Shirt"
    "Oversized Short Shirt|White Short Pant": "assets/images_outfit/image4_7.png",
    "Oversized Short Shirt|Pink Short Pant": "assets/images_outfit/image4_8.png",
    "Oversized Short Shirt|Short Jean": "assets/images_outfit/image4_9.png",
    "Oversized Short Shirt|White Long Pant": "assets/images_outfit/image4_10.png",
    "Oversized Short Shirt|Long Jean": "assets/images_outfit/image4_11.png",
    "Oversized Short Shirt|Long Pink Pilate Pant": "assets/images_outfit/image4_12.png",

    // Top + Pants combinations for "Crop Top Blue"
    "Crop Top Blue|White Short Pant": "assets/images_outfit/image5_7.png",
    "Crop Top Blue|Pink Short Pant": "assets/images_outfit/image5_8.png",
    "Crop Top Blue|Short Jean": "assets/images_outfit/image5_9.png",
    "Crop Top Blue|White Long Pant": "assets/images_outfit/image5_10.png",
    "Crop Top Blue|Long Jean": "assets/images_outfit/image5_11.png",
    "Crop Top Blue|Long Pink Pilate Pant": "assets/images_outfit/image5_12.png",

    // Top + Pants combinations for "Silk Blouse Pink"
    "Silk Blouse Pink|White Short Pant": "assets/images_outfit/image6_7.png",
    "Silk Blouse Pink|Pink Short Pant": "assets/images_outfit/image6_8.png",
    "Silk Blouse Pink|Short Jean": "assets/images_outfit/image6_9.png",
    "Silk Blouse Pink|White Long Pant": "assets/images_outfit/image6_10.png",
    "Silk Blouse Pink|Long Jean": "assets/images_outfit/image6_11.png",
    "Silk Blouse Pink|Long Pink Pilate Pant": "assets/images_outfit/image6_12.png",
  };

  /// Category labels and icons for the outfit builder
  static const List<Map<String, dynamic>> categories = [
    {"label": "Dresses", "icon": "woman"},
    {"label": "Tops", "icon": "checkroom"},
    {"label": "Skirts", "icon": "layers"},
    {"label": "Pants", "icon": "straighten"},
  ];

  /// All clothes organized by category
  static const List<List<Map<String, String>>> categoryClothes = [
    // Dresses (index 0)
    [
      {"name": "Summer Floral Dress", "image": "assets/images/dress1.jpg"},
      {"name": "Elegant Evening Dress", "image": "assets/images/dress2.png"},
      {"name": "Casual Day Dress", "image": "assets/images/dress3.png"},
      {"name": "Elegant Blue Evening Dress", "image": "assets/images/dress4.jpg"},
      {"name": "Casual Yellow Day Dress", "image": "assets/images/dress7.jpg"},
      {"name": "Girly Pink Day Dress", "image": "assets/images/dress8.jpg"},
    ],
    // Tops (index 1)
    [
      {"name": "Oversized Shirt", "image": "assets/images/top1.webp"},
      {"name": "Crop Top", "image": "assets/images/top2.jpg"},
      {"name": "Silk Blouse", "image": "assets/images/top3.webp"},
      {"name": "Oversized Short Shirt", "image": "assets/images/top6.jpg"},
      {"name": "Crop Top Blue", "image": "assets/images/top4.webp"},
      {"name": "Silk Blouse Pink", "image": "assets/images/top7.jpg"},
    ],
    // Skirts (index 2)
    [
      {"name": "Short Skirt Blue", "image": "assets/images/skirt1.webp"},
      {"name": "Short Skirt", "image": "assets/images/skirt2.jpg"},
      {"name": "Short Skirt White", "image": "assets/images/skirt3.jpg"},
      {"name": "Long Skirt", "image": "assets/images/skirt4.jpg"},
      {"name": "Long Skirt White", "image": "assets/images/skirt5.jpg"},
      {"name": "Long Skirt Flower", "image": "assets/images/skirt6.webp"},
    ],
    // Pants (index 3)
    [
      {"name": "White Short Pant", "image": "assets/images/pant1.jpg"},
      {"name": "Pink Short Pant", "image": "assets/images/pant2.jpg"},
      {"name": "Short Jean", "image": "assets/images/pant3.webp"},
      {"name": "White Long Pant", "image": "assets/images/pant4.jpg"},
      {"name": "Long Jean", "image": "assets/images/pant5.webp"},
      {"name": "Long Pink Pilate Pant", "image": "assets/images/pant6.jpg"},
    ],
  ];
}