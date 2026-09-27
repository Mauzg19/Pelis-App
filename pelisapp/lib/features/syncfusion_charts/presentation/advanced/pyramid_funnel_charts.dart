import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

List<Widget> buildPyramidFunnelCharts(List<Movie> movies) => [
  _chart('Pirámide: películas por género', movies, funnel: false),
  _chart('Funnel: películas por género', movies, funnel: true),
  _chart(
    'Pirámide: cinco géneros principales',
    movies,
    funnel: false,
    limit: 5,
  ),
  _chart('Funnel: idiomas originales', movies, funnel: true, languages: true),
];

Widget _chart(
  String title,
  List<Movie> movies, {
  required bool funnel,
  bool languages = false,
  int limit = 8,
}) {
  final source = languages
      ? ChartDataProcessor.languageDistribution(movies)
      : ChartDataProcessor.genreDistribution(movies);
  final data = source.take(limit).toList();
  final Widget chart = funnel
      ? SfFunnelChart(
          series: FunnelSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (item, _) => item.label,
            yValueMapper: (item, _) => item.value,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            pointColorMapper: (item, index) =>
                Colors.primaries[index % Colors.primaries.length],
          ),
        )
      : SfPyramidChart(
          series: PyramidSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (item, _) => item.label,
            yValueMapper: (item, _) => item.value,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            pointColorMapper: (item, index) =>
                Colors.primaries[index % Colors.primaries.length],
          ),
        );
  return Container(
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
        SizedBox(height: 230, child: chart),
      ],
    ),
  );
}
