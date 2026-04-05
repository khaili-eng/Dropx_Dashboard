import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/promoCode/data/datasources/remote_data_sorces.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_cubit.dart';
import 'package:maadati/features/promoCode/presentation/view/promo_code_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create:
            (context) =>
                PromoCodeCubit(RemoteDataSorcesImpl())
                  ..remoteDataSorcesImpl.getPromoCodes(),
        child: PromoCodeView(),
      ),
    );
  }
}
