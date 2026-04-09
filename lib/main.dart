import 'package:flutter/material.dart';


import 'package:maadati/core/utils/service_locator.dart';

import 'package:maadati/features/admin_fees/presentation/view/fees_provaider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: MainScreenAdminFees(),
    );
  }
}
