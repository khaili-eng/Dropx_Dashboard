import 'package:flutter/material.dart';

Widget buildOrdersList() {
  String selectedStatus = "pending";

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 3,
    itemBuilder: (context, index) {
      return Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.receipt)),
          title: Text("طلب رقم #${index + 101}"),
          subtitle: Text("الحالة: $selectedStatus"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      );
    },
  );
}
