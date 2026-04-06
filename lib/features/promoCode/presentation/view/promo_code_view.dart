import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/promoCode/data/datasources/remote_data_sorces.dart';
import 'package:maadati/features/promoCode/data/model/promo_code_model.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_cubit.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_status.dart';

class PromoCodePage extends StatefulWidget {
  const PromoCodePage({super.key});

  @override
  State<PromoCodePage> createState() => _PromoCodePageState();
}

class _PromoCodePageState extends State<PromoCodePage> {
  final TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    context.read<PromoCodeCubit>().getPromoCodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Promo Codes")),

      body: BlocConsumer<PromoCodeCubit, PromoCodeStatus>(
        listener: (context, state) {
          if (state is PromoCodeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }

          if (state is PromoCodeAdded ||
              state is PromoCodeDeleted ||
              state is PromoCodeUpdated) {
            context.read<PromoCodeCubit>().getPromoCodes();
          }
        },

        builder: (context, state) {
          if (state is PromoCodeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PromoCodeLodded) {
            final list = state.promoCode;

            return Column(
              children: [
                /// Add Promo Code
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: codeController,
                          decoration: const InputDecoration(
                            hintText: "Enter promo code",
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          final code = codeController.text;

                          if (code.isEmpty) return;

                          context.read<PromoCodeCubit>().addPromoCode(
                            PromoCodeModel(code: code),
                          );

                          codeController.clear();
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ),

                /// List
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final promo = list[index];

                      return ListTile(
                        title: Text(promo.code ?? ""),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// Update
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    final controller = TextEditingController(
                                      text: promo.code,
                                    );

                                    return AlertDialog(
                                      title: const Text("Update"),
                                      content: TextField(
                                        controller: controller,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<PromoCodeCubit>()
                                                .updatePromoCode(
                                                  promo.copyWith(
                                                    code: controller.text,
                                                  ),
                                                );

                                            Navigator.pop(context);
                                          },
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),

                            /// Delete
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context.read<PromoCodeCubit>().deletePromoCode(
                                  promo.id!,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text("No Data"));
        },
      ),
    );
  }
}
