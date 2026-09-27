import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

/// Retorna la lista con los 7 widgets de tarjetas de gráficas de líneas.
List<Widget> buildLineCharts(List<Movie> movies) {
  return [
    SimpleLineChart(movies: movies),
    MarkerLineChart(movies: movies),
    LabeledLineChart(movies: movies),
    MultiSeriesLineChart(movies: movies),
    GradientLineChart(movies: movies),
    DashedLineChart(movies: movies),
    TooltipLineChart(movies: movies),
  ];
}

/// Helper para envolver cada gráfica en una tarjeta con estilo unificado.
Widget _buildChartCard({required String title, required Widget chart}) {
  return Container(
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
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: chart,
        ),
      ],
    ),
  );
}

/// Eje de categorías X preconfigurado para temas oscuros.
CategoryAxis _defaultCategoryAxis() {
  return const CategoryAxis(
    labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
    axisLine: AxisLine(color: Colors.white24),
    majorGridLines: MajorGridLines(color: Colors.white10),
    majorTickLines: MajorTickLines(size: 0),
    labelIntersectAction: AxisLabelIntersectAction.hide,
  );
}

/// Eje numérico Y preconfigurado para temas oscuros.
NumericAxis _defaultNumericAxis({String? labelFormat}) {
  return NumericAxis(
    labelStyle: const TextStyle(color: Colors.white70, fontSize: 9),
    axisLine: const AxisLine(color: Colors.white24),
    majorGridLines: const MajorGridLines(color: Colors.white10),
    majorTickLines: const MajorTickLines(size: 0),
    labelFormat: labelFormat,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Línea Simple
// ─────────────────────────────────────────────────────────────────────────────

/// Gráfica de línea básica con datos de calificación.
class SimpleLineChart extends StatelessWidget {
  const SimpleLineChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(movies);

    return _buildChartCard(
      title: 'Línea Simple — Calificaciones',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        primaryXAxis: _defaultCategoryAxis(),
        primaryYAxis: _defaultNumericAxis(labelFormat: '{value}'),
        series: <CartesianSeries<MovieChartData, String>>[
          LineSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            color: const Color(0xFF7C4DFF),
            width: 3,
            animationDuration: 1000,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Línea con Marcadores
// ─────────────────────────────────────────────────────────────────────────────

/// Gráfica de línea con marcadores circulares destacados.
class MarkerLineChart extends StatelessWidget {
  const MarkerLineChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(movies);

    return _buildChartCard(
      title: 'Línea con Marcadores',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        primaryXAxis: _defaultCategoryAxis(),
        primaryYAxis: _defaultNumericAxis(labelFormat: '{value}'),
        series: <CartesianSeries<MovieChartData, String>>[
          LineSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            color: const Color(0xFF18FFFF),
            width: 2.5,
            animationDuration: 1000,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              height: 8,
              width: 8,
              color: Color(0xFF111526),
              borderColor: Color(0xFF18FFFF),
              borderWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Línea con Etiquetas
// ─────────────────────────────────────────────────────────────────────────────

/// Gráfica de línea con etiquetas de valor en cada punto.
class LabeledLineChart extends StatelessWidget {
  const LabeledLineChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(movies);

    return _buildChartCard(
      title: 'Línea con Etiquetas',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        primaryXAxis: _defaultCategoryAxis(),
        primaryYAxis: _defaultNumericAxis(labelFormat: '{value}'),
        series: <CartesianSeries<MovieChartData, String>>[
          LineSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            color: const Color(0xFFFFAB40),
            width: 2.5,
            animationDuration: 1000,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
              labelAlignment: ChartDataLabelAlignment.top,
            ),
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.diamond,
              height: 6,
              width: 6,
              color: Color(0xFFFFAB40),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Línea Multiserie
// ─────────────────────────────────────────────────────────────────────────────

/// Gráfica con dos líneas comparando calificación y popularidad normalizada.
class MultiSeriesLineChart extends StatelessWidget {
  const MultiSeriesLineChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingVsPopularity(movies);

    return _buildChartCard(
      title: 'Línea Multiserie — Calificación vs Popularidad',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.top,
          textStyle: TextStyle(color: Colors.white70, fontSize: 10),
          iconHeight: 10,
          iconWidth: 10,
        ),
        primaryXAxis: _defaultCategoryAxis(),
        primaryYAxis: _defaultNumericAxis(),
        series: <CartesianSeries<MultiValueChartData, String>>[
          LineSeries<MultiValueChartData, String>(
            name: 'Calificación (0-10)',
            dataSource: data,
            xValueMapper: (MultiValueChartData item, _) => item.label,
            yValueMapper: (MultiValueChartData item, _) => item.v1,
            color: const Color(0xFF448AFF),
            width: 2.5,
            animationDuration: 1000,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              height: 5,
              width: 5,
              color: Color(0xFF448AFF),
            ),
          ),
          LineSeries<MultiValueChartData, String>(
            name: 'Popularidad (norm.)',
            dataSource: data,
            xValueMapper: (MultiValueChartData item, _) => item.label,
            yValueMapper: (MultiValueChartData item, _) => item.v2,
            color: const Color(0xFFFF4081),
            width: 2.5,
            animationDuration: 1000,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.triangle,
              height: 5,
              width: 5,
              color: Color(0xFFFF4081),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. Línea con Gradiente
// ─────────────────────────────────────────────────────────────────────────────

/// Gráfica de línea con trazado de degradado multicolor usando onCreateShader.
class GradientLineChart extends StatelessWidget {
  const GradientLineChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(movies);

    return _buildChartCard(
      title: 'Línea con Gradiente',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        primaryXAxis: _defaultCategoryAxis(),
        primaryYAxis: _defaultNumericAxis(labelFormat: '{value}'),
        series: <CartesianSeries<MovieChartData, String>>[
          LineSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            color: const Color(0xFF69F0AE),
            width: 3.5,
            onCreateShader: (ShaderDetails details) {
              return const LinearGradient(
                colors: <Color>[
                  Color(0xFF64FFDA),
                  Color(0xFF69F0AE),
                  Color(0xFF18FFFF),
                ],
                stops: <double>[0.0, 0.5, 1.0],
              ).createShader(details.rect);
            },
            animationDuration: 1000,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              height: 6,
              width: 6,
              color: Color(0xFF64FFDA),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. Línea Punteada
// ─────────────────────────────────────────────────────────────────────────────

/// Gráfica de línea punteada con patrón dashArray.
class DashedLineChart extends StatelessWidget {
  const DashedLineChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(movies);

    return _buildChartCard(
      title: 'Línea Punteada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        primaryXAxis: _defaultCategoryAxis(),
        primaryYAxis: _defaultNumericAxis(labelFormat: '{value}'),
        series: <CartesianSeries<MovieChartData, String>>[
          LineSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            color: const Color(0xFFFF5252),
            width: 2.5,
            dashArray: const <double>[5, 3],
            animationDuration: 1000,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.rectangle,
              height: 6,
              width: 6,
              color: Color(0xFFFF5252),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 7. Línea con Tooltip
// ─────────────────────────────────────────────────────────────────────────────

/// Gráfica de línea con Tooltip interactivo activado.
class TooltipLineChart extends StatelessWidget {
  TooltipLineChart({super.key, required this.movies})
      : _tooltipBehavior = TooltipBehavior(
          enable: true,
          color: const Color(0xFF1D2235),
          borderColor: const Color(0xFF536DFE),
          borderWidth: 1,
          textStyle: const TextStyle(color: Colors.white, fontSize: 11),
        );

  final List<Movie> movies;
  final TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.popularityData(movies);

    return _buildChartCard(
      title: 'Línea con Tooltip — Popularidad',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis: _defaultCategoryAxis(),
        primaryYAxis: _defaultNumericAxis(),
        series: <CartesianSeries<MovieChartData, String>>[
          LineSeries<MovieChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            enableTooltip: true,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            color: const Color(0xFF536DFE),
            width: 2.5,
            animationDuration: 1000,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.pentagon,
              height: 6,
              width: 6,
              color: Color(0xFF536DFE),
            ),
          ),
        ],
      ),
    );
  }
}
