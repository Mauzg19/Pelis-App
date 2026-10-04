import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsScatterCharts(List<Movie> movies) {
  final labels = EchartsDataProcessor.movieLabels(movies);
  final ratings = EchartsDataProcessor.ratings(movies);
  final popularity = EchartsDataProcessor.popularityNorm(movies);
  final genreCounts = movies.take(10).map((movie) => movie.genreIds.length).toList();
  final points = List.generate(
    ratings.length,
    (i) => [ratings[i], popularity[i]],
  );
  final bubblePoints = List.generate(
    ratings.length,
    (i) => [ratings[i], popularity[i], (genreCounts[i] * 4 + 8)],
  );
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard('Dispersión — Rating y popularidad', '{${darkBase()}${tooltip('item')}"xAxis":{"type":"value","name":"Rating","min":0,"max":10,"axisLabel":{"color":"#aaa"},"splitLine":{"lineStyle":{"color":"#222"}}},"yAxis":{"type":"value","name":"Popularidad","min":0,"max":10,"axisLabel":{"color":"#aaa"},"splitLine":{"lineStyle":{"color":"#222"}}},"series":[{"type":"scatter","data":${encode(points)}}]}'),
    echartsCard('Dispersión con etiquetas', '{${darkBase()}${tooltip('item')}"xAxis":{"type":"value","min":0,"max":10},"yAxis":{"type":"value","min":0,"max":10},"series":[{"type":"scatter","data":${encode(points)},"label":{"show":true,"formatter":function(p){return ${encode(labels)}[p.dataIndex]},"position":"top","color":"#ddd","fontSize":8}}]}'),
    echartsCard('Burbujas — tamaño por géneros', '{${darkBase()}${tooltip('item')}"xAxis":{"type":"value","name":"Rating","min":0,"max":10},"yAxis":{"type":"value","name":"Popularidad","min":0,"max":10},"series":[{"type":"scatter","symbolSize":function(v){return v[2]},"data":${encode(bubblePoints)}}]}'),
    echartsCard('Dispersión — Rating por película', '{${darkBase()}${tooltip('item')}"xAxis":{"type":"category","data":${encode(labels)},"axisLabel":{"color":"#aaa","fontSize":9,"rotate":30}},"yAxis":{"type":"value","max":10},"series":[{"type":"scatter","data":${encode(ratings)},"symbolSize":12}]}'),
    echartsCard('Dispersión con línea de tendencia', '{${darkBase()}${tooltip('item')}"xAxis":{"type":"value","min":0,"max":10},"yAxis":{"type":"value","min":0,"max":10},"series":[{"type":"scatter","data":${encode(points)}},{"type":"line","data":[[0,0],[10,10]],"symbol":"none","lineStyle":{"type":"dashed","color":"#FFAB40"}}]}'),
    echartsCard('Dispersión coloreada por rating', '{${darkBase()}${tooltip('item')}"visualMap":{"min":0,"max":10,"dimension":0,"inRange":{"color":["#448AFF","#FF4081","#FFD740"]},"textStyle":{"color":"#ccc"}},"xAxis":{"type":"value","min":0,"max":10},"yAxis":{"type":"value","min":0,"max":10},"series":[{"type":"scatter","data":${encode(points)}}]}'),
  ];
}
