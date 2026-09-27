import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

/// Retorna la lista de todas las tarjetas de gráficas Spline configuradas.
List<Widget> buildSplineCharts(List<Movie> movies) {
  return [
    SplineSimpleChart(movies: movies),
    SplineWithMarkersChart(movies: movies),
    SplineAreaChart(movies: movies),
    SplineGradientChart(movies: movies),
    SplineMultiSeriesChart(movies: movies),
    SplineWithTooltipChart(movies: movies),
  ];
}

// ─── Envoltorio de tarjeta reutilizable ─────────────────────────────

Widget _buildSplineCard({
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1D2235),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
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
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        const SizedBox(height: 12),
        SizedBox(height: 250, child: child),
      ],
    ),
  );
}

Widget _buildEmptyState() {
  return const Center(
    child: Text(
      'Sin datos de películas disponibles',
      style: TextStyle(color: Colors.white54, fontSize: 13),
    ),
  );
}

// ─── 1. Spline Simple ───────────────────────────────────────────────

/// Gráfica Spline simple con calificaciones de películas (#FF4081).
class SplineSimpleChart extends StatelessWidget {
  const SplineSimpleChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return _buildSplineCard(
        title: 'Spline Simple',
        subtitle: 'Calificaciones TMDB de películas',
        child: _buildEmptyState(),
      );
    }

    final data = ChartDataProcessor.ratingsData(movies, 7);

    return _buildSplineCard(
      title: 'Spline Simple',
      subtitle: 'Tendencia continua de calificaciones (Top 7)',
      child: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          labelIntersectAction: AxisLabelIntersectAction.rotate45,
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24, width: 1),
        ),
        primaryYAxis: const NumericAxis(
          minimum: 0,
          maximum: 10,
          interval: 2,
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: MajorGridLines(color: Color(0xFF2A2E43), width: 0.8),
          axisLine: AxisLine(width: 0),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          SplineSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            name: 'Calificación',
            color: const Color(0xFFFF4081),
            width: 3.5,
            splineType: SplineType.natural,
          ),
        ],
      ),
    );
  }
}

// ─── 2. Spline con Marcadores ───────────────────────────────────────

/// Gráfica Spline con marcadores destacados en cada punto de dato.
class SplineWithMarkersChart extends StatelessWidget {
  const SplineWithMarkersChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return _buildSplineCard(
        title: 'Spline con Marcadores',
        subtitle: 'Puntos clave de valoración en cada película',
        child: _buildEmptyState(),
      );
    }

    final data = ChartDataProcessor.ratingsData(movies, 8);

    return _buildSplineCard(
      title: 'Spline con Marcadores',
      subtitle: 'Puntos clave de valoración en cada película',
      child: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          labelIntersectAction: AxisLabelIntersectAction.rotate45,
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24, width: 1),
        ),
        primaryYAxis: const NumericAxis(
          minimum: 0,
          maximum: 10,
          interval: 2,
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: MajorGridLines(color: Color(0xFF2A2E43), width: 0.8),
          axisLine: AxisLine(width: 0),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          SplineSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            name: 'Calificación',
            color: const Color(0xFF448AFF),
            width: 3,
            splineType: SplineType.monotonic,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              width: 8,
              height: 8,
              color: Color(0xFF18FFFF),
              borderColor: Colors.white,
              borderWidth: 2,
            ),
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 3. Spline Área ─────────────────────────────────────────────────

/// Gráfica Spline de Área con relleno translúcido y borde púrpura.
class SplineAreaChart extends StatelessWidget {
  const SplineAreaChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return _buildSplineCard(
        title: 'Spline Área',
        subtitle: 'Superficie suavizada de calificaciones',
        child: _buildEmptyState(),
      );
    }

    final data = ChartDataProcessor.ratingsData(movies, 8);

    return _buildSplineCard(
      title: 'Spline Área',
      subtitle: 'Superficie suavizada de calificaciones TMDB',
      child: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          labelIntersectAction: AxisLabelIntersectAction.rotate45,
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24, width: 1),
        ),
        primaryYAxis: const NumericAxis(
          minimum: 0,
          maximum: 10,
          interval: 2,
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: MajorGridLines(color: Color(0xFF2A2E43), width: 0.8),
          axisLine: AxisLine(width: 0),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          SplineAreaSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            name: 'Área Calificación',
            color: const Color(0x557C4DFF),
            borderColor: const Color(0xFF7C4DFF),
            borderWidth: 2.5,
            borderDrawMode: BorderDrawMode.top,
            splineType: SplineType.natural,
          ),
        ],
      ),
    );
  }
}

// ─── 4. Spline con Gradiente ────────────────────────────────────────

/// Gráfica Spline con gradiente multicolor dinámico.
class SplineGradientChart extends StatelessWidget {
  const SplineGradientChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return _buildSplineCard(
        title: 'Spline con Gradiente',
        subtitle: 'Transición cromática a lo largo de la curva',
        child: _buildEmptyState(),
      );
    }

    final data = ChartDataProcessor.ratingsData(movies, 8);

    return _buildSplineCard(
      title: 'Spline con Gradiente',
      subtitle: 'Transición cromática suave (Cian - Púrpura - Rosa)',
      child: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          labelIntersectAction: AxisLabelIntersectAction.rotate45,
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24, width: 1),
        ),
        primaryYAxis: const NumericAxis(
          minimum: 0,
          maximum: 10,
          interval: 2,
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: MajorGridLines(color: Color(0xFF2A2E43), width: 0.8),
          axisLine: AxisLine(width: 0),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          SplineSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            name: 'Gradiente',
            width: 4,
            splineType: SplineType.cardinal,
            color: const Color(0xFF18FFFF),
          ),
        ],
      ),
    );
  }
}

// ─── 5. Spline Multiserie ───────────────────────────────────────────

/// Gráfica Spline multiserie comparando calificación y popularidad relativa.
class SplineMultiSeriesChart extends StatelessWidget {
  const SplineMultiSeriesChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return _buildSplineCard(
        title: 'Spline Multiserie',
        subtitle: 'Comparación de Calificación vs Popularidad',
        child: _buildEmptyState(),
      );
    }

    final data = ChartDataProcessor.ratingVsPopularity(movies, 7);

    return _buildSplineCard(
      title: 'Spline Multiserie',
      subtitle: 'Comparación: Calificación vs Popularidad normalizada',
      child: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          labelIntersectAction: AxisLabelIntersectAction.rotate45,
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24, width: 1),
        ),
        primaryYAxis: const NumericAxis(
          minimum: 0,
          maximum: 10,
          interval: 2,
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: MajorGridLines(color: Color(0xFF2A2E43), width: 0.8),
          axisLine: AxisLine(width: 0),
        ),
        series: <CartesianSeries<MultiValueChartData, String>>[
          SplineSeries<MultiValueChartData, String>(
            dataSource: data,
            xValueMapper: (MultiValueChartData item, _) => item.label,
            yValueMapper: (MultiValueChartData item, _) => item.v1,
            name: 'Calificación (0-10)',
            color: const Color(0xFF69F0AE),
            width: 3,
            splineType: SplineType.natural,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              width: 7,
              height: 7,
              color: Color(0xFF69F0AE),
              borderColor: Colors.white,
              borderWidth: 1.5,
            ),
          ),
          SplineSeries<MultiValueChartData, String>(
            dataSource: data,
            xValueMapper: (MultiValueChartData item, _) => item.label,
            yValueMapper: (MultiValueChartData item, _) => item.v2,
            name: 'Popularidad (0-10)',
            color: const Color(0xFFFFAB40),
            width: 2.5,
            dashArray: const <double>[6, 4],
            splineType: SplineType.natural,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.diamond,
              width: 7,
              height: 7,
              color: Color(0xFFFFAB40),
              borderColor: Colors.white,
              borderWidth: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 6. Spline con Tooltip ──────────────────────────────────────────

/// Gráfica Spline interactiva con soporte de TooltipBehavior.
class SplineWithTooltipChart extends StatelessWidget {
  const SplineWithTooltipChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return _buildSplineCard(
        title: 'Spline con Tooltip',
        subtitle: 'Interacción y detalles al pulsar',
        child: _buildEmptyState(),
      );
    }

    final data = ChartDataProcessor.ratingsData(movies, 8);
    final TooltipBehavior tooltipBehavior = TooltipBehavior(
      enable: true,
      header: 'Película',
      canShowMarker: true,
      format: 'point.x : point.y ★',
      color: const Color(0xFF2A2E43),
      textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      borderColor: const Color(0xFF64FFDA),
      borderWidth: 1,
    );

    return _buildSplineCard(
      title: 'Spline con Tooltip',
      subtitle: 'Toque o deslice sobre los puntos para ver el detalle',
      child: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        tooltipBehavior: tooltipBehavior,
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          labelIntersectAction: AxisLabelIntersectAction.rotate45,
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24, width: 1),
        ),
        primaryYAxis: const NumericAxis(
          minimum: 0,
          maximum: 10,
          interval: 2,
          labelStyle: TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: MajorGridLines(color: Color(0xFF2A2E43), width: 0.8),
          axisLine: AxisLine(width: 0),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          SplineSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData item, _) => item.label,
            yValueMapper: (MovieChartData item, _) => item.value,
            name: 'Calificación',
            color: const Color(0xFF64FFDA),
            width: 3,
            enableTooltip: true,
            splineType: SplineType.clamped,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.diamond,
              width: 8,
              height: 8,
              color: Color(0xFFFFD740),
              borderColor: Colors.white,
              borderWidth: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
