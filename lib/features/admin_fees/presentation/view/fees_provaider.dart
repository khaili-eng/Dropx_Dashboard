import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maadati/core/utils/service_locator.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_cubit.dart';
import 'package:maadati/features/admin_fees/presentation/view/fess_page.dart';

// شاشة رئيسية تحتوي على MultiBlocProvider
class MainScreenAdminFees extends StatelessWidget {
  const MainScreenAdminFees({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // تسجيل AdminFeesCubit من service_locator
        BlocProvider<AdminFeesCubit>(create: (context) => sl<AdminFeesCubit>()),
        // يمكنك إضافة المزيد من الـ Cubits هنا
        // BlocProvider<AnotherCubit>(
        //   create: (context) => sl<AnotherCubit>(),
        // ),
      ],
      child: const AdminFeesScreen(),
    );
  }
}
