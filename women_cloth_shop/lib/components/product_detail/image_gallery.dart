import 'package:flutter/material.dart';

class ImageGallery extends StatelessWidget {
  final List<String> images;
  final String selectedColor;

  const ImageGallery({
    super.key,
    required this.images,
    this.selectedColor = '',
  });

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

  /// Tries to find a color-variant image path.
  /// For example: "assets/images/dress1.jpg" + "Black" → "assets/images/dress1_black.png"
  String _getColorImagePath(String basePath, String color) {
    if (color.isEmpty) return basePath;

    final uri = Uri.file(basePath);
    final segments = uri.pathSegments;
    if (segments.length < 2) return basePath;

    final dir = segments.sublist(0, segments.length - 1).join('/');
    final fullName = segments.last;
    final dotIndex = fullName.lastIndexOf('.');
    if (dotIndex == -1) return basePath;
    final baseName = fullName.substring(0, dotIndex);

    // Build color variant path: {dir}/{baseName}_{color.toLowerCase()}.png
    final colorVariant = '$dir/$baseName${'_'}${color.toLowerCase()}.png';
    return colorVariant;
  }

  @override
  Widget build(BuildContext context) {
    final baseImagePath = images.isNotEmpty ? images.first : '';
    final colorImagePath = _getColorImagePath(baseImagePath, selectedColor);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
              child: Image.asset(
                colorImagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to original image if color variant does not exist
                  return _buildImage(baseImagePath);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
