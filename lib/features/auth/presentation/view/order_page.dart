import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

class OrdersManagementPage extends StatelessWidget {
  const OrdersManagementPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder:
          (context, i) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order #ID-92$i",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Pending",
                      style: TextStyle(
                        color: AppColor.color4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.color3,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Accept Order"),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
