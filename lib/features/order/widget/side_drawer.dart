import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/constants/app_route/app_route.dart';
import 'package:maadati/core/respo/size_config.dart';

class SideDrawer extends StatefulWidget {
  final String currentRoute;
  const SideDrawer({super.key, required this.currentRoute});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  void initState() {
    super.initState();
    switch (widget.currentRoute) {
      //   case AppRoute.dashboard:
      //     selectedIndex = 0;
      //     break;
      //   case AppRoute.customers:
      //     selectedIndex = 1;
      //     break;
      //   case AppRoute.advertisement:
      //     selectedIndex = 2;
      //     break;
      //   case AppRoute.drivers:
      //     selectedIndex = 3;
      //     break;
      case AppRoute.orders:
        selectedIndex = 4;
        break;
      //   case AppRoute.promoCode:
      //     selectedIndex=5;
      //     break;
      //   case AppRoute.fees:
      //     selectedIndex=6;
      //     break;
      //   case AppRoute.reports:
      //     selectedIndex=7;
      //     break;
      //   case AppRoute.settings:
      //     selectedIndex=8;
      //     break;
    }
  }

  void changePage(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, "AppRoute.dashboard");
        break;

      case 1:
        Navigator.pushReplacementNamed(context, "AppRoute.customers");
        break;

      case 2:
        Navigator.pushReplacementNamed(context, "AppRoute.advertisement");
        break;

      case 3:
        Navigator.pushReplacementNamed(context, "AppRoute.drivers");
        break;

      case 4:
        Navigator.pushReplacementNamed(context, AppRoute.orders);
        break;

      case 5:
        Navigator.pushReplacementNamed(context, AppRoute.fees);
        break;
      case 6:
        Navigator.pushReplacementNamed(context, "AppRoute.fees");
        break;
      case 7:
        Navigator.pushReplacementNamed(context, "AppRoute.reports");
        break;
      case 8:
        Navigator.pushReplacementNamed(context, "AppRoute.settings");
        break;
    }
  }

  int selectedIndex = 0;
  List<String> drawerItems = [
    'Dashboard',
    'Customers',
    'Advertisement',
    'Restaurant',
    'Drivers',
    'Orders',
    'PromoCode',
    'Fees',
    'Reports',
    'Settings',
  ];

  List<IconData> drawerIcons = [
    Icons.dashboard,
    Icons.people,
    Icons.campaign,
    Icons.restaurant,
    Icons.delivery_dining,
    Icons.card_travel_outlined,
    Icons.local_offer,
    Icons.attach_money,
    Icons.bar_chart,
    Icons.settings,
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: AppColor.color2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20),
                child: const Text(
                  "Maadati",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.color4,
                  ),
                ),
              ),
              ...List.generate(drawerItems.length, (index) {
                bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    changePage(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 4,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppColor.color2.withOpacity(0.15)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          drawerIcons[index],
                          color: isSelected ? AppColor.color4 : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
