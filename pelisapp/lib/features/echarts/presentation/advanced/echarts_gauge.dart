import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsGaugeCharts(List<Movie> movies) {
  final rating = EchartsDataProcessor.avgRating(movies);
  final normalizedPopularity = EchartsDataProcessor.popularityNorm(
    movies,
    movies.length,
  );
  final popularity = normalizedPopularity.isEmpty
      ? 0.0
      : normalizedPopularity.reduce((a, b) => a + b) / normalizedPopularity.length;

  return [
    echartsCard('Gauge — rating promedio', '{${darkBase()}${tooltip('item')}"series":[{"type":"gauge","min":0,"max":10,"progress":{"show":true,"width":14},"axisLine":{"lineStyle":{"width":14,"color":[[0.4,"#FF5252"],[0.7,"#FFAB40"],[1,"#69F0AE"]]}},"pointer":{"itemStyle":{"color":"auto"}},"axisTick":{"distance":-18,"length":5,"lineStyle":{"color":"#fff"}},"splitLine":{"distance":-20,"length":10,"lineStyle":{"color":"#fff"}},"axisLabel":{"color":"#aaa","distance":24},"detail":{"valueAnimation":true,"formatter":"{value} / 10","color":"#fff","fontSize":18},"data":[{"value":$rating,"name":"Rating"}]}]}'),
    echartsCard('Gauge — popularidad normalizada', '{${darkBase()}${tooltip('item')}"series":[{"type":"gauge","min":0,"max":10,"startAngle":210,"endAngle":-30,"progress":{"show":true,"width":10,"itemStyle":{"color":"#18FFFF"}},"axisLine":{"lineStyle":{"width":10,"color":[[1,"#292e43"]]}},"axisLabel":{"color":"#aaa"},"detail":{"formatter":"{value} / 10","color":"#fff"},"data":[{"value":${popularity.toStringAsFixed(1)},"name":"Popularidad"}]}]}'),
    echartsCard('Gauge semicircular', '{${darkBase()}${tooltip('item')}"series":[{"type":"gauge","min":0,"max":10,"startAngle":180,"endAngle":0,"center":["50%","70%"],"radius":"90%","progress":{"show":true,"width":16,"roundCap":true},"axisLine":{"lineStyle":{"width":16,"color":[[0.5,"#448AFF"],[1,"#7C4DFF"]]}},"pointer":{"show":false},"axisTick":{"show":false},"splitLine":{"length":12,"distance":-22},"axisLabel":{"distance":-30,"color":"#aaa"},"detail":{"formatter":"{value}","color":"#fff","fontSize":24},"data":[{"value":$rating,"name":"Rating promedio"}]}]}'),
    echartsCard('Gauge con umbrales de valoración', '{${darkBase()}${tooltip('item')}"series":[{"type":"gauge","min":0,"max":10,"detail":{"formatter":"{value}","color":"#fff"},"axisLine":{"lineStyle":{"width":18,"color":[[0.4,"#FF5252"],[0.7,"#FFD740"],[1,"#69F0AE"]]}},"data":[{"value":$rating}]}]}'),
    echartsCard('Gauge doble — rating y popularidad', '{${darkBase()}${tooltip('item')}"series":[{"type":"gauge","min":0,"max":10,"center":["25%","55%"],"radius":"62%","detail":{"formatter":"{value}","color":"#fff","fontSize":14},"axisLine":{"lineStyle":{"width":10,"color":[[1,"#7C4DFF"]]}},"data":[{"value":$rating,"name":"Rating"}]},{"type":"gauge","min":0,"max":10,"center":["75%","55%"],"radius":"62%","detail":{"formatter":"{value}","color":"#fff","fontSize":14},"axisLine":{"lineStyle":{"width":10,"color":[[1,"#18FFFF"]]}},"data":[{"value":${popularity.toStringAsFixed(1)},"name":"Popularidad"}]}]}'),
  ];
}
