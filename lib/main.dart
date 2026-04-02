import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/order_api.dart';
import 'package:maadati/features/fees/presentation/manager/admin_fees_cubit.dart';
import 'package:maadati/features/fees/presentation/view/fess_page.dart';

import 'package:maadati/features/order/presentation/cubit/order_cubit.dart';
import 'package:maadati/features/order/presentation/view/order_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maadati',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        // create: (context) => OrderCubit(ApiService())..getAllOrders(),
        create: (context) => AdminFeesCubit(),
        child: AdminFeesScreen(),
      ),
    );
  }
}
