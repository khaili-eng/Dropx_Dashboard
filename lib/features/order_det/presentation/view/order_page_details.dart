import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/order_det_api.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/features/order_det/presentation/cubit/order_det_cubit.dart';
import 'package:maadati/features/order_det/presentation/cubit/order_det_state.dart';
import 'package:maadati/features/order_det/presentation/widget/custom_text.dart';

class OrderPageDetails extends StatelessWidget {
  const OrderPageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetCubit(ApiServiceDet())..getOrderDetails(1),
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
              text: "Leave a Review",
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<OrderDetCubit, OrderDetState>(
          builder: (context, state) {
            if (state is OrderDetLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is OrderError) {
              return Center(child: Text(state.message));
            }

            if (state is OrderDetSuccess) {
              final order = state.order;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    CustomText(
                      text:
                          "${order.user.fullname} - ${order.restaurant.userId}",
                      color: Colors.black,
                      size: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.blue),
                        SizedBox(height: 20),
                        CustomText(text: order.user.phone, color: Colors.white),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: "${order.totalPrice} - ${order.deliveryAddress} ",
                      color: Colors.black,
                      size: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: "${order.deliveryFee}",
                      color: Colors.black,
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: "Key Features",
                      color: Colors.black,
                      size: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 20),

                    SizedBox(height: 20),
                    CustomText(
                      text: "${order.barcode}",
                      color: Colors.black,
                      size: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: "${order.notes}",
                      color: Colors.black,
                      size: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                
                      children: [
                        CustomText(
                          text: "Customer Reviews",
                          color: Colors.black,
                          size: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "See All ",
                          color: Colors.orange,
                          size: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
