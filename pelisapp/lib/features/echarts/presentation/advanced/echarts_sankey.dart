import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsSankeyCharts(List<Movie> movies) {
  final data = EchartsDataProcessor.sankeyData(movies);
  final nodes = data['nodes'] as List<Map<String, dynamic>>;
  final links = data['links'] as List<Map<String, dynamic>>;
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard('Sankey — idioma a género', '{${darkBase()}${tooltip('item')}"series":[{"type":"sankey","data":${encode(nodes)},"links":${encode(links)},"left":"5%","right":"15%","top":"5%","bottom":"5%","nodeWidth":16,"nodeGap":10,"layoutIterations":32,"label":{"color":"#fff","fontSize":9},"lineStyle":{"color":"source","curveness":0.5,"opacity":0.35},"emphasis":{"focus":"adjacency"}}]}'),
    echartsCard('Sankey — flujo de películas', '{${darkBase()}${tooltip('item')}"series":[{"type":"sankey","data":${encode(nodes)},"links":${encode(links)},"orient":"vertical","nodeAlign":"justify","nodeWidth":14,"nodeGap":8,"label":{"color":"#fff","fontSize":8},"lineStyle":{"color":"gradient","curveness":0.45,"opacity":0.4}}]}'),
    echartsCard('Sankey con etiquetas detalladas', '{${darkBase()}${tooltip('item')}"series":[{"type":"sankey","data":${encode(nodes)},"links":${encode(links)},"nodeWidth":20,"nodeGap":12,"draggable":true,"label":{"color":"#fff","fontSize":10,"position":"right"},"lineStyle":{"color":"source","curveness":0.5,"opacity":0.3},"emphasis":{"focus":"trajectory"}}]}'),
  ];
}
