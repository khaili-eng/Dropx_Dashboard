import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_route/app_route.dart';
import 'package:maadati/features/order/widget/side_drawer.dart';

class DrawerWrapper extends StatelessWidget {
  const DrawerWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      child: SideDrawer(currentRoute: AppRoute.orders),
    );
  }
}