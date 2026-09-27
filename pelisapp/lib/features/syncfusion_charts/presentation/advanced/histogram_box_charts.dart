import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

List<Widget> buildHistogramBoxCharts(List<Movie> movies) => [
  _distributionCard(movies),
];

Widget _distributionCard(List<Movie> movies) {
  final ratings = movies.map((movie) => movie.voteAverage).toList();
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1D2235),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Distribución de ratings: histograma y box plot',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 230,
          child: Row(
            children: [
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: const NumericAxis(
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 8),
                  ),
                  primaryYAxis: const NumericAxis(
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 8),
                  ),
                  series: <CartesianSeries<MovieChartData, double>>[
                    HistogramSeries<MovieChartData, double>(
                      dataSource: ChartDataProcessor.histogramData(movies),
                      yValueMapper: (item, _) => item.value,
                      color: const Color(0xFF69F0AE),
                      binInterval: 1,
                    ),
                  ],
                ),
              ),
              const VerticalDivider(color: Colors.white24),
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 8),
                  ),
                  primaryYAxis: const NumericAxis(
                    minimum: 0,
                    maximum: 10,
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 8),
                  ),
                  series: <CartesianSeries<_RatingGroup, String>>[
                    if (ratings.isNotEmpty)
                      BoxAndWhiskerSeries<_RatingGroup, String>(
                        dataSource: [_RatingGroup('TMDB', ratings)],
                        xValueMapper: (item, _) => item.label,
                        yValueMapper: (item, _) => item.values,
                        showMean: true,
                        color: const Color(0xFFFFAB40),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _RatingGroup {
  const _RatingGroup(this.label, this.values);
  final String label;
  final List<double> values;
}
