import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/commission_api.dart';
import 'package:maadati/core/api/deliverysetting_api.dart';
import 'package:maadati/core/api/meal_api.dart';
import 'package:maadati/core/api/restaurant_api.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/constants/url.dart';
import 'package:maadati/core/cubits/commission_cubit.dart';
import 'package:maadati/core/cubits/deliverysetting_cubit.dart';
import 'package:maadati/core/cubits/meal_cubit.dart';
import 'package:maadati/core/cubits/order_cubit.dart';
import 'package:maadati/core/cubits/restaurantsDetails_cubit.dart';
import 'package:maadati/core/cubits/restaurant_cubit.dart';
import 'package:maadati/features/auth/presentation/view/home_page.dart';

void main() {
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

  runApp(
    MaddatiApp(
      api: api,
      mealApi: mealapi,
      deliveryApi: deliveryApi,
      commissionApi: commissionApi,
    ),
  );
}

class MaddatiApp extends StatelessWidget {
  final RestaurantApi api;
  final MealApi mealApi;
  final DeliverySettingApi deliveryApi;
  final CommissionApi commissionApi;

  const MaddatiApp({
    super.key,
    required this.api,
    required this.mealApi,
    required this.deliveryApi,
    required this.commissionApi,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RestaurantDetailsCubit(api)),
        BlocProvider(create: (_) => DeliveryCubit(deliveryApi)),
        BlocProvider(create: (_) => CommissionCubit(commissionApi)),
        BlocProvider(create: (_) => MealCubit(mealApi)),
        BlocProvider(create: (_) => OrderCubit(api)),
        BlocProvider(create: (_) => RestaurantCubit(api)..getAllRestaurants()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maddati',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: AppColor.color3,
          scaffoldBackgroundColor: AppColor.color1,
        ),
        home: const HomePage(),
      ),
    );
  }
}
