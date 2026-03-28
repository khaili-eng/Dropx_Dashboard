import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_route/app_route.dart' show AppRoute;
import 'package:maadati/core/respo/responsive.dart';
import 'package:maadati/features/order/widget/order_content.dart';
import 'package:maadati/features/order/widget/side_drawer.dart';

class OrderLayout extends StatelessWidget {
  const OrderLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (Responsive.isDesktop(context))
          const Expanded(
            flex: 1,
            child: SideDrawer(currentRoute: AppRoute.orders),
          ),

        const Expanded(
          flex: 10,
          child: OrderContent(),
        ),
      ],
    );
  }
}