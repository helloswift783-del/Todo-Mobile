import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/task_view_model.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<TaskViewModel>().completionStats();
    final completed = stats['Completed'] ?? 0;
    final pending = stats['Pending'] ?? 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: SizedBox(
          height: 280,
          width: 280,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 50,
              sections: [
                PieChartSectionData(
                  value: completed.toDouble(),
                  title: 'Done\n$completed',
                  color: Colors.green,
                  radius: 100,
                ),
                PieChartSectionData(
                  value: pending.toDouble(),
                  title: 'Pending\n$pending',
                  color: Colors.orange,
                  radius: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
