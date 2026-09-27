import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

List<Widget> buildColumnCharts(List<Movie> movies) => [
  _column('Columnas: ratings TMDB', ChartDataProcessor.ratingsData(movies)),
  _column(
    'Columnas: popularidad TMDB',
    ChartDataProcessor.popularityData(movies),
    color: const Color(0xFFFFAB40),
  ),
  _column(
    'Columnas: géneros',
    ChartDataProcessor.genreDistribution(movies),
    color: const Color(0xFF69F0AE),
  ),
  _column(
    'Columnas: idiomas',
    ChartDataProcessor.languageDistribution(movies),
    color: const Color(0xFFFF4081),
  ),
  _grouped(movies),
  _column(
    'Ratings con etiquetas',
    ChartDataProcessor.ratingsData(movies, 7),
    labels: true,
  ),
  _column(
    'Popularidad con información emergente',
    ChartDataProcessor.popularityData(movies, 7),
    tooltip: true,
  ),
];

Widget _column(
  String title,
  List<MovieChartData> data, {
  Color color = const Color(0xFF448AFF),
  bool labels = false,
  bool tooltip = false,
}) {
  return _card(
    title,
    SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: const CategoryAxis(
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
        labelIntersectAction: AxisLabelIntersectAction.hide,
      ),
      primaryYAxis: const NumericAxis(
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
        majorGridLines: MajorGridLines(color: Colors.white12),
      ),
      tooltipBehavior: TooltipBehavior(enable: tooltip),
      series: <CartesianSeries<MovieChartData, String>>[
        ColumnSeries<MovieChartData, String>(
          dataSource: data,
          xValueMapper: (item, _) => item.label,
          yValueMapper: (item, _) => item.value,
          color: color,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          dataLabelSettings: DataLabelSettings(isVisible: labels),
        ),
      ],
    ),
  );
}

Widget _grouped(List<Movie> movies) {
  final data = ChartDataProcessor.ratingVsPopularity(movies, 8);
  return _card(
    'Columnas agrupadas: rating y popularidad normalizada',
    SfCartesianChart(
      legend: const Legend(
        isVisible: true,
        textStyle: TextStyle(color: Colors.white70),
      ),
      primaryXAxis: const CategoryAxis(
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      primaryYAxis: const NumericAxis(
        labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
      ),
      series: <CartesianSeries<MultiValueChartData, String>>[
        ColumnSeries<MultiValueChartData, String>(
          name: 'Rating',
          dataSource: data,
          xValueMapper: (item, _) => item.label,
          yValueMapper: (item, _) => item.v1,
          color: const Color(0xFF448AFF),
        ),
        ColumnSeries<MultiValueChartData, String>(
          name: 'Popularidad normalizada',
          dataSource: data,
          xValueMapper: (item, _) => item.label,
          yValueMapper: (item, _) => item.v2,
          color: const Color(0xFFFFAB40),
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
