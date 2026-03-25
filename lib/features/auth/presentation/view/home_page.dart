import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/features/auth/presentation/view/Restaurant_Category.dart';
import 'package:maadati/features/auth/presentation/view/analis_page.dart';

import 'package:maadati/features/auth/presentation/view/order_page.dart'
    hide AppColor;
import 'package:maadati/features/auth/presentation/view/overview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "MADDATI",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: AppColor.color4,
            fontSize: 26,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: Container(
            height: 55,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TabBar(
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.color4,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.color4.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              tabs: const [
                Tab(icon: Icon(Icons.grid_view_rounded, size: 20)),
                Tab(icon: Icon(Icons.shopping_bag_rounded, size: 20)),
                Tab(icon: Icon(Icons.restaurant_rounded, size: 20)),
                Tab(icon: Icon(Icons.analytics, size: 20)),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          OverviewPage(),
          OrdersPage(),
          RestaurantsByCategoryPage(),
          ReportsPage(),
        ],
      ),
    );
  }
}
