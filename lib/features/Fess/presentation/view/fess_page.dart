import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

class FessPage extends StatelessWidget {
  const FessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Text(
              "قائمة الطلبات الحالية",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.color4,
              ),
            ),
            const SizedBox(height: 20),
            // يمكنك استخدام DataTable أو ListView.builder هنا
            ListView.separated(
              shrinkWrap: true, // مهم جداً داخل SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                // final order = orders[index];
                return ListTile(
                  leading: CircleAvatar(child: Text("mwk")),
                  title: Text("طلب من مطعم رقم: "),
                  subtitle: Text("التاريخ:  'غير متوفر'}"),
                  trailing: Text(
                    " ل.س",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
    );
  }
}