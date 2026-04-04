// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maadati/core/api/network/api_constants.dart';
// import 'package:maadati/core/api/network/dio_client.dart';
// import 'package:maadati/core/api/order_api.dart';
// import 'package:maadati/core/utils/service_locator.dart';
// import 'package:maadati/features/admin_fees/data/datasources/admin_fees_remote_data_source.dart';
// import 'package:maadati/features/admin_fees/data/repositories/admin_fees_repository_impl.dart';
// import 'package:maadati/features/admin_fees/domain/usecases/get_admin_daily_earnings_from_restaurants.dart';
// import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_cubit.dart';
// import 'package:maadati/features/admin_fees/presentation/view/fess_page.dart';

// import 'package:maadati/features/order/presentation/cubit/order_cubit.dart';
// import 'package:maadati/features/order/presentation/view/order_page.dart';

// void main()  {
//     final token = "PUT_YOUR_TOKEN";
//       final dio = DioClient(token).dio;
//   final remote = FeeRemoteDataSource(dio);
//   final repo = FeeRepositoryImpl(remote);
//   final usecase = GetFees(repo);

//   runApp(MyApp(usecase));
// }

// class MyApp extends StatelessWidget {
//     final GetFees usecase;
//   const MyApp(GetFees usecase, {super.key, required this.usecase });

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Maadati',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home:        MultiBlocProvider(
//         providers: [
//           BlocProvider<AdminFeesCubit>(create: (context) => sl<AdminFeesCubit>(),),],

//         // create: (context) {
//         //   final api = ApiConstants();
//         //   return AdminFeesCubit(
//         //     getMonthlyFeesFromDriver: api.getAdminMonthlyFeesFromDriver,
//         //     getDailyFeesFromDriver: api.getAdminDailyFeesFromDriver,
//         //     getDailyEarningsFromRestaurants: api.getAdminDailyEarningsFromRestaurants,
//         //     getMonthlyEarningsFromRestaurants: api.getAdminMonthlyEarningsFromRestaurants,
//         //   );
//         // },
//         child: AdminFeesScreen(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/network/dio_client.dart';
import 'package:maadati/features/admin_fees/data/datasources/admin_fees_remote_data_source.dart';
import 'package:maadati/features/admin_fees/data/repositories/admin_fees_repository_impl.dart';
import 'package:maadati/features/admin_fees/domain/usecases/get_admin_daily_earnings_from_restaurants.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_cubit.dart';
import 'package:maadati/features/admin_fees/presentation/view/fess_page.dart';

void main() {
  final token = "2|Z0qsMsh3cSKEfHii1MdThgU0yhhiZk9FWqJX9pi0eb6180c0";

  final dio = DioClient(token).dio;
  final remote = FeeRemoteDataSource(dio);
  final repo = FeeRepositoryImpl(remote);
  final usecase = GetFees(repo);

  runApp(MyApp(usecase));
}

class MyApp extends StatelessWidget {
  final GetFees usecase;

  const MyApp(this.usecase);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(create: (_) => AdminFeesCubit(usecase), child: FeePage()),
    );
  }
}
