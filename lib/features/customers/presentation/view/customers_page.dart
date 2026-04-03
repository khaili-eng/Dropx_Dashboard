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
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            buildStats(state), // 👈 الجديد
                                            SizedBox(height: 20),
                                            SizedBox(
                                              width: double.infinity,
                                              child: CustomersTabel(
                                                customers: state.customers,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  }),)

                            ],

                          ),
                        )),
                )
            ],
          )),
    );
  }
}

//widget for cards
Widget buildStats(CustomersLoaded state) {
  final total = state.customers.length;
  final active = state.customers.where((c) => c.isActive).length;
  final inactive = total - active;

  return Row(
    children: [
      buildCard("Total", total, Colors.blue),
      SizedBox(width: 20),
      buildCard("Active", active, Colors.green),
      SizedBox(width: 20),
      buildCard("Inactive", inactive, Colors.red),
    ],
  );
}
//widget card
Widget buildCard(String title, int count, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color)),
          SizedBox(height: 10),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}
