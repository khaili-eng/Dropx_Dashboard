import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_cubit.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_status.dart';

class AdminFeesScreen extends StatefulWidget {
  const AdminFeesScreen({super.key});

  @override
  State<AdminFeesScreen> createState() => _AdminFeesScreenState();
}

class _AdminFeesScreenState extends State<AdminFeesScreen> {
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Fees Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Driver Monthly'),
              Tab(text: 'Driver Daily'),
              Tab(text: 'Restaurant Daily'),
              Tab(text: 'Restaurant Monthly'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // تبويب 1: رسوم السائقين الشهرية
            buildDriverMonthlyTab(),

            // تبويب 2: رسوم السائقين اليومية
            buildDriverDailyTab(),

            // تبويب 3: أرباح المطاعم اليومية
            buildRestaurantDailyTab(),

            // تبويب 4: أرباح المطاعم الشهرية
            buildRestaurantMonthlyTab(),
          ],
        ),
      ),
    );
  }

  Widget buildDriverMonthlyTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Year (e.g., 2025)',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _monthController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Month (1-12)'),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final year = int.tryParse(_yearController.text);
                  final month = int.tryParse(_monthController.text);
                  if (year != null && month != null) {
                    context.read<AdminFeesCubit>().fetchMonthlyDriverFees(
                      year,
                      month,
                    );
                  }
                },
                child: const Text('Load'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<AdminFeesCubit, AdminFeesState>(
              builder: (context, state) {
                if (state is DriverFeesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DriverFeesLoaded) {
                  return ListView.builder(
                    itemCount: state.fees.length,
                    itemBuilder: (context, index) {
                      final fee = state.fees[index];
                      return Card(
                        child: ListTile(
                          title: Text(fee.driverName),
                          subtitle: Text(
                            'Date: ${fee.date} | Status: ${fee.status}',
                          ),
                          trailing: Text('\$${fee.amount.toStringAsFixed(2)}'),
                        ),
                      );
                    },
                  );
                } else if (state is AdminFeesError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const Center(
                  child: Text('Enter year and month to load data'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDriverDailyTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Year'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _monthController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Month'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _dayController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Day'),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final year = int.tryParse(_yearController.text);
                  final month = int.tryParse(_monthController.text);
                  final day = int.tryParse(_dayController.text);
                  if (year != null && month != null && day != null) {
                    context.read<AdminFeesCubit>().fetchDailyDriverFees(
                      year,
                      month,
                      day,
                    );
                  }
                },
                child: const Text('Load'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<AdminFeesCubit, AdminFeesState>(
              builder: (context, state) {
                if (state is DriverFeesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DriverFeesLoaded) {
                  return ListView.builder(
                    itemCount: state.fees.length,
                    itemBuilder: (context, index) {
                      final fee = state.fees[index];
                      return Card(
                        child: ListTile(
                          title: Text(fee.driverName),
                          subtitle: Text('Status: ${fee.status}'),
                          trailing: Text('\$${fee.amount.toStringAsFixed(2)}'),
                        ),
                      );
                    },
                  );
                } else if (state is AdminFeesError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const Center(child: Text('Enter date to load data'));
              },
            ),
          ),
        ],
      ),
    );
  }

  // تبويب المطاعم بنفس الأسلوب (اختصاراً للوقت)
  Widget buildRestaurantDailyTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Restaurant Daily Earnings'),
          ElevatedButton(
            onPressed: () {
              context.read<AdminFeesCubit>().fetchDailyRestaurantEarnings(2025);
            },
            child: const Text('Load 2025 Earnings'),
          ),
        ],
      ),
    );
  }

  Widget buildRestaurantMonthlyTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Restaurant Monthly Earnings'),
          ElevatedButton(
            onPressed: () {
              context.read<AdminFeesCubit>().fetchMonthlyRestaurantEarnings(
                2025,
                5,
              );
            },
            child: const Text('Load May 2025 Earnings'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }
}
