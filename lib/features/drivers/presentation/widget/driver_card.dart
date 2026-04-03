import 'package:flutter/material.dart';

import '../../data/model/driver_item_model.dart';

class DriverCard extends StatelessWidget {
  final DriverItemModel data;

  const DriverCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final driver = data.driver;
    final user = data.user;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade600,
          child: Text(user.fullName[0].toUpperCase()),
        ),

        title: Text(
          user.fullName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text("📞 ${user.phone}"),
            Text("🚗 ${driver.vehicletype} - ${driver.vehiclenumber}"),
            Text(
              driver.isActive ? "🟢 Active" : "🔴 Inactive",
              style: TextStyle(
                color: driver.isActive ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.orange),
          onPressed: () {},
        ),
      ),
    );
  }
}