import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

List<Widget> buildWaterfallCharts(List<Movie> movies) => [
  Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1D2235),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Waterfall: diferencia de rating respecto a 5',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(
              labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
              labelIntersectAction: AxisLabelIntersectAction.hide,
            ),
            primaryYAxis: const NumericAxis(
              labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<WaterfallChartData, String>>[
              WaterfallSeries<WaterfallChartData, String>(
                dataSource: ChartDataProcessor.waterfallData(movies),
                xValueMapper: (item, _) => item.label,
                yValueMapper: (item, _) => item.value,
                totalSumPredicate: (item, _) => item.isTotal,
                negativePointsColor: const Color(0xFFFF5252),
                intermediateSumColor: const Color(0xFF448AFF),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
];
