import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maadati/core/constants/app_route/app_route.dart';
import 'package:maadati/core/localization/locale_cubit.dart';
import 'package:maadati/core/localization/locale_state.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/features/auth/presentation/view/auth_page.dart';
import 'package:maadati/features/drivers/presentation/manager/driver_cubit.dart';
import 'package:maadati/features/drivers/repo/driver_repo_impl.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => LocaleCubit(),
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        return BlocProvider(
          create: (_)=>DriverCubit(DriverRepoImpl(ApiService())),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Maadati',
            locale: context.read<LocaleCubit>().currentLocale,
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
      },
    );
  }
}