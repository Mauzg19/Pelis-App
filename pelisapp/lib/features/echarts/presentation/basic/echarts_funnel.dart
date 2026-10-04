import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsFunnelCharts(List<Movie> movies) {
  final values = EchartsDataProcessor.ratings(movies, 7);
  final labels = EchartsDataProcessor.movieLabels(movies, 7);
  final funnelData = List.generate(
    values.length,
    (index) => {'name': labels[index], 'value': values[index]},
  );
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard('Funnel — ratings de películas', '{${darkBase()}${tooltip('item')}"series":[{"type":"funnel","left":"10%","top":10,"bottom":10,"width":"80%","sort":"descending","data":${encode(funnelData)},"label":{"color":"#fff","position":"inside"}}]}'),
    echartsCard('Funnel — comparación por ranking', '{${darkBase()}${tooltip('item')}"series":[{"type":"funnel","left":"15%","top":15,"bottom":15,"width":"70%","min":0,"max":10,"minSize":"0%","maxSize":"100%","sort":"ascending","gap":4,"data":${encode(funnelData)},"label":{"color":"#fff","position":"right"},"labelLine":{"length":12,"lineStyle":{"color":"#888"}}}]}'),
  ];
}
