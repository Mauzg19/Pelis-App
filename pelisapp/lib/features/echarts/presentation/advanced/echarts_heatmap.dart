import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsHeatmapCharts(List<Movie> movies) {
  final data = EchartsDataProcessor.heatmapData(movies);
  final labels = EchartsDataProcessor.movieLabels(movies, 10);
  final metrics = ['Rating', 'Popularidad', 'Géneros', 'Sinopsis', 'Rating x0.8'];
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard('Heatmap — métricas por película', '{${darkBase()}${tooltip('item')}"grid":{"left":90,"right":20,"top":20,"bottom":50},"xAxis":{"type":"category","data":${encode(labels)},"splitArea":{"show":true},"axisLabel":{"color":"#aaa","fontSize":8,"rotate":35}},"yAxis":{"type":"category","data":${encode(metrics)},"splitArea":{"show":true},"axisLabel":{"color":"#aaa"}},"visualMap":{"min":0,"max":10,"calculable":true,"orient":"horizontal","left":"center","bottom":0,"textStyle":{"color":"#ccc"}},"series":[{"type":"heatmap","data":${encode(data)},"label":{"show":true,"color":"#fff","fontSize":8},"emphasis":{"itemStyle":{"shadowBlur":8,"shadowColor":"rgba(0,0,0,0.5)"}}}]}'),
    echartsCard('Heatmap — ratings y popularidad', '{${darkBase()}${tooltip('item')}"xAxis":{"type":"category","data":${encode(labels)},"axisLabel":{"color":"#aaa","rotate":30,"fontSize":8}},"yAxis":{"type":"category","data":["Rating","Popularidad"],"axisLabel":{"color":"#aaa"}},"visualMap":{"min":0,"max":10,"inRange":{"color":["#24283b","#448AFF","#69F0AE"]},"textStyle":{"color":"#ccc"}},"series":[{"type":"heatmap","data":${encode(data.where((cell) => cell[1] < 2).toList())},"label":{"show":true,"color":"#fff"}}]}'),
    echartsCard('Heatmap — escala de rating', '{${darkBase()}${tooltip('item')}"xAxis":{"type":"category","data":${encode(labels)},"axisLabel":{"color":"#aaa","rotate":30,"fontSize":8}},"yAxis":{"type":"category","data":${encode(metrics)},"axisLabel":{"color":"#aaa"}},"visualMap":{"min":0,"max":10,"calculable":true,"inRange":{"color":["#313695","#74add1","#ffffbf","#f46d43","#a50026"]},"textStyle":{"color":"#ccc"}},"series":[{"type":"heatmap","data":${encode(data)},"label":{"show":false}}]}'),
  ];
}
