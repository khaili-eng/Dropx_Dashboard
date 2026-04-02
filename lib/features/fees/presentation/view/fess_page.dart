import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:maadati/features/fees/data/model/admin_fee.dart';
import 'package:maadati/features/fees/presentation/manager/admin_fees_cubit.dart';
import 'package:maadati/features/fees/presentation/manager/admin_fees_status.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';


class AdminFeesScreen extends StatefulWidget {
  const AdminFeesScreen({super.key});

  @override
  State<AdminFeesScreen> createState() => _AdminFeesScreenState();
}

class _AdminFeesScreenState extends State<AdminFeesScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    final year = selectedDate.year.toString();
    final month = selectedDate.month.toString().padLeft(2, '0');
    context.read<AdminFeesCubit>().fetchMonthlyFees(year, month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("التقارير المالية (Fees)", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          )
        ],
      ),
      body: Column(
        children: [
          _buildHeaderSelector(),
          Expanded(
            child: BlocBuilder<AdminFeesCubit, AdminFeesStatus>(
              builder: (context, state) {
                if (state is AdminFeesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AdminFeesSuccess) {
                  return _buildDashboardContent(state.adminFeeData);
                } else if (state is AdminFeesError) {
                  return _buildErrorWidget(state.message);
                }
                return const Center(child: Text("يرجى اختيار فترة عرض البيانات"));
              },
            ),
          ),
        ],
      ),
    );
  }

  // الجزء العلوي لاختيار التاريخ
  Widget _buildHeaderSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.indigo,
      child: InkWell(
        onTap: () async {
          final date = await showMonthPicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
          );
          if (date != null) {
            setState(() => selectedDate = date);
            _refreshData();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_month, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                DateFormat('MMMM yyyy').format(selectedDate),
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(AdminFee data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // كرت عرض الإجمالي
          _buildStatCard(
            "إجمالي الأرباح لهذا الشهر",
            "${data.data.totalEarnings} SYP",
            Colors.green,
            Icons.account_balance_wallet,
          ),
          const SizedBox(height: 20),
          
          // الرسم البياني
          Container(
            height: 350,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("توزيع العمولات", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                Expanded(child: _buildBarChart(data)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(left: BorderSide(color: color, width: 5)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(AdminFee data) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: data.data.totalEarnings * 1.2, // ديناميكي بناءً على البيانات
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: data.data.totalEarnings, color: Colors.indigo, width: 25, borderRadius: BorderRadius.circular(4))
          ]),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => const Text("العمولة الإجمالية"),
            ),
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 10),
          Text(message, textAlign: TextAlign.center),
          ElevatedButton(onPressed: _refreshData, child: const Text("إعادة المحاولة")),
        ],
      ),
    );
  }
}