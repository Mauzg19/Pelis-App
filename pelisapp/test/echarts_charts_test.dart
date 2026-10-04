import 'package:flutter_test/flutter_test.dart';
import 'package:pelisapp/core/models/movie.dart';
import 'package:pelisapp/features/echarts/data/echarts_data_processor.dart';
import 'package:pelisapp/features/echarts/presentation/advanced/echarts_gauge.dart';
import 'package:pelisapp/features/echarts/presentation/advanced/echarts_graph.dart';
import 'package:pelisapp/features/echarts/presentation/advanced/echarts_heatmap.dart';
import 'package:pelisapp/features/echarts/presentation/advanced/echarts_mixed.dart';
import 'package:pelisapp/features/echarts/presentation/advanced/echarts_parallel.dart';
import 'package:pelisapp/features/echarts/presentation/advanced/echarts_sankey.dart';
import 'package:pelisapp/features/echarts/presentation/advanced/echarts_sunburst.dart';
import 'package:pelisapp/features/echarts/presentation/advanced/echarts_theme_river.dart';
import 'package:pelisapp/features/echarts/presentation/advanced/echarts_treemap.dart';
import 'package:pelisapp/features/echarts/presentation/basic/echarts_area.dart';
import 'package:pelisapp/features/echarts/presentation/basic/echarts_bar.dart';
import 'package:pelisapp/features/echarts/presentation/basic/echarts_boxplot.dart';
import 'package:pelisapp/features/echarts/presentation/basic/echarts_candlestick.dart';
import 'package:pelisapp/features/echarts/presentation/basic/echarts_funnel.dart';
import 'package:pelisapp/features/echarts/presentation/basic/echarts_line.dart';
import 'package:pelisapp/features/echarts/presentation/basic/echarts_pie.dart';
import 'package:pelisapp/features/echarts/presentation/basic/echarts_radar.dart';
import 'package:pelisapp/features/echarts/presentation/basic/echarts_scatter.dart';

void main() {
  final movies = [
    _movie(id: 1, rating: 8, popularity: 25, releaseDate: '2024-03-01'),
    _movie(id: 2, rating: 6, popularity: 5, releaseDate: '2023-06-15'),
  ];

  test('ECharts builds the planned 43 basic charts', () {
    final charts = [
      ...buildEchartsLineCharts(movies),
      ...buildEchartsBarCharts(movies),
      ...buildEchartsAreaCharts(movies),
      ...buildEchartsScatterCharts(movies),
      ...buildEchartsPieCharts(movies),
      ...buildEchartsRadarCharts(movies),
      ...buildEchartsCandlestickCharts(movies),
      ...buildEchartsBoxplotCharts(movies),
      ...buildEchartsFunnelCharts(movies),
    ];

    expect(charts, hasLength(43));
  });

  test('ECharts builds the planned 36 advanced charts', () {
    final charts = [
      ...buildEchartsHeatmapCharts(movies),
      ...buildEchartsTreemapCharts(movies),
      ...buildEchartsSunburstCharts(movies),
      ...buildEchartsGaugeCharts(movies),
      ...buildEchartsSankeyCharts(movies),
      ...buildEchartsGraphCharts(movies),
      ...buildEchartsParallelCharts(movies),
      ...buildEchartsThemeRiverCharts(movies),
      ...buildEchartsMixedCharts(movies),
    ];

    expect(charts, hasLength(36));
  });

  test('ECharts chart builders and processors support empty TMDB results', () {
    expect(buildEchartsLineCharts([]), isNotEmpty);
    expect(buildEchartsRadarCharts([]), hasLength(5));
    expect(buildEchartsHeatmapCharts([]), hasLength(3));
    expect(EchartsDataProcessor.avgRating([]), 0);
    expect(EchartsDataProcessor.sankeyData([])['links'], isEmpty);
    expect(EchartsDataProcessor.themeRiverData([]), isEmpty);
  });

  test('JSON encoding safely preserves movie titles with quotes', () {
    final result = EchartsDataProcessor.encode(['The "Movie"']);

    expect(result, '["The \\"Movie\\""]');
  });

  test(
    'candlestick values compare actual rating and normalized popularity',
    () {
      expect(EchartsDataProcessor.candleCategories(movies), [
        'Película 1',
        'Película 2',
      ]);
      expect(EchartsDataProcessor.candleData(movies), [
        [8, 10, 8, 10],
        [6, 2, 2, 6],
      ]);
    },
  );

  test('ThemeRiver contains only real TMDB genre counts and release years', () {
    expect(EchartsDataProcessor.themeRiverData(movies), [
      ['2023', 1, 'Acción'],
      ['2023', 1, 'Drama'],
      ['2024', 1, 'Acción'],
      ['2024', 1, 'Drama'],
    ]);
  });

  test(
    'treemap and graph relationships are based on TMDB genres and ratings',
    () {
      final treemap = EchartsDataProcessor.treemapData(movies);
      final action = treemap.singleWhere((genre) => genre['name'] == 'Acción');
      expect(action['children'], hasLength(2));
      expect(
        (action['children'] as List<Map<String, dynamic>>).map(
          (movie) => movie['value'],
        ),
        everyElement(1),
      );

      final graph = EchartsDataProcessor.graphData(movies);
      expect(graph['categories'], [
        {'name': 'Rating < 4'},
        {'name': 'Rating 4–7'},
        {'name': 'Rating ≥ 7'},
      ]);
      expect(graph['links'], [
        {'source': 'Película 1 #1', 'target': 'Película 2 #2', 'value': 2},
      ]);
    },
  );
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
