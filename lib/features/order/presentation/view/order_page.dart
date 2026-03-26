// ... (المكتبات المستوردة السابقة)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/constants/app_route/app_route.dart';
import 'package:maadati/core/respo/responsive.dart';
import 'package:maadati/core/respo/size_config.dart';
import 'package:maadati/features/order/presentation/cubit/oder_stata.dart';
import 'package:maadati/features/order/widget/hedeer.dart';
import 'package:maadati/features/order/widget/side_drawer.dart';
import '../cubit/order_cubit.dart'; // تأكد من المسار الصحيح

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPage();
}

class _OrderPage extends State<OrderPage> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: drawerKey,
      drawer: SizedBox(
        width: 100,
        child: SideDrawer(currentRoute: "AppRoute.dashboard"),
      ),
      appBar:
          !Responsive.isDesktop(context)
              ? AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () => drawerKey.currentState!.openDrawer(),
                  icon: Icon(Icons.menu, color: AppColor.color4),
                ),
              )
              : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                flex: 1,
                child: SideDrawer(
                  currentRoute: AppRoute.orders,
                ), // تفعيل السايد بار
              ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 20 : 40,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Header(),
                    SizedBox(height: SizeConfig.blockSizeVertical * 4),

                    // --- بداية قسم عرض الأوردرات في المنتصف ---
                    BlocBuilder<OrderCubit, OrderState>(
                      builder: (context, state) {
                        if (state is OrderLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is OrderError) {
                          return Center(child: Text(state.message));
                        } else if (state is OrderSuccess) {
                          return _buildOrdersList(state.orders);
                        }
                        return const Center(
                          child: Text("لا توجد طلبات حالياً"),
                        );
                      },
                    ),
                    // --- نهاية قسم عرض الأوردرات ---
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت لبناء القائمة
  Widget _buildOrdersList(List orders) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Text(
            "قائمة الطلبات الحالية",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.color4,
            ),
          ),
          const SizedBox(height: 20),
          // يمكنك استخدام DataTable أو ListView.builder هنا
          ListView.separated(
            shrinkWrap: true, // مهم جداً داخل SingleChildScrollView
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                leading: CircleAvatar(child: Text("${order.id}")),
                title: Text("طلب من مطعم رقم: ${order.restaurantId}"),
                subtitle: Text("التاريخ: ${order.createdAt ?? 'غير متوفر'}"),
                trailing: Text(
                  "${order.totalPrice} ل.س",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
