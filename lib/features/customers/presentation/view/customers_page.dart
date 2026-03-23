import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/core/responsive/size_config.dart';
import 'package:maadati/core/widgets/header.dart';
import 'package:maadati/core/widgets/header_actions_items.dart';
import 'package:maadati/features/customers/presentation/manager/customers_cubit.dart';
import 'package:maadati/features/customers/presentation/widget/customers_tabel.dart';
import 'package:maadati/features/customers/repo/customer_repo_impl.dart';
import '../../../../core/constants/app_color/app_color.dart';
import '../../../../core/constants/app_route/app_route.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/widgets/side_drawer.dart';
import '../manager/customers_state.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: drawerKey,
      drawer: SizedBox(width: 100,child: SideDrawer(currentRoute: AppRoute.customers),),
      appBar: !Responsive.isDesktop(context)?
      AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){drawerKey.currentState!.openDrawer();},
          icon: Icon(Icons.menu,color: AppColor.color4,),
        ),
        actions:  [
            HeaderActionItems(),
        ],
      ):
      const PreferredSize(
          preferredSize: Size.zero,
          child: SizedBox()
      ),
      body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(Responsive.isDesktop(context))
                const Expanded(
                    flex: 1,
                    child: SideDrawer(currentRoute: AppRoute.customers,)),
                Expanded(
                    flex: 10,
                    child: SafeArea(
                        child: SingleChildScrollView(
                          padding:  EdgeInsets.symmetric(horizontal: Responsive.isMobile(context)?20:40,vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Header(),
                              SizedBox(height: SizeConfig.blockSizeVertical*4,),
                              Text(
                                "Customers Management",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              BlocProvider(
                                  create: (_)=>CustomersCubit(CustomerRepoImpl(ApiService()))..getAllCustomers(),
                              child: BlocConsumer<CustomersCubit,CustomersState>(
                                  listener: (context, state) {
                                    if (state is CustomerStatusUpdated) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.message!)),
                                      );
                                    }

                                  },
                                  
                                  builder: (context,state){
                                    if (state is CustomersLoading) {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    if(state is CustomersError){
                                      return Center(
                                        child: Text(state.message),
                                      );
                                    }
                                    if(state is CustomersLoaded){
                                      return Padding(
                                          padding: const EdgeInsets.all(16),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: CustomersTabel(customers: state.customers),
                                      ),
                                      );
                                    }
                                    return const SizedBox();
                                  }),)

                            ],

                          ),
                        )))
            ],
          )),
    );
  }
}
