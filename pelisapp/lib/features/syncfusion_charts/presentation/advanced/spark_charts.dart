import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

List<Widget> buildSparkCharts(List<Movie> movies) => [
  _spark('Sparkline: ratings TMDB', movies),
];

Widget _spark(String title, List<Movie> movies) {
  final data = ChartDataProcessor.sparkData(movies);
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
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: SfSparkLineChart(data: data, color: const Color(0xFF18FFFF)),
        ),
      ],
    ),
  );
}
