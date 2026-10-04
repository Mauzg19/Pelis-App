import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsMixedCharts(List<Movie> movies) {
  final labels = EchartsDataProcessor.movieLabels(movies);
  final ratings = EchartsDataProcessor.ratings(movies);
  final popularity = EchartsDataProcessor.popularityNorm(movies);
  final genres = movies.take(10).map((movie) => movie.genreIds.length.toDouble()).toList();
  final encode = EchartsDataProcessor.encode;
  final pie = EchartsDataProcessor.genrePieData(movies);

  return [
    echartsCard('Combinado — barras y línea de rating', '{${darkBase()}${tooltip()}${legend(['Rating', 'Tendencia'])}${catX(labels)}${numY(max: 10)}"series":[{"name":"Rating","type":"bar","data":${encode(ratings)}},{"name":"Tendencia","type":"line","data":${encode(ratings)},"smooth":true,"symbol":"circle"}]}'),
    echartsCard('Combinado — ratings y popularidad', '{${darkBase()}${tooltip()}${legend(['Rating', 'Popularidad'])}${catX(labels)}${numY(max: 10)}"series":[{"name":"Rating","type":"bar","data":${encode(ratings)}},{"name":"Popularidad","type":"line","data":${encode(popularity)},"yAxisIndex":1}],"yAxis":[{"type":"value","max":10,"axisLabel":{"color":"#aaa"}},{"type":"value","max":10,"axisLabel":{"color":"#aaa"},"splitLine":{"show":false}}]}'),
    echartsCard('Combinado — área y línea', '{${darkBase()}${tooltip()}${legend(['Rating', 'Popularidad'])}${catX(labels)}${numY(max: 10)}"series":[{"name":"Rating","type":"line","data":${encode(ratings)},"areaStyle":{"opacity":0.28}},{"name":"Popularidad","type":"line","data":${encode(popularity)},"smooth":true,"lineStyle":{"type":"dashed"}}]}'),
    echartsCard('Combinado — barras y dispersión', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"bar","data":${encode(ratings)},"barMaxWidth":24},{"type":"scatter","data":${encode(ratings)},"symbolSize":12,"itemStyle":{"color":"#FFD740"}}]}'),
    echartsCard('Combinado — ratings con promedio', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"bar","data":${encode(ratings)},"itemStyle":{"color":"#448AFF"}},{"type":"line","data":${encode(ratings)},"symbol":"none","markLine":{"data":[{"type":"average","name":"Media"}]}}]}'),
    echartsCard('Combinado — rating, popularidad y géneros', '{${darkBase()}${tooltip()}${legend(['Rating', 'Popularidad', 'Géneros'])}${catX(labels)}${numY(max: 10)}"series":[{"name":"Rating","type":"bar","data":${encode(ratings)}},{"name":"Popularidad","type":"line","data":${encode(popularity)},"smooth":true},{"name":"Géneros","type":"scatter","data":${encode(genres)},"symbolSize":10}]}'),
    echartsCard('Combinado — dona de géneros y rating', '{${darkBase()}${tooltip('item')}"legend":{"textStyle":{"color":"#ccc"},"bottom":0},"xAxis":{"type":"category","data":${encode(labels)},"axisLabel":{"color":"#aaa","rotate":30,"fontSize":8}},"yAxis":{"type":"value","max":10,"axisLabel":{"color":"#aaa"}},"series":[{"type":"bar","data":${encode(ratings)},"barMaxWidth":22},{"type":"pie","radius":["18%","32%"],"center":["78%","28%"],"data":${encode(pie)},"label":{"show":false}}]}'),
    echartsCard('Combinado — áreas apiladas y línea', '{${darkBase()}${tooltip()}${legend(['Rating', 'Popularidad', 'Media'])}${catX(labels)}${numY(max: 20)}"series":[{"name":"Rating","type":"line","stack":"total","data":${encode(ratings)},"areaStyle":{"opacity":0.35}},{"name":"Popularidad","type":"line","stack":"total","data":${encode(popularity)},"areaStyle":{"opacity":0.35}},{"name":"Media","type":"line","data":${encode(ratings)},"lineStyle":{"width":3,"type":"dashed"}}]}'),
    echartsCard('Combinado — radar y barras comparativas', '{${darkBase()}${tooltip('item')}${catX(labels)}${numY(max: 10)}"grid":{"left":"8%","right":"48%","bottom":"18%"},"series":[{"type":"bar","data":${encode(ratings)}},{"type":"radar","center":["73%","50%"],"radius":"38%","radar":{"indicator":${encode(EchartsDataProcessor.radarIndicators())},"axisName":{"color":"#ccc","fontSize":8}},"data":[{"value":${encode(movies.isEmpty ? List<double>.filled(5, 0) : EchartsDataProcessor.radarValues(movies.first))},"name":"Película"}]}]}'),
  ];
}
