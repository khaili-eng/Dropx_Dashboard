import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/features/order_det/presentation/widget/custom_text.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_cubit.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_status.dart';

class PromoCodeView extends StatelessWidget {
  const PromoCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Promo Code ", color: Colors.white),
        backgroundColor: AppColor.color3,
      ),
      body: BlocBuilder<PromoCodeCubit, PromoCodeStatus>(
        builder: (context, state) {
          if (state is PromoCodeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PromoCodeLodded) {
            final promoCodes = state.promoCode;
            return ListView.builder(
              itemCount: promoCodes.length,
              itemBuilder: (context, index) {
                final promo = promoCodes[index];
                return ListTile(
                  title: Text(promo.code),
                  subtitle: Text('Discount: ${promo.discountValue}%'),
                );
              },
            );
          } else if (state is PromoCodeError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}





  


//     return BlocProvider(
//       create: (context) => PromoCubit(PromoService())..getPromoCodes(),
//       child: Scaffold(
//         appBar: AppBar(title: Text('إدارة البرومو كودات')),
//         body: BlocConsumer<PromoCubit, PromoState>(
//           listener: (context, state) {
//             if (state is PromoAdded) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.message)),
//               );
//             } else if (state is PromoUpdated) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.message)),
//               );
//             } else if (state is PromoDeleted) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.message)),
//               );
//             } else if (state is PromoError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.error)),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is PromoLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is PromoLoaded) {
//               return ListView.builder(
//                 itemCount: state.promoCodes.length,
//                 itemBuilder: (context, index) {
//                   final promo = state.promoCodes[index];
//                   return ListTile(
//                     title: Text(promo.code),
//                     subtitle: Text('خصم: ${promo.discount}%'),
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                         context.read<PromoCubit>().deletePromoCode(promo.id);
//                       },
//                     ),
//                     onTap: () {
//                       // فتح صفحة التعديل
//                       _showEditDialog(context, promo);
//                     },
//                   );
//                 },
//               );
//             } else {
//               return Center(child: Text('لا توجد بيانات'));
//             }
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.add),
//           onPressed: () => _showAddDialog(context),
//         ),
//       ),
//     );
//   }
  
//   void _showAddDialog(BuildContext context) {
//     // نافذة لإضافة برومو كود جديد
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('إضافة برومو كود'),
//         content: AddPromoForm(),
//       ),
//     );
//   }
  
//   void _showEditDialog(BuildContext context, PromoCode promo) {
//     // نافذة لتعديل برومو كود
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('تعديل برومو كود'),
//         content: EditPromoForm(promoCode: promo),
//       ),
//     );
//   }
// }