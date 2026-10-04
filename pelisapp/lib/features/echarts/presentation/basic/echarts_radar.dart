import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsRadarCharts(List<Movie> movies) {
  final indicators = EchartsDataProcessor.radarIndicators();
  final encode = EchartsDataProcessor.encode;
  final selected = movies.take(3).toList();
  final series = selected
      .map((movie) => {
            'name': movie.title,
            'value': EchartsDataProcessor.radarValues(movie),
          })
      .toList();
  final firstValues = selected.isEmpty
      ? List<double>.filled(indicators.length, 0)
      : EchartsDataProcessor.radarValues(selected.first);
  final firstName = encode(
    selected.isEmpty ? 'Película' : selected.first.title,
  );
  final secondValues = selected.length < 2
      ? List<double>.filled(indicators.length, 0)
      : EchartsDataProcessor.radarValues(selected[1]);

  return [
    echartsCard('Radar — perfil de la primera película', '{${darkBase()}${tooltip('item')}"radar":{"indicator":${encode(indicators)},"axisName":{"color":"#ccc"},"splitLine":{"lineStyle":{"color":"#333"}}},"series":[{"type":"radar","data":[{"value":${encode(firstValues)},"name":$firstName}]}]}'),
    echartsCard('Radar — comparar películas', '{${darkBase()}${tooltip('item')}${legend(selected.map((movie) => movie.title).toList())}"radar":{"indicator":${encode(indicators)},"axisName":{"color":"#ccc"}},"series":[{"type":"radar","data":${encode(series)}}]}'),
    echartsCard('Radar relleno', '{${darkBase()}${tooltip('item')}"radar":{"indicator":${encode(indicators)},"axisName":{"color":"#ccc"}},"series":[{"type":"radar","areaStyle":{"opacity":0.3},"data":[{"value":${encode(firstValues)},"name":"Rating"},{"value":${encode(secondValues)},"name":"Comparación"}]}]}'),
    echartsCard('Radar — Rating frente a popularidad', '{${darkBase()}${tooltip('item')}"radar":{"indicator":[{"name":"Rating","max":10},{"name":"Popularidad","max":10}],"axisName":{"color":"#ccc"}},"series":[{"type":"radar","data":[{"value":[${movies.isEmpty ? 0 : movies.first.voteAverage},${movies.isEmpty ? 0 : EchartsDataProcessor.popularityNorm(movies, 1).first}],"name":"Película"}]}]}'),
    echartsCard('Radar de métricas promedio', '{${darkBase()}${tooltip('item')}"radar":{"indicator":${encode(indicators)},"axisName":{"color":"#ccc"}},"series":[{"type":"radar","data":[{"value":${encode(movies.isEmpty ? List<double>.filled(indicators.length, 0) : List<double>.generate(indicators.length, (i) => selected.map((movie) => EchartsDataProcessor.radarValues(movie)[i]).reduce((a, b) => a + b) / selected.length))},"name":"Promedio"}]}]}'),
  ];
}
