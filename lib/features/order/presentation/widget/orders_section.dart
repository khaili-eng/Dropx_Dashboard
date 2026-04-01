import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/order/presentation/cubit/oder_stata.dart';
import 'package:maadati/features/order/presentation/cubit/order_cubit.dart';
import 'package:maadati/features/order/presentation/widget/ordersL_list.dart';

class OrdersSection extends StatelessWidget {
  const OrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrderError) {
          return Center(child: Text(state.message));
        } else if (state is OrderSuccess) {
          return OrdersList(orders: state.orders);
        }
        return const Center(child: Text("لا توجد طلبات حالياً"));
      },
    );
  }
}