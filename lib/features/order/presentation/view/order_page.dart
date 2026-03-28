import 'package:flutter/material.dart';
import 'package:maadati/core/respo/responsive.dart';
import 'package:maadati/core/respo/size_config.dart';
import 'package:maadati/features/order/widget/app_bar_widget.dart';
import 'package:maadati/features/order/widget/drawer_wrapper.dart';
import 'package:maadati/features/order/widget/layout_widget.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerKey = GlobalKey<ScaffoldState>();

    SizeConfig().init(context);

    return Scaffold(
      key: drawerKey,
      backgroundColor: Colors.white,
      drawer: const DrawerWrapper(),
      appBar:
          Responsive.isDesktop(context)
              ? null
              : OrderAppBar(drawerKey: drawerKey),
      body: const SafeArea(child: OrderLayout()),
    );
  }
}
