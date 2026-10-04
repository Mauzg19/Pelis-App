import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsThemeRiverCharts(List<Movie> movies) {
  final data = EchartsDataProcessor.themeRiverData(movies);
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard('ThemeRiver — géneros por año', '{${darkBase()}${tooltip()}"singleAxis":{"type":"time","boundaryGap":["10%","10%"],"axisLabel":{"color":"#aaa"},"axisLine":{"lineStyle":{"color":"#555"}},"splitLine":{"show":true,"lineStyle":{"color":"#333"}}},"legend":{"data":["Acción","Drama","Comedia","Terror","Ciencia F."],"textStyle":{"color":"#ccc"},"bottom":0},"series":[{"type":"themeRiver","data":${encode(data)},"label":{"show":false},"emphasis":{"itemStyle":{"shadowBlur":15,"shadowColor":"rgba(0,0,0,0.7)"}}}]}'),
    echartsCard('ThemeRiver — tendencias destacadas', '{${darkBase()}${tooltip('axis')}"singleAxis":{"type":"time","top":30,"bottom":35,"axisLabel":{"color":"#aaa"},"axisLine":{"lineStyle":{"color":"#555"}}},"series":[{"type":"themeRiver","data":${encode(data)},"label":{"show":true,"color":"#fff","fontSize":9},"labelLayout":{"hideOverlap":true},"itemStyle":{"opacity":0.85}}]}'),
    echartsCard('ThemeRiver — flujo por género', '{${darkBase()}${tooltip('axis')}"singleAxis":{"type":"time","axisLabel":{"color":"#aaa"},"splitLine":{"show":true,"lineStyle":{"color":"#333"}}},"series":[{"type":"themeRiver","data":${encode(data)},"boundaryGap":["15%","15%"],"color":["#7C4DFF","#448AFF","#69F0AE","#FF5252","#FFAB40"],"label":{"show":false},"emphasis":{"focus":"self"}}]}'),
  ];
}
