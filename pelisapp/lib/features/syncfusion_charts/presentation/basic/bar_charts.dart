import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

/// Función pública que retorna la lista con las 6 tarjetas de gráficas de barras.
List<Widget> buildBarCharts(List<Movie> movies) {
  return [
    SimpleBarChart(movies: movies),
    GroupedBarChart(movies: movies),
    GradientBarChart(movies: movies),
    DataLabelBarChart(movies: movies),
    TooltipBarChart(movies: movies),
    BorderedBarChart(movies: movies),
  ];
}

/// Contenedor común para las tarjetas de gráficas de barras.
Widget _buildCard({required String title, required Widget chart}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1D2235),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: chart,
        ),
      ],
    ),
  );
}

/// 1. Barra Simple — Basic BarSeries con color #448AFF
class SimpleBarChart extends StatelessWidget {
  const SimpleBarChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(movies, 5);

    return _buildCard(
      title: 'Barra Simple',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.fromLTRB(4, 8, 12, 4),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(color: Colors.white12, width: 0.5),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          BarSeries<MovieChartData, String>(
            name: 'Rating',
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            color: const Color(0xFF448AFF),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
          ),
        ],
      ),
    );
  }
}

/// 2. Barra Agrupada — Dos BarSeries lado a lado (Rating vs Popularidad)
class GroupedBarChart extends StatelessWidget {
  const GroupedBarChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingVsPopularity(movies, 5);

    return _buildCard(
      title: 'Barra Agrupada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.fromLTRB(4, 8, 12, 4),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.top,
          textStyle: TextStyle(color: Colors.white, fontSize: 11),
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(color: Colors.white12, width: 0.5),
        ),
        series: <CartesianSeries<MultiValueChartData, String>>[
          BarSeries<MultiValueChartData, String>(
            name: 'Calificación',
            dataSource: data,
            xValueMapper: (MultiValueChartData item, _) => item.label,
            yValueMapper: (MultiValueChartData item, _) => item.v1,
            color: const Color(0xFF7C4DFF),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
            spacing: 0.2,
          ),
          BarSeries<MultiValueChartData, String>(
            name: 'Popularidad (norm.)',
            dataSource: data,
            xValueMapper: (MultiValueChartData item, _) => item.label,
            yValueMapper: (MultiValueChartData item, _) => item.v2,
            color: const Color(0xFF69F0AE),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
            spacing: 0.2,
          ),
        ],
      ),
    );
  }
}

/// 3. Barra con Gradiente — BarSeries con gradiente de colores
class GradientBarChart extends StatelessWidget {
  const GradientBarChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.popularityData(movies, 5);

    return _buildCard(
      title: 'Barra con Gradiente',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.fromLTRB(4, 8, 12, 4),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(color: Colors.white12, width: 0.5),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          BarSeries<MovieChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            gradient: const LinearGradient(
              colors: [Color(0xFFFFAB40), Color(0xFFFF5252)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(6)),
          ),
        ],
      ),
    );
  }
}

/// 4. Barra con Etiquetas — BarSeries con DataLabelSettings
class DataLabelBarChart extends StatelessWidget {
  const DataLabelBarChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(movies, 5);

    return _buildCard(
      title: 'Barra con Etiquetas',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.fromLTRB(4, 8, 16, 4),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(color: Colors.white12, width: 0.5),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          BarSeries<MovieChartData, String>(
            name: 'Calificación',
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            color: const Color(0xFF18FFFF),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.outer,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 5. Barra con Tooltip — BarSeries con TooltipBehavior
class TooltipBarChart extends StatelessWidget {
  const TooltipBarChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(movies, 5);
    final tooltipBehavior = TooltipBehavior(
      enable: true,
      color: const Color(0xFF1D2235),
      borderColor: const Color(0xFFFF4081),
      borderWidth: 1.5,
      header: 'Película',
      format: 'point.x : point.y ★',
      textStyle: const TextStyle(color: Colors.white, fontSize: 11),
    );

    return _buildCard(
      title: 'Barra con Tooltip',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.fromLTRB(4, 8, 12, 4),
        tooltipBehavior: tooltipBehavior,
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(color: Colors.white12, width: 0.5),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          BarSeries<MovieChartData, String>(
            name: 'Calificación',
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            color: const Color(0xFFFF4081),
            enableTooltip: true,
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
          ),
        ],
      ),
    );
  }
}

/// 6. Barra con Bordes — BarSeries con borderColor y borderWidth
class BorderedBarChart extends StatelessWidget {
  const BorderedBarChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.popularityData(movies, 5);

    return _buildCard(
      title: 'Barra con Bordes',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.fromLTRB(4, 8, 12, 4),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          axisLine: AxisLine(color: Colors.white24),
          majorTickLines: MajorTickLines(color: Colors.white24),
          majorGridLines: MajorGridLines(color: Colors.white12, width: 0.5),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          BarSeries<MovieChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            color: const Color(0x55536DFE),
            borderColor: const Color(0xFFFFD740),
            borderWidth: 2,
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
          ),
        ],
      ),
    );
  }
}
