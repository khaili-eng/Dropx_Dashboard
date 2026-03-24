import 'package:flutter/material.dart';
import 'package:maadati/features/auth/presentation/view/restaurantdetails_page.dart';

class GridSection extends StatelessWidget {
  final List<dynamic> restaurants;
  //final imageUrl = "https://images.unsplash.com/photo-1555396273-367ea4eb4db5";

  const GridSection({super.key, required this.restaurants});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: restaurants.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final r = restaurants[index];
        final user = r['user'];

        final fullname = user?['fullname'] ?? 'No Name';

        final city =
            (user?['areas'] != null && user['areas'].isNotEmpty)
                ? user['areas'][0]['city']
                : 'No City';

        String? imageUrl = r['image'];

        if (imageUrl != null && imageUrl.isNotEmpty) {
          if (!imageUrl.startsWith('http')) {
            //  imageUrl = "$baseUrl/storage/$imageUrl";
            print(
              "********************************" +
                  imageUrl +
                  "********************************",
            );
          }
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => RestaurantDetailsPage(
                      restaurantId: r['id'] ?? 0,
                      restaurantName: fullname,
                    ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image:
                            imageUrl != null
                                ? NetworkImage(imageUrl)
                                : const AssetImage(
                                      'assets/images/splashscreen.png',
                                    )
                                    as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        fullname,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(city, style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
