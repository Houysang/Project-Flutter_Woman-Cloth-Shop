import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/customer_review.dart';

class CustomerReviews extends StatelessWidget {
  final List<CustomerReview> reviews;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  const CustomerReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Reviews',
          style: GoogleFonts.comfortaa(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
        const SizedBox(height: 14),
        ...reviews.map((review) => _buildReviewCard(review)),
      ],
    );
  }

  Widget _buildReviewCard(CustomerReview review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile image
            CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(review.profileImage),
              backgroundColor: accent.withOpacity(0.2),
            ),
            const SizedBox(width: 12),
            // Name + stars + feedback
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review.customerName,
                        style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                        ),
                      ),
                      _buildStars(review.rating),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    review.feedback,
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      color: Colors.black54,
                      height: 1.45,
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

  Widget _buildStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Icon(
          i + 1 <= rating.round()
              ? Icons.star
              : i + 0.5 <= rating
                  ? Icons.star_half
                  : Icons.star_border,
          size: 14,
          color: const Color(0xFFFFB800),
        );
      }),
    );
  }
}