import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

Widget buildRestaurantCard(int i) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            image: DecorationImage(
              image: NetworkImage('https://picsum.photos/400/200?sig=$i'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ListTile(
          title: const Text(
            "Premium Restaurant Name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(" • ⭐ 4.9"),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: AppColor.color3,
          ),
        ),
      ],
    ),
  );
}
