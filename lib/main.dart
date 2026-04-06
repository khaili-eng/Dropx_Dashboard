import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/utils/pref_helper.dart';
import 'package:maadati/features/auth/data/model/user_mpdel.dart';
import 'package:maadati/features/order/presentation/cubit/order_cubit.dart';
import 'package:maadati/features/promoCode/data/datasources/remote_data_sorces.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_cubit.dart';
import 'package:maadati/features/promoCode/presentation/view/promo_code_view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maadati/core/constants/app_route/app_route.dart';
import 'package:maadati/core/localization/locale_cubit.dart';
import 'package:maadati/core/localization/locale_state.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/features/auth/presentation/view/auth_page.dart';
import 'package:maadati/features/drivers/presentation/manager/driver_cubit.dart';
import 'package:maadati/features/drivers/repo/driver_repo_impl.dart';

import 'core/api/commission_api.dart';
import 'core/api/deliverysetting_api.dart';
import 'core/api/meal_api.dart';
import 'core/api/restaurant_api.dart';
import 'core/cubits/commission_cubit.dart';
import 'core/cubits/deliverysetting_cubit.dart';
import 'core/cubits/meal_cubit.dart';
import 'core/cubits/restaurant_cubit.dart';
import 'core/cubits/restaurantsDetails_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final token = await PrefHelper.getToken();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => LocaleCubit(),
        ),

      ],
      child:  MyApp(token:token),
    ),
  );
}



class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token}
 );

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, locale) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => DriverCubit(DriverRepoImpl(ApiService())),),
              BlocProvider(create: (_) => RestaurantDetailsCubit(RestaurantApi(baseUrl: "http://127.0.0.1:8000/api" ,token: token??""))),
              BlocProvider(create: (_) => DeliveryCubit(DeliverySettingApi(Dio()))),
              BlocProvider(create: (_) => CommissionCubit(CommissionApi(baseUrl:  "http://127.0.0.1:8000/api",token: token??""))),
              BlocProvider(create: (_) => MealCubit(MealApi(Dio()))),

              BlocProvider(create: (_) => RestaurantCubit(RestaurantApi(baseUrl: "http://127.0.0.1:8000/api",token: token??""))..getAllRestaurants()),
          BlocProvider(
          create:
          (context) =>
          PromoCodeCubit(RemoteDataSorcesImpl())
          ..remoteDataSorcesImpl.getPromoCodes(),),

            ],

            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Maadati',
              locale: context
                  .read<LocaleCubit>()
                  .currentLocale,
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              initialRoute: AppRoute.auth,
              routes: AppRoute.routes,
            ),
          );
        });

  }
}
