import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/glass_bottom_nav_widget.dart';
import '../services/chatbot_service.dart';
import '../services/auth_service.dart';

class ChatPage extends StatefulWidget {
  final List<Map<String, String>>? initialOutfitItems;

  const ChatPage({super.key, this.initialOutfitItems});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  final AuthService _authService = AuthService();
  bool _isComposing = false;
  Uint8List? _pendingImageBytes;
  bool _isImageLoading = false;
  bool _initialized = false;
  bool _isBotTyping = false;

  String _userName = '';
  String _userEmail = '';
  String _userInitial = 'U';

  final List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addBotWelcomeMessages();
    });

    if (widget.initialOutfitItems != null && widget.initialOutfitItems!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sendOutfitItems(widget.initialOutfitItems!);
      });
    }
  }

  void _loadUserProfile() {
    final user = _authService.currentUser;
    if (user != null) {
      setState(() {
        _userName = user.displayName ?? '';
        _userEmail = user.email ?? '';
        if (_userName.isNotEmpty) {
          _userInitial = _userName[0].toUpperCase();
        } else if (_userEmail.isNotEmpty) {
          _userInitial = _userEmail[0].toUpperCase();
        }
      });
    }
  }

  void _addBotWelcomeMessages() {
    setState(() {
      messages.add(ChatbotService.getGreeting());
    });
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        messages.add(ChatbotService.getWelcomeMessage());
      });
      _scrollToBottom();
    });
  }

  void _sendOutfitItems(List<Map<String, String>> items) {
    if (_initialized) return;
    _initialized = true;

    for (final item in items) {
      setState(() {
        messages.add({
          "isMe": true,
          "time": _getCurrentTime(),
          "product": {
            "name": item["name"],
            "price": "\$49.99",
            "image": item["image"],
          },
        });
      });
    }
    _scrollToBottom();
  }

  Future<void> sendMessage() async {
    final hasText = _controller.text.trim().isNotEmpty;
    final hasImage = _pendingImageBytes != null;
    
    if (!hasText && !hasImage) return;

    final userText = _controller.text.trim();

    final Map<String, dynamic> message = {
      "isMe": true,
      "time": _getCurrentTime(),
    };

    if (hasText) {
      message["text"] = userText;
    }

    if (hasImage) {
      // Store bytes directly in message - most reliable on mobile
      message["imageBytes"] = _pendingImageBytes;
    }

    // Clear state immediately
    setState(() {
      messages.add(message);
      _isComposing = false;
      _pendingImageBytes = null;
      _isBotTyping = true;
    });

    _controller.clear();
    _scrollToBottom();

    // Get bot response
    String botQuery = userText;
    if (!hasText && hasImage) {
      botQuery = "image";
    }

    final botResponse = await ChatbotService.getResponse(botQuery);
    
    setState(() {
      _isBotTyping = false;
      messages.add(botResponse);
    });
    _scrollToBottom();

    if (botResponse.containsKey("followUp") && botResponse["followUp"] != null) {
      await Future.delayed(const Duration(milliseconds: 1500));
      setState(() {
        messages.add({
          "isMe": false,
          "text": botResponse["followUp"],
          "time": _getCurrentTime(),
        });
      });
      _scrollToBottom();
    }
  }

  void clearPendingImage() {
    setState(() {
      _pendingImageBytes = null;
    });
  }

  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    setState(() => _isImageLoading = true);
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (image == null) {
        setState(() => _isImageLoading = false);
        return;
      }

      // Read bytes from the picked image
      final bytes = await image.readAsBytes();
      
      // Clear loading before sending
      setState(() => _isImageLoading = false);

      // Store bytes and send message immediately
      _pendingImageBytes = bytes;
      await sendMessage();
    } catch (e) {
      setState(() => _isImageLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Could not pick image: $e"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _onTextFieldChanged(String value) {
    setState(() {
      _isComposing = value.isNotEmpty;
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget chatBubble(Map<String, dynamic> msg, bool isMe) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xFFC5A081),
                child: const Text("N",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          if (isMe) const Spacer(),

          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (msg.containsKey("text"))
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.65,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFF5D4E37) : const Color(0xFFF5E6D3),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      msg["text"],
                      style: TextStyle(
                        color: isMe ? Colors.white : const Color(0xFF3D2F23),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                if (msg.containsKey("imageBytes") && msg["imageBytes"] is Uint8List)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          msg["imageBytes"] as Uint8List,
                          width: 200,
                          height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 200,
                              height: 140,
                              color: const Color(0xFFF5E6D3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.broken_image_outlined, color: Color(0xFFC4B5A0), size: 32),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Image unavailable",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                if (msg.containsKey("product")) _buildProductCard(msg),
                if (msg.containsKey("products") && msg["products"] is List)
                  ..._buildProductList(msg["products"] as List),
                if (msg.containsKey("time"))
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      msg["time"],
                      style: const TextStyle(fontSize: 11, color: Color(0xFF9F8E7F)),
                    ),
                  ),
              ],
            ),
          ),

          if (isMe)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xFF5D4E37),
                child: Text(_userInitial,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          if (!isMe) const Spacer(),
        ],
      ),
    );
  }

  List<Widget> _buildProductList(List<dynamic> products) {
    final List<Widget> cards = [];
    for (int i = 0; i < products.length; i++) {
      final product = products[i] as Map<String, dynamic>;
      cards.add(
        Padding(
          padding: EdgeInsets.only(top: i > 0 ? 12 : 4),
          child: _buildCompactProductCard(product),
        ),
      );
    }
    return cards;
  }

  Widget _buildCompactProductCard(Map<String, dynamic> product) {
    final imagePath = product["image"] as String? ?? "";

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: SizedBox(
              width: 90,
              height: 90,
              child: imagePath.isNotEmpty
                  ? Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFFF5E6D3),
                        child: const Icon(Icons.image_outlined, color: Color(0xFFC4B5A0)),
                      ),
                    )
                  : Container(
                      color: const Color(0xFFF5E6D3),
                      child: const Icon(Icons.image_outlined, color: Color(0xFFC4B5A0)),
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product["name"] ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1D1B18),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product["price"] ?? "",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5D4E37),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D4E37),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        minimumSize: Size.zero,
                      ),
                      child: const Text(
                        "ADD",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> msg) {
    final product = msg["product"];
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                product["image"],
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 160,
                  color: const Color(0xFFF5E6D3),
                  child: const Center(
                    child: Icon(Icons.image_outlined, color: Color(0xFFC4B5A0), size: 40),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product["name"],
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1D1B18))),
                  const SizedBox(height: 6),
                  Text(product["price"],
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5D4E37))),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D4E37),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "ADD TO BAG",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF2D2926)),
        title: Text(
          'Your Chat',
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D2926),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2926)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Column(
        children: [
          // Header with store profile
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFFC5A081),
                    child: const Text("N",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NEARY Fashion",
                          style: GoogleFonts.comfortaa(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2D2926))),
                        Text(
                          "Store Assistant",
                          style: GoogleFonts.comfortaa(
                            fontSize: 12,
                            color: const Color(0xFF9F8E7F)
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline,
                        color: Color(0xFF2D2926), size: 24),
                    onPressed: () {
                      _showStylistInfo();
                    },
                  ),
                ],
              ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _isBotTyping ? messages.length + 1 : messages.length,
              itemBuilder: (context, index) {
                if (index == messages.length && _isBotTyping) {
                  return _buildTypingIndicator();
                }
                final msg = messages[index];
                final isMe = msg["isMe"] as bool;
                return chatBubble(msg, isMe);
              },
            ),
          ),

          if (_isBotTyping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              alignment: Alignment.centerLeft,
              child: Text(
                "NEARY Fashion is typing...",
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          // Image preview using bytes instead of File
          if (_pendingImageBytes != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(_pendingImageBytes!,
                        width: 60, height: 60, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Image selected",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20, color: Colors.red),
                    onPressed: clearPendingImage,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

          // Input Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  icon: _isImageLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF9F8E7F)),
                        )
                      : const Icon(Icons.attach_file,
                          color: Color(0xFF9F8E7F), size: 22),
                  onPressed: _isImageLoading ? null : () => pickImage(source: ImageSource.gallery),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: _onTextFieldChanged,
                    decoration: const InputDecoration(
                      hintText: "Message...",
                      hintStyle: TextStyle(color: Color(0xFFC4B5A0)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    style: const TextStyle(fontSize: 15),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_isComposing || _pendingImageBytes != null) ? (_) => sendMessage() : null,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send,
                      color: Color(0xFF5D4E37), size: 22),
                  onPressed: (_isComposing || _pendingImageBytes != null)
                      ? sendMessage
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF5E6D3),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _typingDot(0),
                const SizedBox(width: 6),
                _typingDot(400),
                const SizedBox(width: 6),
                _typingDot(800),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _typingDot(int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFF5D4E37).withOpacity(value),
            shape: BoxShape.circle,
          ),
        );
      },
      onEnd: () {},
    );
  }

  void _showStylistInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFC5A081),
              child: const Text("N",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NEARY Fashion",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF2D2926),
                    ),
                  ),
                  Text(
                    "Store Assistant",
                    style: TextStyle(fontSize: 11, color: Color(0xFF9F8E7F)),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to NEARY Fashion! Our store assistant is here to help you find the perfect outfit, offer style advice, and make sure you always look your best! 💕",
              style: TextStyle(color: Color(0xFF5D4E37), height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              "💡 Ask us about:\n"
              "• Dress recommendations\n"
              "• Complete outfit ideas\n"
              "• Color matching advice\n"
              "• Style tips & trends",
              style: TextStyle(color: Color(0xFF5D4E37), height: 1.5),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5E6D3).withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person_outline, size: 16, color: Color(0xFF9F8E7F)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Chatting as: ${_userName.isNotEmpty ? _userName : _userEmail.isNotEmpty ? _userEmail : "User"}",
                      style: const TextStyle(fontSize: 11, color: Color(0xFF9F8E7F)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Got it!",
              style: TextStyle(color: Color(0xFF5D4E37), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}