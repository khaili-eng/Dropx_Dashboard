import 'package:flutter/material.dart';

Widget buildReportItem(String label, String value, IconData icon, Color color) {
  return Column(
    children: [
      Icon(icon, color: color, size: 30),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      Text(
        value,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
