
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maadati/features/order/presentation/widget/order_item.dart';

class OrdersList extends StatelessWidget {
  final List orders;

  const OrdersList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
        
          const SizedBox(height: 20),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              return OrderItem(order: orders[index]);
            },
          ),
        ],
      ),
    );
  }
}
