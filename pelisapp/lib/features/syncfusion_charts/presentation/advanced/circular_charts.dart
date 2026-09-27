import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

List<Widget> buildCircularCharts(List<Movie> movies) => [
  _pie(
    'Pie: distribución por género',
    ChartDataProcessor.genreDistribution(movies),
  ),
  _pie(
    'Pie: distribución por idioma',
    ChartDataProcessor.languageDistribution(movies),
    labels: true,
  ),
  _doughnut('Dona: géneros', ChartDataProcessor.genreDistribution(movies)),
  _doughnut(
    'Dona: idiomas',
    ChartDataProcessor.languageDistribution(movies),
    labels: true,
  ),
  _doughnut(
    'Dona con centro amplio',
    ChartDataProcessor.genreDistribution(movies),
    radius: '75%',
  ),
  _pie(
    'Pie compacto: géneros principales',
    ChartDataProcessor.genreDistribution(movies).take(5).toList(),
  ),
  _doughnut(
    'Dona compacta: idiomas principales',
    ChartDataProcessor.languageDistribution(movies).take(4).toList(),
  ),
  _pie(
    'Pie con información emergente',
    ChartDataProcessor.genreDistribution(movies),
    tooltip: true,
  ),
  _doughnut(
    'Dona con información emergente',
    ChartDataProcessor.languageDistribution(movies),
    tooltip: true,
  ),
];

Widget _pie(
  String title,
  List<MovieChartData> data, {
  bool labels = false,
  bool tooltip = false,
}) => _card(
  title,
  SfCircularChart(
    legend: const Legend(
      isVisible: true,
      overflowMode: LegendItemOverflowMode.wrap,
      textStyle: TextStyle(color: Colors.white70, fontSize: 9),
    ),
    tooltipBehavior: TooltipBehavior(enable: tooltip),
    series: <CircularSeries<MovieChartData, String>>[
      PieSeries<MovieChartData, String>(
        dataSource: data,
        xValueMapper: (item, _) => item.label,
        yValueMapper: (item, _) => item.value,
        dataLabelSettings: DataLabelSettings(isVisible: labels),
        pointColorMapper: (item, index) =>
            Colors.primaries[index % Colors.primaries.length],
      ),
    ],
  ),
);

Widget _doughnut(
  String title,
  List<MovieChartData> data, {
  bool labels = false,
  bool tooltip = false,
  String radius = '60%',
}) => _card(
  title,
  SfCircularChart(
    legend: const Legend(
      isVisible: true,
      overflowMode: LegendItemOverflowMode.wrap,
      textStyle: TextStyle(color: Colors.white70, fontSize: 9),
    ),
    tooltipBehavior: TooltipBehavior(enable: tooltip),
    series: <CircularSeries<MovieChartData, String>>[
      DoughnutSeries<MovieChartData, String>(
        dataSource: data,
        xValueMapper: (item, _) => item.label,
        yValueMapper: (item, _) => item.value,
        innerRadius: radius,
        dataLabelSettings: DataLabelSettings(isVisible: labels),
        pointColorMapper: (item, index) =>
            Colors.primaries[index % Colors.primaries.length],
      ),
    ],
  ),
);

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
      SizedBox(height: 220, child: chart),
    ],
  ),
);
