import 'dart:math';

class ChatbotService {
  // Product catalog knowledge
  static final List<Map<String, String>> _products = [
    {"name": "Silk Blouse", "price": "\$59", "image": "assets/images/fashion4.jpg", "category": "tops"},
    {"name": "Elegant Dress", "price": "\$79", "image": "assets/images/fashion2.jpg", "category": "dresses"},
    {"name": "Summer Top", "price": "\$49", "image": "assets/images/fashion3.jpg", "category": "tops"},
    {"name": "Blue Dress", "price": "\$89", "image": "assets/blue_dress.png", "category": "dresses"},
    {"name": "Brown Dress", "price": "\$75", "image": "assets/brown_dress.png", "category": "dresses"},
    {"name": "Yellow Dress", "price": "\$69", "image": "assets/yellow_dress.png", "category": "dresses"},
    {"name": "Black Dress", "price": "\$85", "image": "assets/black_dress.png", "category": "dresses"},
    {"name": "Light Blue Dress", "price": "\$79", "image": "assets/light_blue_dress.png", "category": "dresses"},
    {"name": "Blue Blazer", "price": "\$99", "image": "assets/blue_blazer.png", "category": "outerwear"},
    {"name": "Brown Blazer", "price": "\$95", "image": "assets/brown_blazer.png", "category": "outerwear"},
    {"name": "Green Blazer", "price": "\$89", "image": "assets/green_blazer.png", "category": "outerwear"},
    {"name": "Brown Trousers", "price": "\$65", "image": "assets/brown_trousers.png", "category": "bottoms"},
    {"name": "Cream Trousers", "price": "\$59", "image": "assets/cream_trousers.png", "category": "bottoms"},
    {"name": "Yellow Blouse", "price": "\$55", "image": "assets/yellow_blouse.png", "category": "tops"},
    {"name": "Brown Satin", "price": "\$72", "image": "assets/brown_satin.png", "category": "tops"},
    {"name": "Silk Clothe", "price": "\$62", "image": "assets/silk_clothe.png", "category": "tops"},
    {"name": "Cream Bag", "price": "\$45", "image": "assets/cream_bag.png", "category": "accessories"},
    {"name": "Ephemeral Bag", "price": "\$55", "image": "assets/ephemeral_bag.png", "category": "accessories"},
    {"name": "Brown Shoes", "price": "\$78", "image": "assets/brown_shoes.png", "category": "shoes"},
    {"name": "Cream Shoes", "price": "\$72", "image": "assets/cream_shoes.png", "category": "shoes"},
    {"name": "Ephemeral Shoes", "price": "\$82", "image": "assets/ephemeral_shoes.png", "category": "shoes"},
    {"name": "Ephemeral Dress", "price": "\$92", "image": "assets/ephemeral_dress.png", "category": "dresses"},
  ];

  static final Random _random = Random();

  // Greeting responses
  static final List<String> _greetings = [
    "Hello! Welcome to Neary Fashion, your personal stylist. How can I help you today? 💫",
    "Hi there! Ready to find your perfect look? I'm here to help! ✨",
    "Welcome! I'd love to help you find something beautiful today. What are you looking for? 💕",
    "Hey! Let's find you an amazing outfit. Tell me what you need! 🌸",
  ];

  // Fashion tips by category
  static final Map<String, List<String>> _tips = {
    "dresses": [
      "For a classic look, pair an elegant dress with nude heels and minimal accessories.",
      "A-line dresses flatter most body types - they cinch at the waist and flare out beautifully.",
      "For evening events, opt for darker shades like black or navy. For daytime, pastels and florals are perfect!",
      "Don't forget to accessorize your dress with a clutch bag and statement earrings.",
    ],
    "tops": [
      "A silk blouse is incredibly versatile - pair it with trousers for work or jeans for a casual outing.",
      "Layering a blazer over a simple top instantly elevates your look.",
      "For a chic summer look, tuck a lightweight blouse into high-waisted shorts.",
    ],
    "outerwear": [
      "A well-fitted blazer can transform any outfit from casual to sophisticated.",
      "For a monochromatic look, match your blazer with trousers in the same color family.",
      "Blazers look great with both dresses and trousers - they're the ultimate layering piece!",
    ],
    "bottoms": [
      "High-waisted trousers are universally flattering and create beautiful proportions.",
      "Cream trousers are a wardrobe staple - they pair with virtually any top color.",
      "For a polished look, make sure your trousers are hemmed to the right length.",
    ],
    "accessories": [
      "A quality bag is an investment piece that completes every outfit.",
      "Choose a bag that complements your outfit's color palette for a cohesive look.",
    ],
    "shoes": [
      "Nude shoes create the illusion of longer legs - perfect for pairing with dresses and skirts.",
      "Comfortable yet stylish shoes are essential - look for cushioned insoles and quality materials.",
    ],
  };

  // Outfit suggestions
  static final List<List<Map<String, String>>> _outfitSuggestions = [
    [
      {"name": "Silk Blouse", "price": "\$59", "image": "assets/images/fashion4.jpg"},
      {"name": "Cream Trousers", "price": "\$59", "image": "assets/cream_trousers.png"},
      {"name": "Cream Shoes", "price": "\$72", "image": "assets/cream_shoes.png"},
      {"name": "Cream Bag", "price": "\$45", "image": "assets/cream_bag.png"},
    ],
    [
      {"name": "Blue Blazer", "price": "\$99", "image": "assets/blue_blazer.png"},
      {"name": "Yellow Blouse", "price": "\$55", "image": "assets/yellow_blouse.png"},
      {"name": "Brown Trousers", "price": "\$65", "image": "assets/brown_trousers.png"},
      {"name": "Brown Shoes", "price": "\$78", "image": "assets/brown_shoes.png"},
    ],
    [
      {"name": "Elegant Dress", "price": "\$79", "image": "assets/images/fashion2.jpg"},
      {"name": "Ephemeral Shoes", "price": "\$82", "image": "assets/ephemeral_shoes.png"},
      {"name": "Ephemeral Bag", "price": "\$55", "image": "assets/ephemeral_bag.png"},
    ],
    [
      {"name": "Black Dress", "price": "\$85", "image": "assets/black_dress.png"},
      {"name": "Green Blazer", "price": "\$89", "image": "assets/green_blazer.png"},
      {"name": "Cream Shoes", "price": "\$72", "image": "assets/cream_shoes.png"},
    ],
    [
      {"name": "Brown Satin", "price": "\$72", "image": "assets/brown_satin.png"},
      {"name": "Cream Trousers", "price": "\$59", "image": "assets/cream_trousers.png"},
      {"name": "Brown Shoes", "price": "\$78", "image": "assets/brown_shoes.png"},
      {"name": "Cream Bag", "price": "\$45", "image": "assets/cream_bag.png"},
    ],
  ];

  /// Gets a greeting message
  static Map<String, dynamic> getGreeting() {
    final greeting = _greetings[_random.nextInt(_greetings.length)];
    return {
      "isMe": false,
      "text": greeting,
      "time": _getCurrentTime(),
    };
  }

  /// Gets a welcome message with quick actions
  static Map<String, dynamic> getWelcomeMessage() {
    return {
      "isMe": false,
      "text": "I can help you with:\n"
          "👗 Finding the perfect dress\n"
          "💼 Outfit recommendations\n"
          "🎨 Style advice & color matching\n"
          "📏 Sizing guidance\n\n"
          "Just tell me what you're looking for!",
      "time": _getCurrentTime(),
    };
  }

  /// Processes user message and returns bot response
  static Future<Map<String, dynamic>> getResponse(String userMessage) async {
    final lower = userMessage.toLowerCase();

    // Simulate typing delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Greetings
    if (_matchesAny(lower, ["hello", "hi", "hey", "good morning", "good evening", "good afternoon"])) {
      return {
        "isMe": false,
        "text": _greetings[_random.nextInt(_greetings.length)],
        "time": _getCurrentTime(),
      };
    }

    // How are you
    if (_matchesAny(lower, ["how are you", "how's it going", "how are you doing"])) {
      return {
        "isMe": false,
        "text": "I'm wonderful, thank you! I'm always excited to help create beautiful looks. What can I assist you with today? 💫",
        "time": _getCurrentTime(),
      };
    }

    // Dresses
    if (_matchesAny(lower, ["dress", "dresses", "gown", "evening dress", "party dress"])) {
      final dressProducts = _products.where((p) => p["category"] == "dresses").toList();
      dressProducts.shuffle();
      final selected = dressProducts.take(2).toList();
      return {
        "isMe": false,
        "text": "We have beautiful dresses! Here are some I think you'll love:",
        "time": _getCurrentTime(),
        "products": selected,
        "followUp": _tips["dresses"]![_random.nextInt(_tips["dresses"]!.length)],
      };
    }

    // Tops / Blouses
    if (_matchesAny(lower, ["top", "blouse", "shirt", "tops", "blouses"])) {
      final topProducts = _products.where((p) => p["category"] == "tops").toList();
      topProducts.shuffle();
      final selected = topProducts.take(2).toList();
      return {
        "isMe": false,
        "text": "Great choices for tops! Here are some stylish options:",
        "time": _getCurrentTime(),
        "products": selected,
        "followUp": _tips["tops"]![_random.nextInt(_tips["tops"]!.length)],
      };
    }

    // Blazers / Outerwear
    if (_matchesAny(lower, ["blazer", "jacket", "outerwear", "coat", "blazers"])) {
      final outerProducts = _products.where((p) => p["category"] == "outerwear").toList();
      outerProducts.shuffle();
      final selected = outerProducts.take(2).toList();
      return {
        "isMe": false,
        "text": "A blazer always makes a statement! Check these out:",
        "time": _getCurrentTime(),
        "products": selected,
        "followUp": _tips["outerwear"]![_random.nextInt(_tips["outerwear"]!.length)],
      };
    }

    // Trousers / Pants / Bottoms
    if (_matchesAny(lower, ["trouser", "pant", "bottom", "trousers", "pants", "skirt", "skirts"])) {
      final bottomProducts = _products.where((p) => p["category"] == "bottoms").toList();
      bottomProducts.shuffle();
      return {
        "isMe": false,
        "text": "Let's find the perfect bottoms for you! Here are some options:",
        "time": _getCurrentTime(),
        "products": bottomProducts,
        "followUp": _tips["bottoms"]![_random.nextInt(_tips["bottoms"]!.length)],
      };
    }

    // Shoes
    if (_matchesAny(lower, ["shoe", "shoes", "heels", "footwear", "sneakers", "boots"])) {
      final shoeProducts = _products.where((p) => p["category"] == "shoes").toList();
      return {
        "isMe": false,
        "text": "Step up your style with these beautiful shoes:",
        "time": _getCurrentTime(),
        "products": shoeProducts,
        "followUp": _tips["shoes"]![_random.nextInt(_tips["shoes"]!.length)],
      };
    }

    // Bags / Accessories
    if (_matchesAny(lower, ["bag", "accessories", "purse", "handbag", "tote", "clutch"])) {
      final bagProducts = _products.where((p) => p["category"] == "accessories").toList();
      return {
        "isMe": false,
        "text": "The right bag completes any outfit. Check these out:",
        "time": _getCurrentTime(),
        "products": bagProducts,
        "followUp": _tips["accessories"]![_random.nextInt(_tips["accessories"]!.length)],
      };
    }

    // Outfit suggestions
    if (_matchesAny(lower, ["outfit", "look", "style", "recommend", "suggestion", "what should i wear", "complete look", "ensemble"])) {
      final suggestion = _outfitSuggestions[_random.nextInt(_outfitSuggestions.length)];
      return {
        "isMe": false,
        "text": "I've put together a complete look for you! Here's what I recommend:",
        "time": _getCurrentTime(),
        "products": suggestion,
        "followUp": "This coordinated ensemble will have you looking absolutely stunning! Would you like to see more options?",
      };
    }

    // Color advice
    if (_matchesAny(lower, ["color", "colors", "what color", "matching", "match"])) {
      final colorTips = [
        "Earth tones like brown, cream, and olive green create a warm, sophisticated palette.",
        "Navy and white is a timeless combination that works for any occasion.",
        "For a bold statement, try pairing complementary colors like blue and orange or purple and yellow.",
        "Monochrome outfits (single color from head to toe) create an elegant, elongated silhouette.",
        "Pastels like blush pink, lavender, and mint green are perfect for spring and summer.",
      ];
      return {
        "isMe": false,
        "text": "Great question about colors! Here's my advice:\n\n${colorTips[_random.nextInt(colorTips.length)]}\n\nWould you like me to suggest some pieces in specific colors?",
        "time": _getCurrentTime(),
      };
    }

    // Sizing
    if (_matchesAny(lower, ["size", "sizing", "fit", "measurement", "sizes", "xs", "s", "m", "l", "xl"])) {
      return {
        "isMe": false,
        "text": "For the best fit, I recommend:\n\n"
            "1️⃣ Check our size guide on each product page\n"
            "2️⃣ Measure yourself - bust, waist, and hips\n"
            "3️⃣ If between sizes, I recommend sizing up for a more comfortable fit\n\n"
            "Feel free to check the product details, and don't hesitate to ask if you need more specific advice! 📏",
        "time": _getCurrentTime(),
      };
    }

    // Price / Budget
    if (_matchesAny(lower, ["price", "cost", "budget", "cheap", "expensive", "affordable", "how much"])) {
      return {
        "isMe": false,
        "text": "Our collection ranges from \$45 for accessories to \$99 for premium blazers. We have beautiful options at every price point! 🏷️\n\n"
            "Would you like me to show you items within a specific budget?",
        "time": _getCurrentTime(),
      };
    }

    // Summer
    if (_matchesAny(lower, ["summer", "beach", "vacation", "hot", "warm"])) {
      return {
        "isMe": false,
        "text": "For summer, I recommend lightweight fabrics like silk, cotton, and linen. Our light dresses and breezy blouses are perfect! ☀️\n\n"
            "Pair them with comfortable sandals and a straw bag for the ultimate summer vibe.",
        "time": _getCurrentTime(),
        "products": [
          {"name": "Light Blue Dress", "price": "\$79", "image": "assets/light_blue_dress.png"},
          {"name": "Yellow Blouse", "price": "\$55", "image": "assets/yellow_blouse.png"},
        ],
      };
    }

    // Winter
    if (_matchesAny(lower, ["winter", "cold", "fall", "autumn"])) {
      return {
        "isMe": false,
        "text": "Layering is key for colder months! A beautiful blazer over a silk blouse creates a warm yet elegant look. 🍂\n\n"
            "Our blazers pair perfectly with trousers for a cozy, sophisticated outfit.",
        "time": _getCurrentTime(),
        "products": [
          {"name": "Green Blazer", "price": "\$89", "image": "assets/green_blazer.png"},
          {"name": "Brown Trousers", "price": "\$65", "image": "assets/brown_trousers.png"},
        ],
      };
    }

    // Thank you
    if (_matchesAny(lower, ["thank", "thanks", "appreciate", "grateful"])) {
      return {
        "isMe": false,
        "text": "You're so welcome! 💕 It's my pleasure to help you look and feel your best. Come back anytime you need style advice!",
        "time": _getCurrentTime(),
      };
    }

    // Bye
    if (_matchesAny(lower, ["bye", "goodbye", "see you", "talk later", "farewell"])) {
      return {
        "isMe": false,
        "text": "Goodbye! 🌸 It was lovely chatting with you. Remember, I'm always here when you need fashion advice. Have a beautiful day!",
        "time": _getCurrentTime(),
      };
    }

    // Help
    if (_matchesAny(lower, ["help", "what can you do", "commands", "options", "menu"])) {
      return {
        "isMe": false,
        "text": "Here's what I can help you with:\n\n"
            "👗 **Dresses** - Browse our dress collection\n"
            "👚 **Tops & Blouses** - Find the perfect top\n"
            "🧥 **Blazers** - Add sophistication to your look\n"
            "👖 **Trousers** - Complete your outfit\n"
            "👠 **Shoes** - Step out in style\n"
            "👜 **Bags** - Find the perfect accessory\n"
            "🎨 **Color Advice** - Get color matching tips\n"
            "📏 **Sizing** - Fit guidance\n"
            "💡 **Outfit Ideas** - Complete look recommendations\n\n"
            "Just type what you're interested in!",
        "time": _getCurrentTime(),
      };
    }

    // Default - understanding the user but redirecting
    final defaultResponses = [
      "That's interesting! As your personal stylist, I specialize in helping you find the perfect clothing pieces. Would you like to see our dresses, tops, blazers, or maybe I can suggest a complete outfit? 💕",
      "I want to make sure you find exactly what you need! Would you like to browse our collection by category? We have beautiful dresses, stylish blazers, elegant tops, and more! 🌸",
      "I'm here to help you look amazing! Could you tell me more about what you're looking for? For example, are you interested in dresses, tops, or perhaps a complete outfit? ✨",
      "Let's find something beautiful for you! Would you like to:\n\n• Browse our **dress** collection\n• Check out **tops and blouses**\n• See our **blazer** selection\n• Get a **complete outfit suggestion**\n• Ask about **color matching**",
    ];

    return {
      "isMe": false,
      "text": defaultResponses[_random.nextInt(defaultResponses.length)],
      "time": _getCurrentTime(),
    };
  }

  /// Checks if the user message matches any of the keywords
  static bool _matchesAny(String message, List<String> keywords) {
    for (final keyword in keywords) {
      if (message.contains(keyword)) {
        return true;
      }
    }
    return false;
  }

  static String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }
}