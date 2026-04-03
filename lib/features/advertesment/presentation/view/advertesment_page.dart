import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/core/widgets/header.dart';
import 'package:maadati/features/advertesment/data/model/adv_model.dart';
import 'package:maadati/features/advertesment/presentation/manager/adv_cubit.dart';
import 'package:maadati/features/advertesment/presentation/widget/create_ad_form.dart';
import 'package:maadati/features/advertesment/presentation/widget/update_adv_form.dart';
import 'package:maadati/features/advertesment/repo/adv_repo_impl.dart';

import '../../../../core/constants/app_color/app_color.dart';
import '../../../../core/constants/app_route/app_route.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/services/enum.dart';
import '../../../../core/widgets/header_actions_items.dart';
import '../../../../core/widgets/side_drawer.dart';
import '../widget/advertisement_list_section.dart';

class AdvertesmentPage extends StatefulWidget {
  const AdvertesmentPage({super.key});

  @override
  State<AdvertesmentPage> createState() => _AdvertesmentPageState();
}

class _AdvertesmentPageState extends State<AdvertesmentPage> {
  AdViewType selectedView = AdViewType.list;

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (_) => AdvCubit(AdvRepoImpl(ApiService()))..getAllAdv(),
      child: Scaffold(
        backgroundColor: Colors.white,
        key: drawerKey,
        drawer: !Responsive.isDesktop(context)
            ? SizedBox(
          width: 100,
          child: SideDrawer(currentRoute: AppRoute.advertisement),
        )
            : null,
        appBar: !Responsive.isDesktop(context)
            ? AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              drawerKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: AppColor.color4,
            ),
          ),
          actions: [
            HeaderActionItems(),
          ],
        )
            : const PreferredSize(
          preferredSize: Size.zero,
          child: SizedBox(),
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                const Expanded(
                  flex: 1,
                  child: SideDrawer(currentRoute: AppRoute.advertisement),
                ),
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: Responsive.isMobile(context) ? 20 : 40,
                      vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Header(),
                      SizedBox(height: SizeConfig.blockSizeVertical * 3),
                      Text(
                        "Advertisement Management",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
                      // ====== تحسين عرض أزرار التبديل ======
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedView = AdViewType.list;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                decoration: BoxDecoration(
                                  color: selectedView == AdViewType.list
                                      ? AppColor.color4
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "All Advertisements",
                                    style: TextStyle(
                                      color: selectedView == AdViewType.list
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedView = AdViewType.create;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                decoration: BoxDecoration(
                                  color: selectedView == AdViewType.create
                                      ? AppColor.color4
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Create Advertisement",
                                    style: TextStyle(
                                      color: selectedView == AdViewType.create
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 3),

                      buildContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    switch (selectedView) {
      case AdViewType.create:
        return const CreateAdForm();
      case AdViewType.list:
        return const AdsListSection();
    }
  }
}