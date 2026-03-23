import 'package:flutter/material.dart';

import '../../../../core/constants/app_color/app_color.dart';
import '../../../../core/constants/app_route/app_route.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/widgets/header.dart';
import '../../../../core/widgets/side_drawer.dart';

class DashboardPage extends StatefulWidget {

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: drawerKey,
      drawer: SizedBox(width: 100,child: SideDrawer(currentRoute: AppRoute.dashboard),),
        appBar: !Responsive.isDesktop(context)?
        AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){drawerKey.currentState!.openDrawer();},
            icon: Icon(Icons.menu,color: AppColor.color4,),
          ),
          actions:  [

          ],
        ):
        const PreferredSize(
            preferredSize: Size.zero,
            child: SizedBox()
        ),
               body: SafeArea(child: Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    if(Responsive.isDesktop(context))
      Expanded(
          flex: 1,
          child: SideDrawer(currentRoute: AppRoute.dashboard)),
    Expanded(
        flex:10,
        child: SafeArea(
            child: SingleChildScrollView(
              padding:  EdgeInsets.symmetric(horizontal: Responsive.isMobile(context)?20:40,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const  Header(),
                  SizedBox(height: SizeConfig.blockSizeVertical*4,),
                  //for transfor info


                ],
              ),
            ))),
  ],
)),
    );
  }
}
