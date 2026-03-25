import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/constants/url.dart' as UrlConstants;
import 'package:maadati/core/cubits/order_cubit.dart';
import 'package:maadati/features/auth/presentation/view/restaurantdetails_page.dart';

class GridSection extends StatelessWidget {
  final List<dynamic> restaurants;

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

        final restaurantData = r['restaurant'];
        String? rawPath = restaurantData?['image'];

        int restaurantId =
            int.tryParse(restaurantData?['id'].toString() ?? '') ??
            int.tryParse(r['id'].toString()) ??
            0;
        String? finalImageUrl;
        if (rawPath != null && rawPath.isNotEmpty) {
          if (rawPath.startsWith('http')) {
            finalImageUrl = rawPath;
          } else {
            finalImageUrl = "${UrlConstants.baseUrl}/storage/$rawPath";
          }
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => BlocProvider.value(
                      value: context.read<OrderCubit>(),
                      child: RestaurantDetailsPage(
                        restaurantId: restaurantId,
                        restaurantName: fullname,
                        city: city,
                      ),
                    ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image:
                            finalImageUrl != null
                                ? NetworkImage(finalImageUrl)
                                : const AssetImage(
                                      'assets/images/restaurant-interior.jpg',
                                    )
                                    /*************الغلط هون************************/
                                    as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullname,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              city,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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
