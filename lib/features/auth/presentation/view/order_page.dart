import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.color1,
        appBar: AppBar(
          title: const Text(
            'Live Orders',
            style: TextStyle(
              color: AppColor.color4,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: AppColor.color4,
            labelColor: AppColor.color4,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Active"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(context, "Active"),
            _buildOrderList(context, "Completed"),
            _buildOrderList(context, "Cancelled"),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, String status) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5, // مثال لعدد الطلبات
      itemBuilder: (context, index) {
        return _buildOrderCard(
          orderId: "#ORD-554${index + 1}",
          customer: "John Doe",
          items: "2x Beef Burger, 1x Large Fries",
          time: "10 mins ago",
          price: "\$45.00",
          statusColor: _getStatusColor(status),
          statusText: status,
        );
      },
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String customer,
    required String items,
    required String time,
    required String price,
    required Color statusColor,
    required String statusText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColor.color2, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderId,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColor.color2),

          // Body of the card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColor.color2,
                  child: Icon(Icons.person, color: AppColor.color4),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        items,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    color: AppColor.color4,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.color4,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Details"),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.color2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.print, color: Colors.brown),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return Colors.blue;
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return AppColor.color4;
      default:
        return Colors.grey;
    }
  }
}
