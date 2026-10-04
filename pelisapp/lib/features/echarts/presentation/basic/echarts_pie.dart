import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsPieCharts(List<Movie> movies) {
  final genres = EchartsDataProcessor.genrePieData(movies);
  final languages = EchartsDataProcessor.languagePieData(movies);
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard('Pastel — distribución por género', '{${darkBase()}${tooltip('item')}"series":[{"type":"pie","radius":"65%","data":${encode(genres)},"label":{"color":"#fff"}}]}'),
    echartsCard('Dona — distribución por idioma', '{${darkBase()}${tooltip('item')}"series":[{"type":"pie","radius":["42%","70%"],"data":${encode(languages)},"label":{"color":"#fff"}}]}'),
    echartsCard('Pastel con etiquetas externas', '{${darkBase()}${tooltip('item')}"series":[{"type":"pie","radius":"58%","data":${encode(genres)},"label":{"color":"#fff","formatter":"{b}: {d}%"},"labelLine":{"lineStyle":{"color":"#888"}}}]}'),
    echartsCard('Dona con total en el centro', '{${darkBase()}${tooltip('item')}"title":{"text":"${movies.length}","subtext":"películas","left":"center","top":"42%","textStyle":{"color":"#fff","fontSize":22},"subtextStyle":{"color":"#aaa"}},"series":[{"type":"pie","radius":["52%","72%"],"data":${encode(genres)},"label":{"show":false}}]}'),
    echartsCard('Pastel destacado por género', '{${darkBase()}${tooltip('item')}"series":[{"type":"pie","radius":"62%","data":${encode(genres)},"selectedMode":"single","selectedOffset":12,"label":{"color":"#fff"}}]}'),
    echartsCard('Dona — películas por idioma', '{${darkBase()}${tooltip('item')}"legend":{"orient":"vertical","left":"left","textStyle":{"color":"#ccc"}},"series":[{"type":"pie","radius":["40%","68%"],"center":["62%","55%"],"data":${encode(languages)},"label":{"color":"#fff","formatter":"{b}\\n{c}"}}]}'),
  ];
}
