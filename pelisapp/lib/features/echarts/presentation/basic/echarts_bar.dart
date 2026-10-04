import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsBarCharts(List<Movie> movies) {
  final labels = EchartsDataProcessor.movieLabels(movies);
  final ratings = EchartsDataProcessor.ratings(movies);
  final popularity = EchartsDataProcessor.popularityNorm(movies);
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard('Barras verticales — Rating', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"bar","data":${encode(ratings)}}]}'),
    echartsCard('Barras horizontales — Rating', '{${darkBase()}${tooltip()}${legend(['Rating'])}"xAxis":{"type":"value","max":10,"axisLabel":{"color":"#aaa"},"splitLine":{"lineStyle":{"color":"#222"}}},"yAxis":{"type":"category","data":${encode(labels)},"axisLabel":{"color":"#aaa","fontSize":9}},"series":[{"name":"Rating","type":"bar","data":${encode(ratings)},"itemStyle":{"color":"#448AFF"}}]}'),
    echartsCard('Barras con bordes redondeados', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"bar","data":${encode(ratings)},"itemStyle":{"color":"#7C4DFF","borderRadius":[8,8,0,0]}}]}'),
    echartsCard('Barras multiserie — Rating y popularidad', '{${darkBase()}${tooltip()}${legend(['Rating', 'Popularidad'])}${catX(labels)}${numY(max: 10)}"series":[{"name":"Rating","type":"bar","data":${encode(ratings)}},{"name":"Popularidad","type":"bar","data":${encode(popularity)}}]}'),
    echartsCard('Barras apiladas', '{${darkBase()}${tooltip()}${legend(['Rating', 'Popularidad'])}${catX(labels)}${numY(max: 20)}"series":[{"name":"Rating","type":"bar","stack":"total","data":${encode(ratings)}},{"name":"Popularidad","type":"bar","stack":"total","data":${encode(popularity)}}]}'),
    echartsCard('Barras con gradiente', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"bar","data":${encode(ratings)},"itemStyle":{"color":{"type":"linear","x":0,"y":0,"x2":0,"y2":1,"colorStops":[{"offset":0,"color":"#18FFFF"},{"offset":1,"color":"#7C4DFF"}]}}}]}'),
    echartsCard('Barras con promedio', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"bar","data":${encode(ratings)},"markLine":{"data":[{"type":"average","name":"Promedio"}]}}]}'),
  ];
}
