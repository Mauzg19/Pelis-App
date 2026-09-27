import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

List<Widget> buildFinancialCharts(List<Movie> movies) => [
  _financial('Candlestick: rating y popularidad por estreno', movies, kind: 0),
  _financial('Hilo: rating y popularidad por estreno', movies, kind: 1),
  _financial('OHLC: rating y popularidad por estreno', movies, kind: 2),
  _metric('Ratings TMDB por estreno', movies, rating: true),
  _metric('Popularidad TMDB normalizada por estreno', movies, rating: false),
  _financial(
    'Candlestick compacto por estreno',
    movies,
    kind: 0,
    compact: true,
  ),
];

Widget _financial(
  String title,
  List<Movie> movies, {
  required int kind,
  bool compact = false,
}) {
  final data = ChartDataProcessor.financialData(movies, compact ? 7 : 12);
  final series = switch (kind) {
    0 => CandleSeries<FinancialChartData, DateTime>(
      dataSource: data,
      xValueMapper: (item, _) => item.date,
      lowValueMapper: (item, _) => item.low,
      highValueMapper: (item, _) => item.high,
      openValueMapper: (item, _) => item.open,
      closeValueMapper: (item, _) => item.close,
      bullColor: const Color(0xFF69F0AE),
      bearColor: const Color(0xFFFF5252),
    ),
    1 => HiloSeries<FinancialChartData, DateTime>(
      dataSource: data,
      xValueMapper: (item, _) => item.date,
      lowValueMapper: (item, _) => item.low,
      highValueMapper: (item, _) => item.high,
    ),
    _ => HiloOpenCloseSeries<FinancialChartData, DateTime>(
      dataSource: data,
      xValueMapper: (item, _) => item.date,
      lowValueMapper: (item, _) => item.low,
      highValueMapper: (item, _) => item.high,
      openValueMapper: (item, _) => item.open,
      closeValueMapper: (item, _) => item.close,
    ),
  };
  return _card(
    title,
    SfCartesianChart(
      primaryXAxis: const DateTimeAxis(
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 10,
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<FinancialChartData, DateTime>>[series],
    ),
  );
}

Widget _metric(String title, List<Movie> movies, {required bool rating}) {
  final data = ChartDataProcessor.financialData(movies);
  return _card(
    title,
    SfCartesianChart(
      primaryXAxis: const DateTimeAxis(
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 10,
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      series: <CartesianSeries<FinancialChartData, DateTime>>[
        SplineSeries<FinancialChartData, DateTime>(
          dataSource: data,
          xValueMapper: (item, _) => item.date,
          yValueMapper: (item, _) => rating ? item.open : item.close,
          color: rating ? const Color(0xFF448AFF) : const Color(0xFFFFAB40),
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
