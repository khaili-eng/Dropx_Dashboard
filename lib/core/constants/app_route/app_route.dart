import 'package:flutter/cupertino.dart';
import 'package:maadati/features/advertesment/presentation/view/advertesment_page.dart';
import 'package:maadati/features/customers/presentation/view/customers_page.dart';
import 'package:maadati/features/dashboard/presentation/view/dashboard_page.dart';
import 'package:maadati/features/drivers/presentation/view/drivers_page.dart';

import '../../../features/auth/presentation/view/auth_page.dart';

class AppRoute{
static const String auth = '/';
static const String dashboard= '/dashboard';
static const String customers= '/customers';
static const String advertisement= '/advertisement';
static const String drivers= '/drivers';
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