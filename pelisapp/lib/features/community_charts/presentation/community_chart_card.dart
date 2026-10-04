import 'dart:math' as math;

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';

import '../data/community_chart_data_processor.dart';
import 'community_chart_catalog.dart';

class CommunityChartCard extends StatelessWidget {
  const CommunityChartCard({
    required this.definition,
    required this.data,
    super.key,
  });

  final CommunityChartDefinition definition;
  final List<CommunityMovieDatum> data;

  static final _colors = [
    charts.MaterialPalette.purple.shadeDefault,
    charts.MaterialPalette.blue.shadeDefault,
    charts.MaterialPalette.green.shadeDefault,
    charts.MaterialPalette.deepOrange.shadeDefault,
    charts.MaterialPalette.red.shadeDefault,
    charts.MaterialPalette.cyan.shadeDefault,
  ];

  num _value(CommunityMovieDatum datum) => switch (definition.metric) {
    CommunityChartMetric.rating => datum.rating,
    CommunityChartMetric.popularity => datum.popularity,
    CommunityChartMetric.genreCount => datum.genreCount,
    CommunityChartMetric.releaseYear => datum.releaseYear ?? 0,
  };

  List<CommunityMovieDatum> get _chartData {
    if (definition.metric == CommunityChartMetric.releaseYear) {
      return data.where((datum) => datum.releaseYear != null).toList();
    }
    return data;
  }

  charts.Color _colorAt(int? index) => _colors[(index ?? 0) % _colors.length];

  charts.Series<CommunityMovieDatum, String> _ordinalSeries(
    String id,
    num Function(CommunityMovieDatum datum) measure,
  ) => charts.Series<CommunityMovieDatum, String>(
    id: id,
    data: _chartData,
    domainFn: (datum, _) => datum.label,
    measureFn: (datum, _) => measure(datum),
    colorFn: (_, index) => _colorAt(index),
    labelAccessorFn: (datum, _) => datum.label,
  );

  charts.Series<CommunityMovieDatum, num> _numericSeries(
    String id,
    num Function(CommunityMovieDatum datum) domain,
    num Function(CommunityMovieDatum datum) measure,
  ) => charts.Series<CommunityMovieDatum, num>(
    id: id,
    data: _chartData,
    domainFn: (datum, _) => domain(datum),
    measureFn: (datum, _) => measure(datum),
    colorFn: (_, index) => _colorAt(index),
    radiusPxFn: (datum, _) => 4 + datum.genreCount.clamp(0, 6),
    labelAccessorFn: (datum, _) => datum.label,
  );

  Widget _buildChart() {
    final metric = _value;
    final variant = definition.variant;

    return switch (definition.type) {
      CommunityChartType.bar => charts.BarChart(
        [
          _ordinalSeries('Rating TMDB', metric),
          if (variant % 3 == 2 || variant % 3 == 4)
            _ordinalSeries('Popularidad', (datum) => datum.popularity),
        ],
        animate: true,
        vertical: variant % 3 != 1,
        barGroupingType: switch (variant % 4) {
          0 => charts.BarGroupingType.grouped,
          1 => charts.BarGroupingType.stacked,
          2 => charts.BarGroupingType.groupedStacked,
          _ => charts.BarGroupingType.grouped,
        },
        defaultRenderer: charts.BarRendererConfig<String>(
          maxBarWidthPx: 26,
          cornerStrategy: charts.ConstCornerStrategy(variant % 2 == 0 ? 5 : 0),
        ),
        domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.NoneRenderSpec(),
        ),
      ),
      CommunityChartType.line => charts.LineChart(
        [
          _numericSeries('Calificación', (datum) => datum.index, metric),
          if (variant % 3 == 1)
            _numericSeries(
              'Popularidad',
              (datum) => datum.index,
              (datum) => datum.popularity,
            ),
        ],
        animate: true,
        defaultRenderer: charts.LineRendererConfig<num>(
          includePoints: variant % 2 == 0,
          includeArea: variant % 4 == 2,
          stacked: variant % 5 == 0,
          dashPattern: variant % 4 == 3 ? [4, 2] : null,
          strokeWidthPx: variant % 3 == 0 ? 3 : 2,
        ),
        domainAxis: charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.NoneRenderSpec(),
        ),
      ),
      CommunityChartType.area => charts.LineChart(
        [
          _numericSeries('Calificación', (datum) => datum.index, metric),
          _numericSeries(
            'Popularidad',
            (datum) => datum.index,
            (datum) => datum.popularity,
          ),
        ],
        animate: true,
        defaultRenderer: charts.LineRendererConfig<num>(
          includeArea: true,
          includePoints: variant % 2 == 0,
          stacked: variant % 3 == 0,
          areaOpacity: 0.35,
        ),
        domainAxis: charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.NoneRenderSpec(),
        ),
      ),
      CommunityChartType.pie => charts.PieChart<int>(
        [
          charts.Series<CommunityMovieDatum, int>(
            id: 'Películas',
            data: _chartData.take(8).toList(),
            domainFn: (datum, _) => datum.index,
            measureFn: (datum, _) => math.max(0.1, metric(datum)),
            colorFn: (_, index) => _colorAt(index),
            labelAccessorFn: (datum, _) => datum.label,
          ),
        ],
        animate: true,
        defaultRenderer: charts.ArcRendererConfig<int>(
          arcWidth: variant.isEven ? 34 : null,
          arcLength: variant % 4 == 3 ? math.pi : math.pi * 2,
        ),
      ),
      CommunityChartType.scatter => charts.ScatterPlotChart(
        [
          _numericSeries(
            'Películas',
            (datum) => switch (variant % 4) {
              0 => datum.rating,
              1 => datum.genreCount,
              2 => datum.popularity,
              _ => (datum.releaseYear ?? 0).toDouble(),
            },
            (datum) => switch (variant % 4) {
              0 => datum.popularity,
              1 => datum.rating,
              2 => datum.genreCount,
              _ => datum.rating,
            },
          ),
        ],
        animate: true,
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.NoneRenderSpec(),
        ),
        domainAxis: charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
        defaultRenderer: charts.PointRendererConfig<num>(
          radiusPx: variant % 2 == 0 ? 6 : 4,
        ),
      ),
      CommunityChartType.combo => charts.OrdinalComboChart(
        [
          _ordinalSeries('Calificación', metric)
            ..setAttribute(charts.rendererIdKey, 'community-bars'),
          _ordinalSeries('Popularidad', (datum) => datum.popularity)
            ..setAttribute(charts.rendererIdKey, 'community-line'),
        ],
        animate: true,
        customSeriesRenderers: [
          charts.BarRendererConfig<String>(
            customRendererId: 'community-bars',
            maxBarWidthPx: 24,
          ),
          charts.LineRendererConfig<String>(
            customRendererId: 'community-line',
            includePoints: true,
            strokeWidthPx: 2.5,
          ),
        ],
        domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.NoneRenderSpec(),
        ),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            definition.title,
            style: const TextStyle(
              color: Color(0xFF20243A),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(height: 190, child: _buildChart()),
        ],
      ),
    );
  }
}
