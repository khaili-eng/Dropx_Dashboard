import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/network/dio_client.dart';
import 'package:maadati/core/api/promo_code_aoi.dart';
import 'package:maadati/features/promoCode/data/datasources/remote_data_sorces.dart';
import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_cubit.dart';
import 'package:maadati/features/promoCode/presentation/view/promo_code_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();
    return MaterialApp(
      home: BlocProvider(
        create: (_) => PromoCubit(PromoRemoteDataSource(dioClient.dio)),
        child: PromoCodePage(),
      ),
    );
  }
}
