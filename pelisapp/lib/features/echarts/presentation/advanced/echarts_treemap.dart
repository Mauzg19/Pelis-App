import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsTreemapCharts(List<Movie> movies) {
  final data = EchartsDataProcessor.treemapData(movies);
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard('Treemap — películas por género', '{${darkBase()}${tooltip('item')}"series":[{"type":"treemap","data":${encode(data)},"visibleMin":5,"leafDepth":1,"label":{"show":true,"color":"#fff","fontSize":10},"upperLabel":{"show":true,"height":24,"color":"#fff"},"levels":[{"itemStyle":{"borderColor":"#111526","borderWidth":3,"gapWidth":3}},{"colorSaturation":[0.3,0.6],"itemStyle":{"borderColorSaturation":0.7,"gapWidth":2}}]}]}'),
    echartsCard('Treemap — rating de películas', '{${darkBase()}${tooltip('item')}"series":[{"type":"treemap","data":${encode(data)},"roam":false,"breadcrumb":{"show":true,"itemStyle":{"color":"#24283b","textStyle":{"color":"#fff"}}},"label":{"show":true,"color":"#fff","formatter":"{b}"},"visualDimension":1,"visualMin":0,"visualMax":100,"color":["#448AFF","#7C4DFF","#FF4081"]}]}'),
    echartsCard('Treemap con drill-down', '{${darkBase()}${tooltip('item')}"series":[{"type":"treemap","data":${encode(data)},"leafDepth":2,"drillDownIcon":"▶","nodeClick":"zoomToNode","breadcrumb":{"show":true,"left":"center","itemStyle":{"color":"#24283b","textStyle":{"color":"#fff"}}},"label":{"show":true,"color":"#fff","fontSize":9}}]}'),
  ];
}
