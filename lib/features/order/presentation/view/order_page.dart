import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/order_api.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

import 'package:maadati/core/respo/size_config.dart';
import 'package:maadati/features/order/presentation/cubit/order_cubit.dart';

import 'package:maadati/features/order/presentation/widget/order_content.dart';
import 'package:maadati/features/order_det/presentation/widget/custom_text.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerKey = GlobalKey<ScaffoldState>();

    SizeConfig().init(context);

    return BlocProvider(
      create: (_)=>OrderCubit(ApiService()),
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          toolbarHeight: 150,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          backgroundColor: AppColor.color4,
          title: Center(
            child: CustomText(
              text: "My Orders",
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        key: drawerKey,
        backgroundColor: Colors.white,
      
        body: const SafeArea(child: OrderContent()),
      ),
    );
  }
}
