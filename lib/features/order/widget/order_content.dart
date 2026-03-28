import 'package:flutter/material.dart';
import 'package:maadati/core/respo/responsive.dart';
import 'package:maadati/core/respo/size_config.dart';
import 'package:maadati/features/order/widget/hedeer.dart';
import 'package:maadati/features/order/widget/orders_section.dart';

class OrderContent extends StatelessWidget {
  const OrderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 20 : 40,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(),
          SizedBox(height: SizeConfig.blockSizeVertical * 4),
          const OrdersSection(),
        ],
      ),
    );
  }
}