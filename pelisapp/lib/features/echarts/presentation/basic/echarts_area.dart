import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsAreaCharts(List<Movie> movies) {
  final labels = EchartsDataProcessor.movieLabels(movies);
  final ratings = EchartsDataProcessor.ratings(movies);
  final popularity = EchartsDataProcessor.popularityNorm(movies);
  final encode = EchartsDataProcessor.encode;
  const area = '"areaStyle":{"opacity":0.45}';

  return [
    echartsCard('Área — Ratings', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"line","data":${encode(ratings)},$area}]}'),
    echartsCard('Área suavizada — Ratings', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"line","smooth":true,"data":${encode(ratings)},$area}]}'),
    echartsCard('Áreas apiladas', '{${darkBase()}${tooltip()}${legend(['Rating', 'Popularidad'])}${catX(labels)}${numY(max: 20)}"series":[{"name":"Rating","type":"line","stack":"total","data":${encode(ratings)},$area},{"name":"Popularidad","type":"line","stack":"total","data":${encode(popularity)},$area}]}'),
    echartsCard('Área con gradiente', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"line","data":${encode(ratings)},"areaStyle":{"color":{"type":"linear","x":0,"y":0,"x2":0,"y2":1,"colorStops":[{"offset":0,"color":"rgba(124,77,255,0.8)"},{"offset":1,"color":"rgba(124,77,255,0.05)"}]}}}]}'),
    echartsCard('Área — Rating y popularidad', '{${darkBase()}${tooltip()}${legend(['Rating', 'Popularidad'])}${catX(labels)}${numY(max: 10)}"series":[{"name":"Rating","type":"line","data":${encode(ratings)},$area},{"name":"Popularidad","type":"line","data":${encode(popularity)},$area}]}'),
  ];
}
