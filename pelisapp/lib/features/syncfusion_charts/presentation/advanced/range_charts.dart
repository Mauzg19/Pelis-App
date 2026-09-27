import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

List<Widget> buildRangeCharts(List<Movie> movies) => [
  _rangeColumn('Rango de ratings por grupo', movies),
  _rangeColumn('Rango de ratings con etiquetas', movies, labels: true),
  _rangeArea('Área de rango de ratings', movies),
  _rangeArea('Área de rango translúcida', movies, opacity: 0.3),
  _rangeColumn('Rango compacto', movies, count: 4),
  _rangeArea('Rango ampliado', movies, count: 8),
];

Widget _rangeColumn(
  String title,
  List<Movie> movies, {
  bool labels = false,
  int count = 6,
}) {
  final data = ChartDataProcessor.rangeData(movies, count);
  return _card(
    title,
    SfCartesianChart(
      primaryXAxis: const CategoryAxis(
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 10,
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<RangeChartData, String>>[
        RangeColumnSeries<RangeChartData, String>(
          dataSource: data,
          xValueMapper: (item, _) => item.label,
          lowValueMapper: (item, _) => item.low,
          highValueMapper: (item, _) => item.high,
          color: const Color(0xFF448AFF),
          dataLabelSettings: DataLabelSettings(isVisible: labels),
        ),
      ],
    ),
  );
}

Widget _rangeArea(
  String title,
  List<Movie> movies, {
  double opacity = 0.55,
  int count = 6,
}) {
  final data = ChartDataProcessor.rangeData(movies, count);
  return _card(
    title,
    SfCartesianChart(
      primaryXAxis: const CategoryAxis(
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 10,
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      series: <CartesianSeries<RangeChartData, String>>[
        RangeAreaSeries<RangeChartData, String>(
          dataSource: data,
          xValueMapper: (item, _) => item.label,
          lowValueMapper: (item, _) => item.low,
          highValueMapper: (item, _) => item.high,
          color: const Color(0xFF18FFFF).withValues(alpha: opacity),
          borderColor: const Color(0xFF18FFFF),
          borderWidth: 2,
        ),
      ],
    ),
  );
}

Widget _card(String title, Widget chart) => Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: const Color(0xFF1D2235),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      SizedBox(height: 210, child: chart),
    ],
  ),
);
