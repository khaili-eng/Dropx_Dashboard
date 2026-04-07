import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_cubit.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_status.dart';

class PromoCodePage extends StatefulWidget {
  const PromoCodePage({super.key});

  @override
  State<PromoCodePage> createState() => _PromoCodePageState();
}

class _PromoCodePageState extends State<PromoCodePage> {
  @override
  void initState() {
      print("INIT STATE");
    super.initState();
    context.read<PromoCubit>().getPromo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Promo Codes")),
      body: BlocConsumer<PromoCubit, PromoState>(
        listener: (context, state) {
          if (state is PromoError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is PromoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PromoLoaded) {
            if (state.data.isEmpty) {
              return const Center(child: Text("No Promo Codes"));
            }

            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final promo = state.data[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(promo.code),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Type: ${promo.discountType}"),
                        Text("Value: ${promo.discountValue}"),
                        Text("Min: ${promo.minOrderValue}"),
                        Text("Uses: ${promo.maxUses}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<PromoCubit>().deletePromo(promo.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("No Data"));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showAddDialog(BuildContext context) {
  final codeController = TextEditingController();
  final valueController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Promo Code"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: "Code"),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Value"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final promo = PromoCode(
                id: 0,
                code: codeController.text,
                discountType: "percentage",
                discountValue: double.parse(valueController.text),
                minOrderValue: 0,
                maxUses: 10,
                expiryDate: DateTime.now(),
                isActive: true,
              );

              context.read<PromoCubit>().addPromo(promo);

              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}
