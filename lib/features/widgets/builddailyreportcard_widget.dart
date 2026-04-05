import 'package:flutter/material.dart';
import 'package:maadati/features/widgets/buildreportitem_widget.dart';

Widget buildDailyReportCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildReportItem("Total Orders", "25", Icons.shopping_bag, Colors.blue),
        buildReportItem("Profits", "500\$", Icons.attach_money, Colors.green),
      ],
    ),
  );
}
