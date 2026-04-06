import 'package:flutter/material.dart';
import 'package:maadati/features/admin_fees/presentation/view/fess_page.dart';

import 'package:maadati/features/order/presentation/view/order_page.dart';
import 'package:maadati/features/promoCode/presentation/view/promo_code_view.dart';

class AppRoute {
  static const String orders = '/orders';
  static const String promoCode = '/promoCode';
  static const String fees = '/fees';

  static Map<String, WidgetBuilder> routes = {
    orders: (context) => OrderPage(),
    promoCode: (context) => PromoCodePage(),
    fees: (context) => FessPage(),
  };
}
