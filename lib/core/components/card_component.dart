import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maadati/core/components/cardInfo_component.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

class Card extends StatelessWidget {
  const Card({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.color4, AppColor.color3],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Weekly Revenue",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "+24%",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 12450),
                duration: const Duration(seconds: 2),
                builder: (context, value, child) {
                  return Text(
                    "\$${value.toInt()}",
                    style: const TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  CardInfo(label: "Orders", value: "1240"),
                  SizedBox(width: 30),
                  CardInfo(label: "Customers", value: "850"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
