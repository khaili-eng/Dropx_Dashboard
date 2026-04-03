import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:maadati/core/constants/app_color/app_color.dart';

class DriverReportWidget extends StatefulWidget {
  final Map<String, dynamic>? report;
  final bool useMock;

  const DriverReportWidget({
    super.key,
    this.report,
    this.useMock = true,
  });

  @override
  State<DriverReportWidget> createState() => _DriverReportWidgetState();
}

class _DriverReportWidgetState extends State<DriverReportWidget> {
  String reportType = "daily";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
    (widget.useMock || widget.report == null || widget.report!.isEmpty)
        ? getMockData(reportType: reportType)
        : widget.report!;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              buildToggleButton("daily", "Daily"),
              buildToggleButton("monthly", "Monthly"),
            ],
          ),
        ),

        const SizedBox(height: 10),


        reportType == "daily"
            ? buildDaily(data)
            : buildMonthly(data),
      ],
    );
  }

  Widget buildToggleButton(String type, String title) {
    final bool isSelected = reportType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            reportType = type;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.color4 : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildDaily(Map<String, dynamic> data) {
    final int completed = data["completed_orders"] ?? 0;
    final int running = data["running_orders"] ?? 0;
    final int cancelled = data["cancelled_orders"] ?? 0;

    return Column(
      children: [
        buildPieChart(
          [completed, running, cancelled],
          [Colors.green, Colors.blue, Colors.red],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            buildStat("Completed", completed, Colors.green),
            buildStat("Running", running, Colors.blue),
            buildStat("Cancelled", cancelled, Colors.red),
          ],
        ),
        const SizedBox(height: 20),
        buildBarChart([completed, running, cancelled]),
      ],
    );
  }
  Widget buildMonthly(Map<String, dynamic> data) {
    final List<int> completedPerDay =
    List<int>.from(data["completed_orders_per_day"]);
    final List<int> runningPerDay =
    List<int>.from(data["running_orders_per_day"]);
    final List<int> cancelledPerDay =
    List<int>.from(data["cancelled_orders_per_day"]);

    final int totalCompleted =
    completedPerDay.reduce((a, b) => a + b);
    final int totalRunning =
    runningPerDay.reduce((a, b) => a + b);
    final int totalCancelled =
    cancelledPerDay.reduce((a, b) => a + b);

    return Column(
      children: [
        buildPieChart(
          [totalCompleted, totalRunning, totalCancelled],
          [Colors.green, Colors.blue, Colors.red],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            buildStat("Completed", totalCompleted, Colors.green),
            buildStat("Running", totalRunning, Colors.blue),
            buildStat("Cancelled", totalCancelled, Colors.red),
          ],
        ),


        const SizedBox(height: 20),
        buildBarChartMonthly(
            completedPerDay, runningPerDay, cancelledPerDay),
      ],
    );
  }
  Map<String, dynamic> getMockData({String reportType = "daily"}) {
    final random = Random();

    if (reportType == "daily") {
      return {
        "completed_orders": 25,
        "running_orders": 7,
        "cancelled_orders": 3,
      };
    } else {
      final completed =
      List.generate(30, (_) => random.nextInt(20));
      final running =
      List.generate(30, (_) => random.nextInt(10));
      final cancelled =
      List.generate(30, (_) => random.nextInt(5));

      return {
        "completed_orders_per_day": completed,
        "running_orders_per_day": running,
        "cancelled_orders_per_day": cancelled,
      };
    }
  }
  Widget buildStat(String title, int value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 5),
            Text(title),
          ],
        ),
      ),
    );
  }
  Widget buildBarChart(List<int> values) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)
        ],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: values.reduce((a, b) => a + b).toDouble() + 5,
          borderData: FlBorderData(show: false),
          barGroups: [
            buildBar(0, values[0], Colors.green),
            buildBar(1, values[1], Colors.blue),
            buildBar(2, values[2], Colors.red),
          ],
        ),
      ),
    );
  }
  Widget buildBarChartMonthly(
      List<int> completed,
      List<int> running,
      List<int> cancelled,
      ) {
    final int days = completed.length;

    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)
        ],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          maxY: ([
            ...completed,
            ...running,
            ...cancelled
          ].reduce(max)).toDouble() + 5,
          borderData: FlBorderData(show: false),
          barGroups: List.generate(days, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                    toY: completed[i].toDouble(),
                    color: Colors.green,
                    width: 6),
                BarChartRodData(
                    toY: running[i].toDouble(),
                    color: Colors.blue,
                    width: 6),
                BarChartRodData(
                    toY: cancelled[i].toDouble(),
                    color: Colors.red,
                    width: 6),
              ],
            );
          }),
        ),
      ),
    );
  }
  int touchedIndex = -1;

  Widget buildPieChart(List<int> values, List<Color> colors) {
    final total = values.fold(0, (a, b) => a + b);

    final titles = ["Completed", "Running", "Cancelled"];

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: 260,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
              )
            ],
          ),
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        response == null ||
                        response.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        response.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              sectionsSpace: 3,
              centerSpaceRadius: 45,
              sections: List.generate(values.length, (i) {
                final isTouched = i == touchedIndex;

                final double percentage =
                total == 0 ? 0 : (values[i] / total * 100);

                return PieChartSectionData(
                  value: values[i].toDouble(),
                  color: isTouched
                      ? colors[i].withOpacity(0.8) // 🔥 لون أغمق
                      : colors[i],
                  radius: isTouched ? 75 : 60, // 🔥 تكبير
                  title: isTouched
                      ? "${titles[i]}\n${percentage.toStringAsFixed(1)}%"
                      : "${percentage.toStringAsFixed(0)}%",
                  titleStyle: TextStyle(
                    fontSize: isTouched ? 14 : 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }


  BarChartGroupData buildBar(int x, int y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y.toDouble(),
          color: color,
          width: 18,
        )
      ],
    );
  }
}