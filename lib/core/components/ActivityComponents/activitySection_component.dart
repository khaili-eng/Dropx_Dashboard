import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

class ActivitySection extends StatelessWidget {
  final List<dynamic> restaurants;

  const ActivitySection({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: AppColor.color4,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Administrative Log",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Color(0xFF2D3436),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // لوحة الأنشطة
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: restaurants.take(4).length,
          itemBuilder: (context, index) {
            // توزيع عشوائي لأنواع النشاط عشان يعطي شكل الداشبورد الحقيقي
            final List<Map<String, dynamic>> activityTypes = [
              {
                "type": "Update",
                "icon": Icons.edit_note,
                "color": Colors.orange,
              },
              {
                "type": "Security",
                "icon": Icons.shield_outlined,
                "color": Colors.blue,
              },
              {
                "type": "Revenue",
                "icon": Icons.analytics_outlined,
                "color": Colors.green,
              },
              {
                "type": "System",
                "icon": Icons.settings_input_component,
                "color": Colors.purple,
              },
            ];

            final activity = activityTypes[index % activityTypes.length];
            final r = restaurants[index];
            final adminName = r['user']?['fullname'] ?? 'Admin';

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.fromLTRB(40, 15, 15, 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${activity['type']} Action",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: activity['color'],
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "10:45 AM",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Administrator ($adminName) performed a ${activity['type'].toString().toLowerCase()} operation on the database.",
                          style: const TextStyle(
                            color: Color(0xFF636E72),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 0,
                    top: 15,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: activity['color'],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (activity['color'] as Color).withOpacity(
                              0.3,
                            ),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        activity['icon'],
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
