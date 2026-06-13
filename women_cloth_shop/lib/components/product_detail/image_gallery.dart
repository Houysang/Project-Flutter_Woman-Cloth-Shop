import 'package:flutter/material.dart';

class ImageGallery extends StatelessWidget {
  final List<String> images;

  const ImageGallery({super.key, required this.images});

  Widget _buildImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[200],
            child: const Icon(Icons.image_not_supported),
          );
        },
      );
    } else {
      return Image.asset(path, fit: BoxFit.contain);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = images.isNotEmpty ? images.first : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 500,
            child: Center(
              child: _buildImage(imagePath),
            ),
          ),
        ),
      ),
    );
  }
}
