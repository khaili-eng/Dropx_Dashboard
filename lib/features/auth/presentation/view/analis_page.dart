import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.color1,
      appBar: AppBar(
        title: const Text(
          'Business Analytics',
          style: TextStyle(
            color: AppColor.color4,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColor.color4),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Daily Insights"),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildPremiumStatCard(
                  "Orders",
                  "1,240",
                  Icons.local_shipping,
                  AppColor.color4,
                ),
                const SizedBox(width: 15),
                _buildPremiumStatCard(
                  "Revenue",
                  "\$12.5k",
                  Icons.payments,
                  Colors.brown,
                ),
              ],
            ),
            const SizedBox(height: 25),

            _buildSectionTitle("Sales Performance"),
            const SizedBox(height: 15),
            _buildChartContainer(
              height: 250,
              child: LineChart(_mainSalesData()),
            ),
            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Order Sources"),
                      const SizedBox(height: 15),
                      _buildChartContainer(
                        height: 200,
                        child: PieChart(_orderSourceData()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(flex: 2, child: _buildLegend()),
              ],
            ),
            const SizedBox(height: 25),

            _buildSectionTitle("Top Rated Items"),
            const SizedBox(height: 15),
            _buildTopItemCard("Truffle Pizza", "4.9 ⭐", "980 Orders"),
            _buildTopItemCard("Zinger Burger", "4.7 ⭐", "750 Orders"),
            _buildTopItemCard("Pasta Alfredo", "4.8 ⭐", "620 Orders"),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Colors.brown[800],
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildPremiumStatCard(
    String title,
    String value,
    IconData icon,
    Color accentColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.color2,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColor.color3.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.color1,
              child: Icon(icon, color: accentColor, size: 20),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                color: Colors.brown[400],
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                color: AppColor.color4,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartContainer({required double height, required Widget child}) {
    return Container(
      height: height,
      padding: const EdgeInsets.fromLTRB(10, 25, 20, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColor.color2, width: 2),
      ),
      child: child,
    );
  }

  Widget _buildTopItemCard(String name, String rate, String orders) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.color2.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.color1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.fastfood, color: AppColor.color4),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  orders,
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            rate,
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Charts Logic ---------------------------------------------------------

  LineChartData _mainSalesData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 2,
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget:
                (value, meta) => Text(
                  ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'][value.toInt() % 5],
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 3),
            const FlSpot(1, 4),
            const FlSpot(2, 3.5),
            const FlSpot(3, 6),
            const FlSpot(4, 5),
          ],
          isCurved: true,
          color: AppColor.color4,
          barWidth: 6,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppColor.color4.withOpacity(0.3),
                AppColor.color4.withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  PieChartData _orderSourceData() {
    return PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 40,
      sections: [
        PieChartSectionData(
          color: AppColor.color4,
          value: 45,
          title: '',
          radius: 25,
        ),
        PieChartSectionData(
          color: AppColor.color3,
          value: 25,
          title: '',
          radius: 25,
        ),
        PieChartSectionData(
          color: AppColor.color2,
          value: 30,
          title: '',
          radius: 25,
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem("Mobile App", AppColor.color4),
        const SizedBox(height: 8),
        _legendItem("Website", AppColor.color3),
        const SizedBox(height: 8),
        _legendItem("Phone Call", AppColor.color2),
      ],
    );
  }

  Widget _legendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
