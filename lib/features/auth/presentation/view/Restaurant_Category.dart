import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

class RestaurantsByCategoryPage extends StatefulWidget {
  const RestaurantsByCategoryPage({super.key});
  @override
  State<RestaurantsByCategoryPage> createState() =>
      _RestaurantsByCategoryPageState();
}

class _RestaurantsByCategoryPageState extends State<RestaurantsByCategoryPage> {
  String selected = "All";
  final cats = ["All", "Pizza", "Burgers", "Oriental", "Sweets"];
  final List<String> restaurantImages = [
    "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500&q=80",
    "https://images.unsplash.com/photo-1552566626-52f8b828add9?w=500&q=80",
    "https://images.unsplash.com/photo-1537047902294-62a40c20a6ae?w=500&q=80",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: cats.length,
            itemBuilder: (context, i) {
              bool isSel = selected == cats[i];
              return GestureDetector(
                onTap: () => setState(() => selected = cats[i]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: isSel ? AppColor.color4 : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow:
                        isSel
                            ? [
                              BoxShadow(
                                color: AppColor.color4.withOpacity(0.3),
                                blurRadius: 10,
                              ),
                            ]
                            : [],
                  ),
                  child: Center(
                    child: Text(
                      cats[i],
                      style: TextStyle(
                        color: isSel ? Colors.white : Colors.black87,
                        fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: restaurantImages.length,
            itemBuilder: (context, i) => _buildModernRestaurantCard(i),
          ),
        ),
      ],
    );
  }

  Widget _buildModernRestaurantCard(int i) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            child: Stack(
              children: [
                Image.network(
                  restaurantImages[i],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "The Golden Grill",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "4.9 (120 reviews)",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.color2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Open",
                    style: TextStyle(
                      color: AppColor.color3,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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
}
