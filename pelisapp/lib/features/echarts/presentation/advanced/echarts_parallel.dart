import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsParallelCharts(List<Movie> movies) {
  final data = EchartsDataProcessor.parallelData(movies);
  const axes = [
    '{"dim":0,"name":"Rating","min":0,"max":10}',
    '{"dim":1,"name":"Popularidad","min":0,"max":10}',
    '{"dim":2,"name":"Géneros","min":0,"max":10}',
    '{"dim":3,"name":"Sinopsis","min":0,"max":10}',
    '{"dim":4,"name":"Año","min":0,"max":16}',
  ];
  final encoded = EchartsDataProcessor.encode(data);
  final encodeLabels = EchartsDataProcessor.encode(EchartsDataProcessor.movieLabels(movies));
  final comparisonData = EchartsDataProcessor.encode(
    data.map((row) => row.take(3).toList()).toList(),
  );

  return [
    echartsCard('Parallel — perfil de películas', '{${darkBase()}${tooltip('item')}"parallelAxis":[${axes.join(',')}],"parallel":{"left":"8%","right":"8%","bottom":"12%","top":"10%","parallelAxisDefault":{"type":"value","nameTextStyle":{"color":"#ddd"},"axisLine":{"lineStyle":{"color":"#555"}},"axisLabel":{"color":"#aaa"},"splitLine":{"show":false}}},"series":[{"type":"parallel","lineStyle":{"width":2,"opacity":0.45},"data":$encoded}]}'),
    echartsCard('Parallel — rating, popularidad y géneros', '{${darkBase()}${tooltip('item')}"parallelAxis":[{"dim":0,"name":"Rating","min":0,"max":10},{"dim":1,"name":"Popularidad","min":0,"max":10},{"dim":2,"name":"Géneros","min":0,"max":10}],"parallel":{"left":"10%","right":"10%","parallelAxisDefault":{"nameTextStyle":{"color":"#ddd"},"axisLine":{"lineStyle":{"color":"#555"}},"axisLabel":{"color":"#aaa"}}},"series":[{"type":"parallel","lineStyle":{"width":3,"opacity":0.55},"data":$comparisonData}]}'),
    echartsCard('Parallel — líneas resaltables', '{${darkBase()}${tooltip('item')}"parallelAxis":[${axes.join(',')}],"parallel":{"left":"8%","right":"8%","bottom":"12%","top":"10%","axisExpandable":true,"axisExpandCount":2,"axisExpandWidth":40,"parallelAxisDefault":{"nameTextStyle":{"color":"#ddd"},"axisLine":{"lineStyle":{"color":"#555"}},"axisLabel":{"color":"#aaa"}}},"series":[{"type":"parallel","smooth":true,"lineStyle":{"width":1.5,"opacity":0.5},"data":$encoded,"encode":{"tooltip":[0,1,2,3,4]}}],"tooltip":{"trigger":"item","formatter":function(p){return $encodeLabels[p.dataIndex]}}}'),
  ];
}
