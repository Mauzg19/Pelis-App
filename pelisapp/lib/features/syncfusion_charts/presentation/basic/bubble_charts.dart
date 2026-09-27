import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/models/movie.dart';
import '../../data/chart_data_processor.dart';

/// Retorna la lista de todas las tarjetas de gráficas de burbujas.
List<Widget> buildBubbleCharts(List<Movie> movies) {
  return [
    SimpleBubbleChart(movies: movies),
    GradientBubbleChart(movies: movies),
  ];
}

/// Gráfica 1: Burbuja Simple con color uniforme #64FFDA.
class SimpleBubbleChart extends StatelessWidget {
  const SimpleBubbleChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.bubbleData(movies);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D2235),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Burbuja Simple',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: SfCartesianChart(
              plotAreaBackgroundColor: const Color(0xFF111526),
              plotAreaBorderWidth: 0,
              margin: const EdgeInsets.all(8),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: 'Película',
                canShowMarker: false,
                format: 'Rating: point.x | Popularidad: point.y',
              ),
              primaryXAxis: const NumericAxis(
                title: AxisTitle(
                  text: 'Rating',
                  textStyle: TextStyle(color: Colors.white70, fontSize: 10),
                ),
                labelStyle: TextStyle(color: Colors.white60, fontSize: 10),
                axisLine: AxisLine(color: Colors.white24),
                majorGridLines: MajorGridLines(
                  color: Colors.white10,
                  dashArray: [4, 4],
                ),
                majorTickLines: MajorTickLines(color: Colors.white24),
              ),
              primaryYAxis: const NumericAxis(
                title: AxisTitle(
                  text: 'Popularidad',
                  textStyle: TextStyle(color: Colors.white70, fontSize: 10),
                ),
                labelStyle: TextStyle(color: Colors.white60, fontSize: 10),
                axisLine: AxisLine(color: Colors.white24),
                majorGridLines: MajorGridLines(
                  color: Colors.white10,
                  dashArray: [4, 4],
                ),
                majorTickLines: MajorTickLines(color: Colors.white24),
              ),
              series: <BubbleSeries<BubbleChartData, double>>[
                BubbleSeries<BubbleChartData, double>(
                  dataSource: data,
                  xValueMapper: (BubbleChartData d, _) => d.x,
                  yValueMapper: (BubbleChartData d, _) => d.y,
                  sizeValueMapper: (BubbleChartData d, _) => d.size,
                  name: 'Películas',
                  color: const Color(0xFF64FFDA),
                  opacity: 0.7,
                  borderColor: const Color(0xFF64FFDA),
                  borderWidth: 1.5,
                  minimumRadius: 4,
                  maximumRadius: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Gráfica 2: Burbuja con gradiente de color (#7C4DFF a #18FFFF) por índice.
class GradientBubbleChart extends StatelessWidget {
  const GradientBubbleChart({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final data = ChartDataProcessor.bubbleData(movies);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D2235),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Burbuja con Gradiente',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: SfCartesianChart(
              plotAreaBackgroundColor: const Color(0xFF111526),
              plotAreaBorderWidth: 0,
              margin: const EdgeInsets.all(8),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: 'Película',
                canShowMarker: false,
                format: 'Rating: point.x | Popularidad: point.y',
              ),
              primaryXAxis: const NumericAxis(
                title: AxisTitle(
                  text: 'Rating',
                  textStyle: TextStyle(color: Colors.white70, fontSize: 10),
                ),
                labelStyle: TextStyle(color: Colors.white60, fontSize: 10),
                axisLine: AxisLine(color: Colors.white24),
                majorGridLines: MajorGridLines(
                  color: Color(0x1F7C4DFF),
                  dashArray: [4, 4],
                ),
                majorTickLines: MajorTickLines(color: Colors.white24),
              ),
              primaryYAxis: const NumericAxis(
                title: AxisTitle(
                  text: 'Popularidad',
                  textStyle: TextStyle(color: Colors.white70, fontSize: 10),
                ),
                labelStyle: TextStyle(color: Colors.white60, fontSize: 10),
                axisLine: AxisLine(color: Colors.white24),
                majorGridLines: MajorGridLines(
                  color: Color(0x1F18FFFF),
                  dashArray: [4, 4],
                ),
                majorTickLines: MajorTickLines(color: Colors.white24),
              ),
              series: <BubbleSeries<BubbleChartData, double>>[
                BubbleSeries<BubbleChartData, double>(
                  dataSource: data,
                  xValueMapper: (BubbleChartData d, _) => d.x,
                  yValueMapper: (BubbleChartData d, _) => d.y,
                  sizeValueMapper: (BubbleChartData d, _) => d.size,
                  pointColorMapper: (BubbleChartData d, int index) {
                    final t = data.length > 1 ? index / (data.length - 1) : 0.0;
                    return Color.lerp(
                      const Color(0xFF7C4DFF),
                      const Color(0xFF18FFFF),
                      t,
                    );
                  },
                  name: 'Gradiente',
                  opacity: 0.85,
                  borderColor: Colors.white38,
                  borderWidth: 1,
                  minimumRadius: 4,
                  maximumRadius: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Aliases para soporte de nombres alternativos
typedef BubbleSimpleChart = SimpleBubbleChart;
typedef BubbleGradientChart = GradientBubbleChart;
