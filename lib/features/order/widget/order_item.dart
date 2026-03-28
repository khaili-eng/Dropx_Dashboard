import 'package:flutter/material.dart';
import 'package:maadati/features/order/presentation/view/order_page_details.dart';

class OrderItem extends StatelessWidget {
  final dynamic order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const OrderPageDetails(),
          ),
        );
      },
      leading: CircleAvatar(child: Text("${order.id}")),
      title: Text("طلب من مطعم رقم: ${order.restaurantId}"),
      subtitle: Text("التاريخ: ${order.createdAt ?? 'غير متوفر'}"),
      trailing: Text(
        "${order.totalPrice} ل.س",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}