import 'package:flutter/material.dart';

class FloatingChatButton extends StatelessWidget {
  const FloatingChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/chat'),
      heroTag: 'chat_button',
      backgroundColor: const Color(0xFF5D4E37),
      foregroundColor: Colors.white,
      elevation: 6,
      child: const Icon(Icons.chat_bubble_outline_rounded, size: 24),
    );
  }
}