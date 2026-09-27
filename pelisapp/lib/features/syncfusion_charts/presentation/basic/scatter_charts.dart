import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

List<Widget> buildScatterCharts(List<Movie> movies) => [
  _scatter('Dispersión: rating y popularidad', movies, useGenres: false),
  _scatter('Dispersión: rating y cantidad de géneros', movies, useGenres: true),
];

Widget _scatter(String title, List<Movie> movies, {required bool useGenres}) {
  final data = ChartDataProcessor.bubbleData(movies);
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
        SizedBox(
          height: 210,
          child: SfCartesianChart(
            primaryXAxis: const NumericAxis(
              title: AxisTitle(text: 'Rating TMDB'),
              labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: useGenres ? 'Géneros' : 'Popularidad'),
              labelStyle: const TextStyle(color: Colors.white70, fontSize: 9),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<BubbleChartData, double>>[
              ScatterSeries<BubbleChartData, double>(
                dataSource: data,
                xValueMapper: (item, _) => item.x,
                yValueMapper: (item, _) => useGenres ? item.size : item.y,
                pointColorMapper: (item, index) =>
                    Colors.primaries[index % Colors.primaries.length],
                markerSettings: const MarkerSettings(height: 10, width: 10),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
