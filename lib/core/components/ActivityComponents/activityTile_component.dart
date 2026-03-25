import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

class ActivityTile extends StatelessWidget {
  final String name;
  final String action;
  final String time;
  final bool done;

  const ActivityTile({
    super.key,
    required this.name,
    required this.action,
    required this.time,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.color2),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: done ? Colors.green[50] : Colors.orange[50],
            child: Icon(
              done ? Icons.check_circle : Icons.access_time,
              color: done ? Colors.green : Colors.orange,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  action,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
