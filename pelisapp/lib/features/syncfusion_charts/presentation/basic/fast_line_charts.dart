import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

/// Retorna la lista de widgets de tarjetas de gráficas FastLine.
List<Widget> buildFastLineCharts(List<Movie> movies) {
  return [
    FastLineSimpleChart(movies: movies),
    FastLineManyDataChart(movies: movies),
  ];
}

/// 1. FastLine Simple — Muestra las calificaciones de todas las películas disponibles.
class FastLineSimpleChart extends StatelessWidget {
  final List<Movie> movies;

  const FastLineSimpleChart({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.ratingsData(
      movies,
      movies.isNotEmpty ? movies.length : 0,
    );

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D2235),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'FastLine Simple',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF536DFE).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Calificaciones',
                  style: TextStyle(
                    color: Color(0xFF536DFE),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: SfCartesianChart(
              plotAreaBackgroundColor: const Color(0xFF111526),
              plotAreaBorderWidth: 0,
              margin: EdgeInsets.zero,
              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: '',
                canShowMarker: false,
                format: 'point.x: point.y ★',
                color: const Color(0xFF1D2235),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
              primaryXAxis: const CategoryAxis(
                labelIntersectAction: AxisLabelIntersectAction.hide,
                labelStyle: TextStyle(
                  color: Color(0xFFB8B8C8),
                  fontSize: 9,
                ),
                majorGridLines: MajorGridLines(width: 0),
                axisLine: AxisLine(color: Color(0xFF2A314D)),
              ),
              primaryYAxis: const NumericAxis(
                minimum: 0,
                maximum: 10,
                interval: 2,
                labelFormat: '{value}',
                labelStyle: TextStyle(
                  color: Color(0xFFB8B8C8),
                  fontSize: 9,
                ),
                majorGridLines: MajorGridLines(
                  width: 0.5,
                  color: Color(0xFF22283E),
                ),
                axisLine: AxisLine(width: 0),
              ),
              series: <FastLineSeries<MovieChartData, String>>[
                FastLineSeries<MovieChartData, String>(
                  dataSource: data,
                  xValueMapper: (MovieChartData item, _) => item.label,
                  yValueMapper: (MovieChartData item, _) => item.value,
                  name: 'Calificación',
                  color: const Color(0xFF536DFE),
                  width: 2.5,
                  animationDuration: 1000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 2. FastLine con Muchos Datos — Muestra la popularidad de todas las películas disponibles.
class FastLineManyDataChart extends StatelessWidget {
  final List<Movie> movies;

  const FastLineManyDataChart({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.popularityData(
      movies,
      movies.isNotEmpty ? movies.length : 0,
    );

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D2235),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'FastLine con Muchos Datos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF18FFFF).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Popularidad',
                  style: TextStyle(
                    color: Color(0xFF18FFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: SfCartesianChart(
              plotAreaBackgroundColor: const Color(0xFF111526),
              plotAreaBorderWidth: 0,
              margin: EdgeInsets.zero,
              trackballBehavior: TrackballBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                tooltipSettings: const InteractiveTooltip(
                  enable: true,
                  color: Color(0xFF1D2235),
                  borderColor: Color(0xFF18FFFF),
                  borderWidth: 1,
                  textStyle: TextStyle(
                    color: Color(0xFF18FFFF),
                    fontSize: 11,
                  ),
                ),
              ),
              primaryXAxis: const CategoryAxis(
                labelIntersectAction: AxisLabelIntersectAction.hide,
                labelStyle: TextStyle(
                  color: Color(0xFFB8B8C8),
                  fontSize: 8,
                ),
                majorGridLines: MajorGridLines(width: 0),
                axisLine: AxisLine(color: Color(0xFF2A314D)),
              ),
              primaryYAxis: const NumericAxis(
                labelFormat: '{value}',
                labelStyle: TextStyle(
                  color: Color(0xFFB8B8C8),
                  fontSize: 9,
                ),
                majorGridLines: MajorGridLines(
                  width: 0.5,
                  color: Color(0xFF22283E),
                ),
                axisLine: AxisLine(width: 0),
              ),
              series: <FastLineSeries<MovieChartData, String>>[
                FastLineSeries<MovieChartData, String>(
                  dataSource: data,
                  xValueMapper: (MovieChartData item, _) => item.label,
                  yValueMapper: (MovieChartData item, _) => item.value,
                  name: 'Popularidad',
                  color: const Color(0xFF18FFFF),
                  width: 1.8,
                  animationDuration: 1000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
