import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

List<Widget> buildStepLineCharts(List<Movie> movies) => [
  _step(
    'Escalones: rating por película',
    ChartDataProcessor.ratingsData(movies),
  ),
  _step(
    'Escalones: popularidad',
    ChartDataProcessor.popularityData(movies),
    color: const Color(0xFFFFAB40),
  ),
  _step(
    'Escalones: géneros',
    ChartDataProcessor.genreDistribution(movies),
    color: const Color(0xFF69F0AE),
  ),
  _step(
    'Escalones: idiomas',
    ChartDataProcessor.languageDistribution(movies),
    color: const Color(0xFFFF4081),
  ),
  _step(
    'Escalones con marcadores',
    ChartDataProcessor.ratingsData(movies, 8),
    markers: true,
  ),
  _comparison(movies),
];

Widget _step(
  String title,
  List<MovieChartData> data, {
  Color color = const Color(0xFF18FFFF),
  bool markers = false,
}) => _card(
  title,
  SfCartesianChart(
    primaryXAxis: const CategoryAxis(
      labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      labelIntersectAction: AxisLabelIntersectAction.hide,
    ),
    primaryYAxis: const NumericAxis(
      labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
    ),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <CartesianSeries<MovieChartData, String>>[
      StepLineSeries<MovieChartData, String>(
        dataSource: data,
        xValueMapper: (item, _) => item.label,
        yValueMapper: (item, _) => item.value,
        color: color,
        width: 2.5,
        markerSettings: MarkerSettings(isVisible: markers),
      ),
    ],
  ),
);

Widget _comparison(List<Movie> movies) {
  final data = ChartDataProcessor.ratingVsPopularity(movies, 8);
  return _card(
    'Escalones: rating vs popularidad',
    SfCartesianChart(
      legend: const Legend(
        isVisible: true,
        textStyle: TextStyle(color: Colors.white70),
      ),
      primaryXAxis: const CategoryAxis(
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
        labelIntersectAction: AxisLabelIntersectAction.hide,
      ),
      primaryYAxis: const NumericAxis(
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      series: <CartesianSeries<MultiValueChartData, String>>[
        StepLineSeries<MultiValueChartData, String>(
          name: 'Rating',
          dataSource: data,
          xValueMapper: (item, _) => item.label,
          yValueMapper: (item, _) => item.v1,
          color: const Color(0xFF448AFF),
          markerSettings: const MarkerSettings(isVisible: true),
        ),
        StepLineSeries<MultiValueChartData, String>(
          name: 'Popularidad norm.',
          dataSource: data,
          xValueMapper: (item, _) => item.label,
          yValueMapper: (item, _) => item.v2,
          color: const Color(0xFFFFAB40),
          markerSettings: const MarkerSettings(isVisible: true),
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
