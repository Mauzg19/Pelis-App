import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

/// Retorna la lista con las 5 tarjetas de gráficas de área.
List<Widget> buildAreaCharts(List<Movie> movies) {
  return [
    AreaSimpleChart(movies: movies),
    AreaGradientChart(movies: movies),
    AreaBorderChart(movies: movies),
    AreaTranslucentChart(movies: movies),
    AreaMultiSeriesChart(movies: movies),
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Área Simple — Basic AreaSeries. Color #69F0AE con opacidad 0.5
// ─────────────────────────────────────────────────────────────────────────────

class AreaSimpleChart extends StatelessWidget {
  final List<Movie> movies;

  const AreaSimpleChart({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(movies);

    return _buildChartCard(
      title: 'Área Simple',
      subtitle: 'Calificaciones de películas destacadas',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(8),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: 'Calificación',
          format: 'point.x: point.y ⭐',
          color: const Color(0xFF22283A),
          textStyle: const TextStyle(color: Colors.white),
        ),
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 10,
          interval: 2,
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: const MajorGridLines(color: Color(0x1FFFFFFF), width: 0.8),
          axisLine: const AxisLine(width: 0),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          AreaSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData m, _) => m.label,
            yValueMapper: (MovieChartData m, _) => m.value,
            name: 'Calificación',
            color: const Color(0xFF69F0AE),
            opacity: 0.5,
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Área con Gradiente — AreaSeries con LinearGradient usando onCreateShader
// ─────────────────────────────────────────────────────────────────────────────

class AreaGradientChart extends StatelessWidget {
  final List<Movie> movies;

  const AreaGradientChart({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.popularityData(movies);

    return _buildChartCard(
      title: 'Área con Gradiente',
      subtitle: 'Popularidad con transición púrpura a cian',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(8),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: 'Popularidad',
          format: 'point.x: point.y',
          color: const Color(0xFF22283A),
          textStyle: const TextStyle(color: Colors.white),
        ),
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: NumericAxis(
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: const MajorGridLines(color: Color(0x1FFFFFFF), width: 0.8),
          axisLine: const AxisLine(width: 0),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          AreaSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData m, _) => m.label,
            yValueMapper: (MovieChartData m, _) => m.value,
            name: 'Popularidad',
            onCreateShader: (ShaderDetails details) {
              return const LinearGradient(
                colors: <Color>[
                  Color(0xFF7C4DFF), // Morado vibrante
                  Color(0xFF18FFFF), // Cian vibrante
                ],
                stops: <double>[0.0, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(details.rect);
            },
            borderColor: const Color(0xFF18FFFF),
            borderWidth: 2,
            borderDrawMode: BorderDrawMode.top,
            markerSettings: const MarkerSettings(
              isVisible: true,
              height: 5,
              width: 5,
              shape: DataMarkerType.circle,
              color: Color(0xFF18FFFF),
              borderColor: Colors.white,
              borderWidth: 1,
            ),
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Área con Bordes — AreaSeries con borderColor y borderWidth
// ─────────────────────────────────────────────────────────────────────────────

class AreaBorderChart extends StatelessWidget {
  final List<Movie> movies;

  const AreaBorderChart({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(movies);

    return _buildChartCard(
      title: 'Área con Bordes',
      subtitle: 'Contorno naranja sólido con relleno translúcido',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(8),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: 'Calificación',
          format: 'point.x: point.y / 10',
          color: const Color(0xFF22283A),
          textStyle: const TextStyle(color: Colors.white),
        ),
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 10,
          interval: 2,
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: const MajorGridLines(color: Color(0x1FFFFFFF), width: 0.8),
          axisLine: const AxisLine(width: 0),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          AreaSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData m, _) => m.label,
            yValueMapper: (MovieChartData m, _) => m.value,
            name: 'Puntuación',
            color: const Color(0xFFFFAB40).withValues(alpha: 0.25),
            borderColor: const Color(0xFFFFAB40),
            borderWidth: 3,
            borderDrawMode: BorderDrawMode.all,
            markerSettings: const MarkerSettings(
              isVisible: true,
              height: 6,
              width: 6,
              shape: DataMarkerType.diamond,
              color: Color(0xFFFFAB40),
              borderColor: Colors.white,
              borderWidth: 1,
            ),
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                color: Color(0xFFFFD740),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
              labelAlignment: ChartDataLabelAlignment.top,
            ),
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Área Semitransparente — AreaSeries con opacity: 0.3 y borderColor sólido
// ─────────────────────────────────────────────────────────────────────────────

class AreaTranslucentChart extends StatelessWidget {
  final List<Movie> movies;

  const AreaTranslucentChart({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.popularityData(movies);

    return _buildChartCard(
      title: 'Área Semitransparente',
      subtitle: 'Popularidad con baja opacidad y borde rosa sólido',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(8),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: 'Popularidad',
          format: 'point.x: point.y',
          color: const Color(0xFF22283A),
          textStyle: const TextStyle(color: Colors.white),
        ),
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: NumericAxis(
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: const MajorGridLines(color: Color(0x1FFFFFFF), width: 0.8),
          axisLine: const AxisLine(width: 0),
        ),
        series: <CartesianSeries<MovieChartData, String>>[
          AreaSeries<MovieChartData, String>(
            dataSource: data,
            xValueMapper: (MovieChartData m, _) => m.label,
            yValueMapper: (MovieChartData m, _) => m.value,
            name: 'Popularidad',
            color: const Color(0xFFFF4081),
            opacity: 0.3,
            borderColor: const Color(0xFFFF4081),
            borderWidth: 2.5,
            borderDrawMode: BorderDrawMode.top,
            markerSettings: const MarkerSettings(
              isVisible: true,
              height: 5,
              width: 5,
              shape: DataMarkerType.rectangle,
              color: Color(0xFFFF4081),
              borderColor: Colors.white70,
              borderWidth: 1,
            ),
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. Área Multiserie — Dos AreaSeries superpuestas (rating + popularidad norm)
// ─────────────────────────────────────────────────────────────────────────────

class AreaMultiSeriesChart extends StatelessWidget {
  final List<Movie> movies;

  const AreaMultiSeriesChart({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingVsPopularity(movies);

    return _buildChartCard(
      title: 'Área Multiserie',
      subtitle: 'Comparativa de calificación y popularidad normalizada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(8),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.top,
          alignment: ChartAlignment.center,
          textStyle: TextStyle(color: Colors.white70, fontSize: 11),
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          shared: true,
          color: const Color(0xFF22283A),
          textStyle: const TextStyle(color: Colors.white),
        ),
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 10,
          interval: 2,
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
          majorGridLines: const MajorGridLines(color: Color(0x1FFFFFFF), width: 0.8),
          axisLine: const AxisLine(width: 0),
        ),
        series: <CartesianSeries<MultiValueChartData, String>>[
          AreaSeries<MultiValueChartData, String>(
            dataSource: data,
            xValueMapper: (MultiValueChartData m, _) => m.label,
            yValueMapper: (MultiValueChartData m, _) => m.v1,
            name: 'Calificación',
            color: const Color(0xFF448AFF),
            opacity: 0.45,
            borderColor: const Color(0xFF448AFF),
            borderWidth: 2,
            borderDrawMode: BorderDrawMode.top,
            markerSettings: const MarkerSettings(
              isVisible: true,
              height: 4,
              width: 4,
              shape: DataMarkerType.circle,
              color: Color(0xFF448AFF),
            ),
            animationDuration: 1200,
          ),
          AreaSeries<MultiValueChartData, String>(
            dataSource: data,
            xValueMapper: (MultiValueChartData m, _) => m.label,
            yValueMapper: (MultiValueChartData m, _) => m.v2,
            name: 'Popularidad (norm)',
            color: const Color(0xFF64FFDA),
            opacity: 0.45,
            borderColor: const Color(0xFF64FFDA),
            borderWidth: 2,
            borderDrawMode: BorderDrawMode.top,
            markerSettings: const MarkerSettings(
              isVisible: true,
              height: 4,
              width: 4,
              shape: DataMarkerType.diamond,
              color: Color(0xFF64FFDA),
            ),
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper para envolver cada gráfica en una tarjeta con estilo estándar
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildChartCard({
  required String title,
  required Widget chart,
  String? subtitle,
}) {
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
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
        ],
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: chart,
        ),
      ],
    ),
  );
}
