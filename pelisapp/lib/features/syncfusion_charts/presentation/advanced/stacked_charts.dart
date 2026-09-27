import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

/// Retorna la lista con las 8 tarjetas de gráficas apiladas (Stacked).
List<Widget> buildStackedCharts(List<Movie> movies) {
  return [
    StackedColumnChartWidget(movies: movies),
    StackedBarChartWidget(movies: movies),
    StackedAreaChartWidget(movies: movies),
    StackedLineChartWidget(movies: movies),
    StackedColumn100ChartWidget(movies: movies),
    StackedBar100ChartWidget(movies: movies),
    StackedArea100ChartWidget(movies: movies),
    StackedLine100ChartWidget(movies: movies),
  ];
}

/// Contenedor reutilizable estilo tarjeta con fondo oscuro y bordes redondeados.
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
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: chart,
        ),
      ],
    ),
  );
}

// ─── 1. Columna Apilada ────────────────────────────────────────────────────────

class StackedColumnChartWidget extends StatelessWidget {
  final List<Movie> movies;

  const StackedColumnChartWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.stackedData(movies);
    return _buildCard(
      title: 'Columna Apilada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(4),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(color: Color(0x1FFFFFFF), width: 0.5),
          axisLine: AxisLine(color: Colors.white24),
        ),
        series: [
          StackedColumnSeries<MultiValueChartData, String>(
            name: 'Rating',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v1,
            color: const Color(0xFF7C4DFF),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
          ),
          StackedColumnSeries<MultiValueChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v2,
            color: const Color(0xFF64FFDA),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      ),
    );
  }
}

// ─── 2. Barra Apilada ──────────────────────────────────────────────────────────

class StackedBarChartWidget extends StatelessWidget {
  final List<Movie> movies;

  const StackedBarChartWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.stackedData(movies);
    return _buildCard(
      title: 'Barra Apilada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(4),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(color: Color(0x1FFFFFFF), width: 0.5),
          axisLine: AxisLine(color: Colors.white24),
        ),
        series: [
          StackedBarSeries<MultiValueChartData, String>(
            name: 'Rating',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v1,
            color: const Color(0xFF448AFF),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)),
          ),
          StackedBarSeries<MultiValueChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v2,
            color: const Color(0xFFFFAB40),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
          ),
        ],
      ),
    );
  }
}

// ─── 3. Área Apilada ──────────────────────────────────────────────────────────

class StackedAreaChartWidget extends StatelessWidget {
  final List<Movie> movies;

  const StackedAreaChartWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.stackedData(movies);
    return _buildCard(
      title: 'Área Apilada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(4),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(color: Color(0x1FFFFFFF), width: 0.5),
          axisLine: AxisLine(color: Colors.white24),
        ),
        series: [
          StackedAreaSeries<MultiValueChartData, String>(
            name: 'Rating',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v1,
            color: const Color(0xFF18FFFF).withValues(alpha: 0.6),
            borderColor: const Color(0xFF18FFFF),
            borderWidth: 1.5,
          ),
          StackedAreaSeries<MultiValueChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v2,
            color: const Color(0xFFFF4081).withValues(alpha: 0.6),
            borderColor: const Color(0xFFFF4081),
            borderWidth: 1.5,
          ),
        ],
      ),
    );
  }
}

// ─── 4. Línea Apilada ─────────────────────────────────────────────────────────

class StackedLineChartWidget extends StatelessWidget {
  final List<Movie> movies;

  const StackedLineChartWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.stackedData(movies);
    return _buildCard(
      title: 'Línea Apilada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(4),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(color: Color(0x1FFFFFFF), width: 0.5),
          axisLine: AxisLine(color: Colors.white24),
        ),
        series: [
          StackedLineSeries<MultiValueChartData, String>(
            name: 'Rating',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v1,
            color: const Color(0xFF69F0AE),
            width: 2.5,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              width: 6,
              height: 6,
            ),
          ),
          StackedLineSeries<MultiValueChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v2,
            color: const Color(0xFFFF5252),
            width: 2.5,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.diamond,
              width: 6,
              height: 6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 5. Columna 100% Apilada ──────────────────────────────────────────────────

class StackedColumn100ChartWidget extends StatelessWidget {
  final List<Movie> movies;

  const StackedColumn100ChartWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.stackedData(movies);
    return _buildCard(
      title: 'Columna 100% Apilada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(4),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(color: Color(0x1FFFFFFF), width: 0.5),
          axisLine: AxisLine(color: Colors.white24),
          labelFormat: '{value}%',
        ),
        series: [
          StackedColumn100Series<MultiValueChartData, String>(
            name: 'Rating',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v1,
            color: const Color(0xFF536DFE),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
          ),
          StackedColumn100Series<MultiValueChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v2,
            color: const Color(0xFFFFD740),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
          ),
          StackedColumn100Series<MultiValueChartData, String>(
            name: 'Géneros',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v3 ?? 0,
            color: const Color(0xFFFF4081),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      ),
    );
  }
}

// ─── 6. Barra 100% Apilada ────────────────────────────────────────────────────

class StackedBar100ChartWidget extends StatelessWidget {
  final List<Movie> movies;

  const StackedBar100ChartWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.stackedData(movies);
    return _buildCard(
      title: 'Barra 100% Apilada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(4),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(color: Color(0x1FFFFFFF), width: 0.5),
          axisLine: AxisLine(color: Colors.white24),
          labelFormat: '{value}%',
        ),
        series: [
          StackedBar100Series<MultiValueChartData, String>(
            name: 'Rating',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v1,
            color: const Color(0xFF7C4DFF),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)),
          ),
          StackedBar100Series<MultiValueChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v2,
            color: const Color(0xFF18FFFF),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)),
          ),
          StackedBar100Series<MultiValueChartData, String>(
            name: 'Géneros',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v3 ?? 0,
            color: const Color(0xFF69F0AE),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
          ),
        ],
      ),
    );
  }
}

// ─── 7. Área 100% Apilada ─────────────────────────────────────────────────────

class StackedArea100ChartWidget extends StatelessWidget {
  final List<Movie> movies;

  const StackedArea100ChartWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.stackedData(movies);
    return _buildCard(
      title: 'Área 100% Apilada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(4),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(color: Color(0x1FFFFFFF), width: 0.5),
          axisLine: AxisLine(color: Colors.white24),
          labelFormat: '{value}%',
        ),
        series: [
          StackedArea100Series<MultiValueChartData, String>(
            name: 'Rating',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v1,
            color: const Color(0xFF448AFF).withValues(alpha: 0.6),
            borderColor: const Color(0xFF448AFF),
            borderWidth: 1.5,
          ),
          StackedArea100Series<MultiValueChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v2,
            color: const Color(0xFFFFAB40).withValues(alpha: 0.6),
            borderColor: const Color(0xFFFFAB40),
            borderWidth: 1.5,
          ),
          StackedArea100Series<MultiValueChartData, String>(
            name: 'Géneros',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v3 ?? 0,
            color: const Color(0xFF64FFDA).withValues(alpha: 0.6),
            borderColor: const Color(0xFF64FFDA),
            borderWidth: 1.5,
          ),
        ],
      ),
    );
  }
}

// ─── 8. Línea 100% Apilada ────────────────────────────────────────────────────

class StackedLine100ChartWidget extends StatelessWidget {
  final List<Movie> movies;

  const StackedLine100ChartWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.stackedData(movies);
    return _buildCard(
      title: 'Línea 100% Apilada',
      chart: SfCartesianChart(
        plotAreaBackgroundColor: const Color(0xFF111526),
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.all(4),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(color: Colors.white24),
          labelIntersectAction: AxisLabelIntersectAction.hide,
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.white70, fontSize: 9),
          majorGridLines: MajorGridLines(color: Color(0x1FFFFFFF), width: 0.5),
          axisLine: AxisLine(color: Colors.white24),
          labelFormat: '{value}%',
        ),
        series: [
          StackedLine100Series<MultiValueChartData, String>(
            name: 'Rating',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v1,
            color: const Color(0xFFFF4081),
            width: 2.5,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.rectangle,
              width: 6,
              height: 6,
            ),
          ),
          StackedLine100Series<MultiValueChartData, String>(
            name: 'Popularidad',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v2,
            color: const Color(0xFF536DFE),
            width: 2.5,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.triangle,
              width: 6,
              height: 6,
            ),
          ),
          StackedLine100Series<MultiValueChartData, String>(
            name: 'Géneros',
            dataSource: data,
            xValueMapper: (MultiValueChartData d, _) => d.label,
            yValueMapper: (MultiValueChartData d, _) => d.v3 ?? 0,
            color: const Color(0xFFFFD740),
            width: 2.5,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.pentagon,
              width: 6,
              height: 6,
            ),
          ),
        ],
      ),
    );
  }
}
