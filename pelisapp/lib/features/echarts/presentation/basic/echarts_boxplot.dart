import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsBoxplotCharts(List<Movie> movies) {
  final groups = EchartsDataProcessor.boxplotData(movies);
  final encode = EchartsDataProcessor.encode;
  final boxData = groups.map(_fiveNumberSummary).toList();
  final labels = List.generate(boxData.length, (index) => 'Grupo ${index + 1}');
  final outliers = movies
      .asMap()
      .entries
      .where((entry) => entry.key % 5 == 0)
      .map((entry) => [entry.key % (labels.isEmpty ? 1 : labels.length), entry.value.voteAverage])
      .toList();

  return [
    echartsCard('Boxplot — distribución de ratings', '{${darkBase()}${tooltip('item')}"xAxis":{"type":"category","data":${encode(labels)},"axisLabel":{"color":"#aaa"}},"yAxis":{"type":"value","min":0,"max":10,"axisLabel":{"color":"#aaa"},"splitLine":{"lineStyle":{"color":"#222"}}},"series":[{"type":"boxplot","data":${encode(boxData)}}]}'),
    echartsCard('Boxplot con valores atípicos', '{${darkBase()}${tooltip('item')}"xAxis":{"type":"category","data":${encode(labels)},"axisLabel":{"color":"#aaa"}},"yAxis":{"type":"value","min":0,"max":10,"axisLabel":{"color":"#aaa"}},"series":[{"type":"boxplot","data":${encode(boxData)}},{"type":"scatter","data":${encode(outliers)},"itemStyle":{"color":"#FFD740"}}]}'),
  ];
}

List<double> _fiveNumberSummary(List<double> values) {
  if (values.isEmpty) return [0, 0, 0, 0, 0];
  final sorted = [...values]..sort();
  double percentile(double fraction) {
    final index = (sorted.length - 1) * fraction;
    final lower = index.floor();
    final upper = index.ceil();
    if (lower == upper) return sorted[lower];
    return sorted[lower] * (upper - index) + sorted[upper] * (index - lower);
  }

  return [sorted.first, percentile(0.25), percentile(0.5), percentile(0.75), sorted.last];
}
