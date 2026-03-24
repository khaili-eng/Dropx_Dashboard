import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/cubits/order_cubit.dart';
import 'package:maadati/core/cubits/restaurant_cubit.dart';
import 'package:maadati/features/widgets/builddailyreportcard_widget.dart';
import 'package:maadati/features/widgets/orderlist_widget.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;

  const RestaurantDetailsPage({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
  });

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  String selectedStatus = "pending";

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    final now = DateTime.now();
    final cubit = context.read<RestaurantCubit>();
    final order = context.read<OrderCubit>();

    cubit.getReports(
      restaurantId: widget.restaurantId,
      year: now.year,
      month: now.month,
    );

    order.getRestaurantOrdersByStatus(widget.restaurantId, selectedStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurantName),
        backgroundColor: AppColor.color4,
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_reset),
            onPressed: () => showResetPasswordDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daily Report",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            buildDailyReportCard(),

            const SizedBox(height: 30),

            const Text(
              "Order Management",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildStatusTabs(),
            const SizedBox(height: 15),
            buildOrdersList(),
          ],
        ),
      ),
    );
  }

  Widget buildStatusTabs() {
    List<String> statuses = ["pending", "accepted", "delivered", "canceled"];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedStatus == statuses[index];
          return GestureDetector(
            onTap: () {
              setState(() => selectedStatus = statuses[index]);
              _refreshData();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.color4 : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  statuses[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showResetPasswordDialog(BuildContext context) {
    final TextEditingController passController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Reset the password"),
            content: TextField(
              controller: passController,
              decoration: const InputDecoration(
                hintText: "Enter your password ",
              ),
              obscureText: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<RestaurantCubit>().resetRestaurantPassword(
                    widget.restaurantId,
                    passController.text,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("your password is updated")),
                  );
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }
}
