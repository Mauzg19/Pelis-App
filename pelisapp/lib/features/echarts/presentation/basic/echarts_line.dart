import 'package:flutter/material.dart';
import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsLineCharts(List<Movie> movies) {
  final labels = EchartsDataProcessor.movieLabels(movies);
  final rats = EchartsDataProcessor.ratings(movies);
  final pops = EchartsDataProcessor.popularityNorm(movies);
  final e = EchartsDataProcessor.encode;

  return [
    // 1. Línea simple
    echartsCard('Línea Simple — Ratings', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"line","data":${e(rats)},"lineStyle":{"color":"#7C4DFF"}}]}'),

    // 2. Línea suavizada
    echartsCard('Línea Suavizada — Ratings', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"line","smooth":true,"data":${e(rats)},"lineStyle":{"color":"#448AFF"},"itemStyle":{"color":"#448AFF"}}]}'),

    // 3. Línea con área
    echartsCard('Línea con Área — Ratings', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"line","smooth":true,"data":${e(rats)},"areaStyle":{"color":{"type":"linear","x":0,"y":0,"x2":0,"y2":1,"colorStops":[{"offset":0,"color":"rgba(105,240,174,0.5)"},{"offset":1,"color":"rgba(105,240,174,0.05)"}]}},"lineStyle":{"color":"#69F0AE"},"itemStyle":{"color":"#69F0AE"}}]}'),

    // 4. Línea multiserie
    echartsCard('Multiserie — Rating vs Popularidad', '{${darkBase()}${tooltip()}${legend(['Rating', 'Popularidad'])}${catX(labels)}${numY(max: 10)}"series":[{"name":"Rating","type":"line","data":${e(rats)},"lineStyle":{"color":"#7C4DFF"},"itemStyle":{"color":"#7C4DFF"}},{"name":"Popularidad","type":"line","data":${e(pops)},"lineStyle":{"color":"#FFAB40"},"itemStyle":{"color":"#FFAB40"}}]}'),

    // 5. Línea con marcadores
    echartsCard('Línea con Marcadores — Ratings', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"line","data":${e(rats)},"lineStyle":{"color":"#FF4081"},"itemStyle":{"color":"#FF4081"},"markPoint":{"data":[{"type":"max","name":"Máx"},{"type":"min","name":"Mín"}]},"markLine":{"data":[{"type":"average","name":"Promedio"}]}}]}'),

    // 6. Línea con gradiente
    echartsCard('Línea con Gradiente — Popularidad', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}"series":[{"type":"line","smooth":true,"data":${e(pops)},"lineStyle":{"width":3,"color":{"type":"linear","x":0,"y":0,"x2":1,"y2":0,"colorStops":[{"offset":0,"color":"#7C4DFF"},{"offset":1,"color":"#18FFFF"}]}},"itemStyle":{"color":"#18FFFF"}}]}'),

    // 7. Línea con zoom
    echartsCard('Línea con Zoom — Ratings', '{${darkBase()}${tooltip()}${catX(labels)}${numY(max: 10)}${dataZoom()}"series":[{"type":"line","data":${e(rats)},"lineStyle":{"color":"#FFD740"},"itemStyle":{"color":"#FFD740"}}]}'),
  ];
}
