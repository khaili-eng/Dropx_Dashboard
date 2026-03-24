import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/restaurant_api.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/constants/url.dart';
import 'package:maadati/features/auth/presentation/view/home_page.dart';
import 'package:maadati/core/cubits/restaurant_cubit.dart';

void main() {
  final api = RestaurantApi(
    baseUrl: baseUrl,
    token: "11|6sfz4Z1jjSem2Z0oWUGb8YLknYDHnclUR9TsxYUEdccef799",
  );

  runApp(MaddatiApp(api: api));
}

class MaddatiApp extends StatelessWidget {
  final RestaurantApi api;

  const MaddatiApp({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
