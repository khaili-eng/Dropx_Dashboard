import 'package:flutter/material.dart';
import 'package:maadati/features/Fess/presentation/view/fess_page.dart';
import 'package:maadati/features/order/data/model/order_model.dart';
import 'package:maadati/features/order/presentation/view/order_page.dart';

class AppRoute {
  static const String orders = '/orders';
  static const String promoCode = '/promoCode';
  static const String fees = '/fees';

  static Map<String, WidgetBuilder> routes = {
    orders: (context) => OrderPage(),
    // promoCode: (context) => ,
    fees: (context) => FessPage(),
  };
}
