import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/cubits/commission_cubit.dart';
import 'package:maadati/core/cubits/deliverysetting_cubit.dart';
import 'package:maadati/core/states/commission_state.dart';
import 'package:maadati/core/states/deliverysetting_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.restaurantId});

  final int restaurantId;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final pricePerKmController = TextEditingController();
  final minFeeController = TextEditingController();

  final commValueController = TextEditingController();
  String selectedType = 'percentage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.color1,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.color4,
        elevation: 0,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeliveryCubit, DeliveryState>(
            listener: (context, state) {
              if (state is DeliverySuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Updated delivery settings successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is DeliveryError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error${state.error}'),
                    backgroundColor: AppColor.color4,
                  ),
                );
              }
            },
          ),
          BlocListener<CommissionCubit, CommissionState>(
            listener: (context, state) {
              if (state is CommissionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Updated commission settings successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle('Delivery Settings'),
              _buildDeliveryCard(),
              const SizedBox(height: 24),
              buildSectionTitle('Commission Settings'),
              buildCommissionCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryCard() {
    return Card(
      color: AppColor.color2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTextField(
              pricePerKmController,
              'price per km',
              Icons.local_shipping,
            ),
            const SizedBox(height: 12),
            buildTextField(
              minFeeController,
              'minimum delivery fee',
              Icons.money,
            ),
            const SizedBox(height: 16),
            BlocBuilder<DeliveryCubit, DeliveryState>(
              builder: (context, state) {
                return state is DeliveryLoading
                    ? const CircularProgressIndicator()
                    : buildActionButton('Update Delivery Settings', () {
                      context.read<DeliveryCubit>().updateDeliverySettings(
                        token:
                            "11|6sfz4Z1jjSem2Z0oWUGb8YLknYDHnclUR9TsxYUEdccef799",
                        pricePerKm:
                            double.tryParse(pricePerKmController.text) ?? 0.0,
                        minimumDeliveryFee:
                            double.tryParse(minFeeController.text) ?? 0.0,
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCommissionCard() {
    return Card(
      color: AppColor.color2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: inputDecoration('Commission Type', Icons.category),
              items: const [
                DropdownMenuItem(
                  value: 'percentage',
                  child: Text('Percentage'),
                ),
                DropdownMenuItem(value: 'fixed', child: Text('Fixed Amount')),
              ],
              onChanged: (val) {
                setState(() {
                  selectedType = val!;
                });
              },
            ),
            const SizedBox(height: 12),
            buildTextField(
              commValueController,
              'Commission Value',
              Icons.add_chart,
              isNumber: true,
            ),
            const SizedBox(height: 16),
            BlocBuilder<CommissionCubit, CommissionState>(
              builder: (context, state) {
                return state is CommissionLoading
                    ? const CircularProgressIndicator()
                    : buildActionButton('Add Commission', () {
                      context.read<CommissionCubit>().addCommission(
                        restaurantId: widget.restaurantId,
                        type: selectedType,
                        value: int.tryParse(commValueController.text) ?? 0,
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.color4,
        ),
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isNumber = true,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: inputDecoration(label, icon),
    );
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColor.color4),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget buildActionButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.color4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
