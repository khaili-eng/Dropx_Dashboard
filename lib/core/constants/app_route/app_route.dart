
import 'package:flutter/cupertino.dart';
import 'package:maadati/features/advertesment/presentation/view/advertesment_page.dart';
import 'package:maadati/features/customers/presentation/view/customers_page.dart';
import 'package:maadati/features/dashboard/presentation/view/dashboard_page.dart';
import 'package:maadati/features/drivers/presentation/view/drivers_page.dart';
import 'package:maadati/features/admin_fees/presentation/view/fess_page.dart';
import 'package:maadati/features/order/presentation/view/order_page.dart';
import 'package:maadati/features/promocode/presentation/view/promo_code_view.dart';
import 'package:maadati/features/views/analis_page.dart';
import 'package:maadati/features/views/overview_page.dart';
import '../../../features/auth/presentation/view/auth_page.dart';
import '../../../features/promoCode/presentation/view/promo_code_view.dart';

class AppRoute{
static const String auth = '/';
static const String dashboard= '/dashboard';
static const String customers= '/customers';
static const String advertisement= '/advertisement';
static const String drivers= '/drivers';
static const String overview= '/overview';
static const String orders= '/orders';
static const String promoCode= '/promoCode';
static const String fees = '/fees';
static const String reports = '/reports';
static const String settings = '/settings';

static Map<String,WidgetBuilder> routes = {
  auth: (context)=>AuthPage(),
  dashboard:(context)=>DashboardPage(),
  customers:(context)=>CustomersPage(),
  advertisement:(context)=>AdvertesmentPage(),
  drivers:(context)=>DriversPage(),
  overview:(context)=>OverviewPage(),
  orders: (context) => OrderPage(),
  promoCode: (context) =>PromoCodeView() ,
  reports:(context)=>ReportsPage(),
  fees: (context) => FessPage(),
//  dashboard:(context)=>DashboardPage(),
 // customers:(context)=>ClientPage(),
  //advertisement:(context)=>ProjectPage(),
  //drivers:(context)=>ProjectPage(),
  //orders:(context)=>ProjectPage(),
  //promoCode:(context)=>ProjectPage(),
  //fees:(context)=>ProjectPage(),
  //reports:(context)=>ProjectPage(),
  //settings:(context)=>ProjectPage(),
  // clientProfile:(context)=>ClientProfileDialog(client: client),
};


}
