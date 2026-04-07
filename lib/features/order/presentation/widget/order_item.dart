import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/order_det_api.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

import 'package:maadati/features/order_det/presentation/cubit/order_det_cubit.dart';
import 'package:maadati/features/order_det/presentation/view/order_page_details.dart';

import '../../../order_det/presentation/widget/custom_text.dart';

class OrderItem extends StatelessWidget {
  final dynamic order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => BlocProvider(
                  create:
                      (context) =>
                          OrderDetCubit(ApiServiceDet())
                            ..getOrderDetails(order.id),
                  child: const OrderPageDetails(),
                ),
          ),
        );
      },
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColor.color3,
              child: Text("${order.userId}"),
            ),
            SizedBox(width: 50),
            Column(
              children: [
                Row(
                  children: [
                    CustomText(text: "Order No: "),
                    SizedBox(width: 50),
                    CustomText(text: "${order.restaurantId}"),
                  ],
                ),
                CustomText(
                  text: "Created At: ${order.createdAt ?? "No Available"}",
                ),
                CustomText(text: "Status: ${order.status}"),

                Text(
                  "${order.totalPrice} SYP",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.color4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
