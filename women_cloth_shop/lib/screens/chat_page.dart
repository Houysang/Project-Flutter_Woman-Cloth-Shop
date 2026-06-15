import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../components/glass_bottom_nav_widget.dart';

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
  bool _isComposing = false;
  File? _pendingImage;
  bool _isImageLoading = false;
  bool _initialized = false;

  final List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialOutfitItems != null && widget.initialOutfitItems!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sendOutfitItems(widget.initialOutfitItems!);
      });
    }
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

  void sendMessage() {
    if (_controller.text.trim().isEmpty && _pendingImage == null) return;

    final Map<String, dynamic> message = {
      "isMe": true,
      "time": _getCurrentTime(),
    };

    if (_controller.text.trim().isNotEmpty) {
      message["text"] = _controller.text.trim();
    }

    if (_pendingImage != null) {
      message["image"] = _pendingImage!;
    }

    setState(() {
      messages.add(message);
      _isComposing = false;
      _pendingImage = null;
    });

    _controller.clear();
    _scrollToBottom();
  }

  void clearPendingImage() {
    setState(() {
      _pendingImage = null;
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
      if (image == null) return;

      setState(() {
        _pendingImage = File(image.path);
      });
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Could not pick image: $e"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      setState(() => _isImageLoading = false);
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose source",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF2D2926),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _imageSourceOption(
                    icon: Icons.photo_library_outlined,
                    label: "Gallery",
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(source: ImageSource.gallery);
                    },
                  ),
                  _imageSourceOption(
                    icon: Icons.camera_alt_outlined,
                    label: "Camera",
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(source: ImageSource.camera);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5E6D3).withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: const Color(0xFF5D4E37)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D4E37),
              ),
            ),
          ],
        ),
      ),
    );
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (msg.containsKey("text"))
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
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
          if (msg.containsKey("image") && msg["image"] is File)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                msg["image"] as File,
                width: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 220,
                  height: 160,
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
                  ),
                ),
              ),
            ),
          if (msg.containsKey("product")) _buildProductCard(msg),
          if (msg.containsKey("time"))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                msg["time"],
                style: const TextStyle(fontSize: 12, color: Color(0xFF9F8E7F)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> msg) {
    final product = msg["product"];
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5DC),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Chat",
          style: TextStyle(
            color: Color(0xFF5D4E37),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: const SizedBox.shrink(),
      ),

      body: Column(
        children: [
          // Header with profile
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                // Back arrow
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF5D4E37)),
                  onPressed: () {
                    Navigator.pop(context); // go back when pressed
                  },
                ),

                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFFD4A574),
                  child: const Text("E",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Elena",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1D1B18))),
                      Text(
                        "Personal Stylist",
                        style: TextStyle(
                          fontSize: 12, 
                          color: Color(0xFF9F8E7F)
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline,
                      color: Color(0xFF5D4E37), size: 24),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg["isMe"] as bool;
                return chatBubble(msg, isMe);
              },
            ),
          ),

          // Image preview
          if (_pendingImage != null)
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
                    child: Image.file(_pendingImage!,
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
                  onPressed: _isImageLoading ? null : _showImagePickerOptions,
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
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send,
                      color: Color(0xFF5D4E37), size: 22),
                  onPressed: (_isComposing || _pendingImage != null)
                      ? sendMessage
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),

      // Glass bottom nav like homepage
      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }
}

