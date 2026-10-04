import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsSunburstCharts(List<Movie> movies) {
  final data = EchartsDataProcessor.sunburstData(movies);
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard('Sunburst — idiomas y películas', '{${darkBase()}${tooltip('item')}"series":[{"type":"sunburst","data":${encode(data)},"radius":[0,"88%"],"label":{"rotate":"radial","color":"#fff","fontSize":9},"itemStyle":{"borderColor":"#111526","borderWidth":2},"emphasis":{"focus":"ancestor"}}]}'),
    echartsCard('Sunburst — jerarquía interactiva', '{${darkBase()}${tooltip('item')}"series":[{"type":"sunburst","data":${encode(data)},"radius":["12%","86%"],"sort":null,"highlightPolicy":"ancestor","nodeClick":"rootToNode","levels":[{},{"r0":"12%","r":"42%","itemStyle":{"borderWidth":2},"label":{"rotate":"tangential","color":"#fff"}},{"r0":"42%","r":"86%","label":{"align":"right","color":"#fff","fontSize":9}}]}]}'),
    echartsCard('Sunburst — ratings destacados', '{${darkBase()}${tooltip('item')}"series":[{"type":"sunburst","data":${encode(data)},"radius":["18%","88%"],"minAngle":4,"label":{"show":true,"rotate":"radial","color":"#fff","fontSize":8},"itemStyle":{"borderColor":"#111526","borderWidth":2},"emphasis":{"itemStyle":{"shadowBlur":12,"shadowColor":"rgba(0,0,0,0.6)"}}}]}'),
  ];
}
