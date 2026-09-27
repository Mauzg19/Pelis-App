import 'package:flutter_test/flutter_test.dart';
import 'package:pelisapp/core/models/movie.dart';
import 'package:pelisapp/features/syncfusion_charts/data/chart_data_processor.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/advanced/circular_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/advanced/financial_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/advanced/histogram_box_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/advanced/pyramid_funnel_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/advanced/range_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/advanced/spark_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/advanced/stacked_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/advanced/waterfall_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/basic/area_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/basic/bar_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/basic/bubble_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/basic/column_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/basic/fast_line_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/basic/line_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/basic/scatter_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/basic/spline_charts.dart';
import 'package:pelisapp/features/syncfusion_charts/presentation/basic/step_line_charts.dart';

void main() {
  final movies = [
    _movie(id: 1, rating: 8, popularity: 25, releaseDate: '2024-03-01'),
    _movie(id: 2, rating: 6, popularity: 5, releaseDate: '2023-06-15'),
  ];

  test('Syncfusion builds the planned 43 basic charts', () {
    final charts = [
      ...buildLineCharts(movies),
      ...buildColumnCharts(movies),
      ...buildBarCharts(movies),
      ...buildAreaCharts(movies),
      ...buildSplineCharts(movies),
      ...buildStepLineCharts(movies),
      ...buildFastLineCharts(movies),
      ...buildScatterCharts(movies),
      ...buildBubbleCharts(movies),
    ];

    expect(charts, hasLength(43));
  });

  test('Syncfusion builds the planned 36 advanced charts', () {
    final charts = [
      ...buildStackedCharts(movies),
      ...buildRangeCharts(movies),
      ...buildFinancialCharts(movies),
      ...buildCircularCharts(movies),
      ...buildPyramidFunnelCharts(movies),
      ...buildWaterfallCharts(movies),
      ...buildHistogramBoxCharts(movies),
      ...buildSparkCharts(movies),
    ];

    expect(charts, hasLength(36));
  });

  test('range and financial data handle empty or undated TMDB movies', () {
    expect(ChartDataProcessor.rangeData([]), isEmpty);

    final data = ChartDataProcessor.financialData([
      _movie(id: 3, rating: 9, popularity: 10, releaseDate: ''),
      movies.first,
    ]);

    expect(data, hasLength(1));
    expect(data.single.date, DateTime(2024, 3, 1));
    expect(data.single.open, 8);
    expect(data.single.close, 10);
    expect(data.single.low, 8);
    expect(data.single.high, 10);
  });
}

Movie _movie({
  required int id,
  required double rating,
  required double popularity,
  required String releaseDate,
}) => Movie(
  id: id,
  title: 'Película $id',
  overview: 'Descripción $id',
  posterPath: '',
  backdropPath: '',
  releaseDate: releaseDate,
  voteAverage: rating,
  genreIds: [28, 18],
  runtime: 120,
  budget: null,
  revenue: null,
  originalLanguage: 'es',
  status: 'Released',
  popularity: popularity,
);
