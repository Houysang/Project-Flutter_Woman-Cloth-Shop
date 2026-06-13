import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/order.dart';
import '../models/order_store.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);

  @override
  Widget build(BuildContext context) {
    final orders = orderHistory;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F7F2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Order History",
          style: GoogleFonts.comfortaa(
            color: darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(
                "No orders yet",
                style: GoogleFonts.comfortaa(
                  color: Colors.black54,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                      // HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order #${order.id}",
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: darkText,
                            ),
                          ),
                          Text(
                            order.status.name,
                            style: GoogleFonts.comfortaa(
                              fontSize: 12,
                              color: order.status == OrderStatus.delivered
                                  ? Colors.green
                                  : Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // DATE
                      Text(
                        "${order.date.day}/${order.date.month}/${order.date.year}",
                        style: GoogleFonts.comfortaa(
                          fontSize: 11,
                          color: Colors.black45,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ITEMS
                      Column(
                        children: order.items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item.image,
                                    width: 45,
                                    height: 45,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: GoogleFonts.comfortaa(
                                      fontSize: 13,
                                      color: darkText,
                                    ),
                                  ),
                                ),
                                Text(
                                  "x${item.quantity}",
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                      const Divider(),

                      // TOTAL
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                          Text(
                            "\$${order.totalPrice.toStringAsFixed(2)}",
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.bold,
                              color: accent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
