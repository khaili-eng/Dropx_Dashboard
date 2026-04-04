import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_cubit.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_status.dart';

class FeePage extends StatefulWidget {
  const FeePage({super.key});

  @override
  State<FeePage> createState() => _FeePageState();
}

class _FeePageState extends State<FeePage> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AdminFeesCubit>().loadAll(selectedDate);
    });
  }

  void pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);

      context.read<AdminFeesCubit>().loadAll(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: pickDate,
          )
        ],
      ),
      body: BlocBuilder<AdminFeesCubit, AdminFeesState>(
        builder: (context, state) {
          if (state.error != null) {
            return Center(
              child: Text(
                state.error!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHeader(state.loading),

                const SizedBox(height: 16),

                Expanded(
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                    ),
                    children: [
                      _card(
                        "Driver Monthly",
                        state.driverMonthly,
                        Colors.blue,
                      ),
                      _card(
                        "Driver Daily",
                        state.driverDaily,
                        Colors.orange,
                      ),
                      _card(
                        "Restaurant Monthly",
                        state.restaurantMonthly,
                        Colors.green,
                      ),
                      _card(
                        "Restaurant Daily",
                        state.restaurantDaily,
                        Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(bool loading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        if (loading)
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        else
          ElevatedButton(
            onPressed: () {
              context.read<AdminFeesCubit>().loadAll(selectedDate);
            },
            child: const Text("Refresh"),
          )
      ],
    );
  }

  Widget _card(String title, double? value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          if (value == null)
            const CircularProgressIndicator()
          else
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}