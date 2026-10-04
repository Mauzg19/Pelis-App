import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsGraphCharts(List<Movie> movies) {
  final data = EchartsDataProcessor.graphData(movies);
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard('Graph — relaciones por géneros compartidos', '{${darkBase()}${tooltip('item')}"legend":[{"data":${encode((data['categories'] as List<Map<String, dynamic>>).map((c) => c['name']).toList())},"textStyle":{"color":"#ccc"}}],"series":[{"type":"graph","layout":"force","data":${encode(data['nodes'])},"links":${encode(data['links'])},"categories":${encode(data['categories'])},"roam":true,"draggable":true,"label":{"show":true,"position":"right","color":"#fff","fontSize":8},"force":{"repulsion":120,"edgeLength":[35,100]},"lineStyle":{"color":"source","curveness":0.15,"opacity":0.5},"emphasis":{"focus":"adjacency"}}]}'),
    echartsCard('Graph circular — conexiones entre películas', '{${darkBase()}${tooltip('item')}"series":[{"type":"graph","layout":"circular","data":${encode(data['nodes'])},"links":${encode(data['links'])},"categories":${encode(data['categories'])},"roam":true,"label":{"show":true,"position":"right","color":"#fff","fontSize":8},"edgeSymbol":["none","arrow"],"lineStyle":{"color":"source","curveness":0.25,"opacity":0.45}}]}'),
    echartsCard('Graph con símbolos por rating', '{${darkBase()}${tooltip('item')}"series":[{"type":"graph","layout":"force","data":${encode(data['nodes'])},"links":${encode(data['links'])},"categories":${encode(data['categories'])},"roam":true,"label":{"show":true,"color":"#fff","fontSize":8},"force":{"repulsion":180,"edgeLength":70},"lineStyle":{"color":"#7C4DFF","width":1.5,"opacity":0.5},"emphasis":{"focus":"adjacency","lineStyle":{"width":3}}}]}'),
    echartsCard('Graph de relaciones — visión general', '{${darkBase()}${tooltip('item')}"series":[{"type":"graph","layout":"none","data":${encode(data['nodes'])},"links":${encode(data['links'])},"categories":${encode(data['categories'])},"roam":true,"symbolSize":function(value){return Math.max(10,value*5)},"label":{"show":true,"position":"bottom","color":"#fff","fontSize":8},"lineStyle":{"color":"source","curveness":0.2,"opacity":0.4}}]}'),
  ];
}
