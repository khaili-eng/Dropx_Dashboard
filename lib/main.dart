import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/commission_api.dart';
import 'package:maadati/core/api/deliverysetting_api.dart';
import 'package:maadati/core/api/meal_api.dart';
import 'package:maadati/core/api/restaurant_api.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/constants/app_route/app_route.dart';
import 'package:maadati/core/constants/url.dart';
import 'package:maadati/core/cubits/commission_cubit.dart';
import 'package:maadati/core/cubits/deliverysetting_cubit.dart';
import 'package:maadati/core/cubits/meal_cubit.dart';
import 'package:maadati/core/cubits/order_cubit.dart';
import 'package:maadati/core/cubits/restaurantsDetails_cubit.dart';
import 'package:maadati/core/cubits/restaurant_cubit.dart';
import 'package:maadati/core/localization/locale_cubit.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:maadati/features/auth/presentation/view/analis_page.dart';
import 'package:maadati/features/auth/presentation/view/auth_page.dart';
import 'package:maadati/features/auth/presentation/view/overview_page.dart';
import 'package:maadati/features/auth/repo/auth_repo.dart';
import 'package:maadati/features/auth/repo/auth_repo_impl.dart';
import 'package:maadati/features/customers/presentation/view/customers_page.dart';
import 'package:maadati/features/dashboard/presentation/view/dashboard_page.dart';

void main() {
  final apiservice = ApiService();
  // final local = LocaleCubit();
  final api = RestaurantApi(
    baseUrl: baseUrl,
    token: "11|6sfz4Z1jjSem2Z0oWUGb8YLknYDHnclUR9TsxYUEdccef799",
  );

  final mealapi = MealApi(
    baseUrl: baseUrl,
    token: "11|6sfz4Z1jjSem2Z0oWUGb8YLknYDHnclUR9TsxYUEdccef799",
  );

  final deliveryApi = DeliverySettingApi(
    baseUrl: baseUrl,
    token: "11|6sfz4Z1jjSem2Z0oWUGb8YLknYDHnclUR9TsxYUEdccef799",
  );
  final commissionApi = CommissionApi(
    baseUrl: baseUrl,
    token: "11|6sfz4Z1jjSem2Z0oWUGb8YLknYDHnclUR9TsxYUEdccef799",
  );
  final AuthRepo authRepo = AuthRepoImpl(apiservice);

  runApp(
    MaddatiApp(
      api: api,
      mealApi: mealapi,
      deliveryApi: deliveryApi,
      commissionApi: commissionApi,
      authRepo: authRepo,
    ),
  );
}

class MaddatiApp extends StatelessWidget {
  final RestaurantApi api;
  final MealApi mealApi;
  final DeliverySettingApi deliveryApi;
  final CommissionApi commissionApi;
  final AuthRepo authRepo;

  const MaddatiApp({
    super.key,
    required this.api,
    required this.mealApi,
    required this.deliveryApi,
    required this.commissionApi,
    required this.authRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocaleCubit()..currentLocale),
        BlocProvider(create: (_) => AuthCubit(authRepo)),
        BlocProvider(create: (_) => RestaurantDetailsCubit(api)),
        BlocProvider(create: (_) => DeliveryCubit(deliveryApi)),
        BlocProvider(create: (_) => CommissionCubit(commissionApi)),
        BlocProvider(create: (_) => MealCubit(mealApi)),
        BlocProvider(create: (_) => OrderCubit(api)),
        BlocProvider(create: (_) => RestaurantCubit(api)..getAllRestaurants()),
      ],
      child: MaterialApp(
        initialRoute: AppRoute.auth,
        routes: {
          AppRoute.customers: (context) => const CustomersPage(),
          AppRoute.auth: (context) => const AuthPage(),
          AppRoute.dashboard: (context) => const DashboardPage(),
          AppRoute.overview: (context) => const OverviewPage(),
          AppRoute.reports: (context) => const ReportsPage(),
          //AppRoute.advertisement: (context) => const Advertisement(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Maddati',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: AppColor.color3,
          scaffoldBackgroundColor: AppColor.color1,
        ),
        // home: const AuthPage(),
      ),
    );
  }
}
