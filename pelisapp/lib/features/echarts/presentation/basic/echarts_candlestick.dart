import 'package:flutter/material.dart';

import '../../../../core/models/movie.dart';
import '../../data/echarts_data_processor.dart';
import '../../helpers/echarts_options.dart';

List<Widget> buildEchartsCandlestickCharts(List<Movie> movies) {
  final categories = EchartsDataProcessor.candleCategories(movies);
  final values = EchartsDataProcessor.candleData(movies);
  final encode = EchartsDataProcessor.encode;

  return [
    echartsCard(
      'Candlestick — rating frente a popularidad TMDB',
      '{${darkBase()}${tooltip()}"xAxis":{"type":"category","data":${encode(categories)},"axisLabel":{"color":"#aaa"}},"yAxis":{"type":"value","min":0,"max":10,"axisLabel":{"color":"#aaa"},"splitLine":{"lineStyle":{"color":"#222"}}},"series":[{"type":"candlestick","data":${encode(values)}}]}',
    ),
    echartsCard(
      'Candlestick — paleta de mercado',
      '{${darkBase()}${tooltip()}"xAxis":{"type":"category","data":${encode(categories)},"axisLabel":{"color":"#aaa"}},"yAxis":{"type":"value","min":0,"max":10,"axisLabel":{"color":"#aaa"}},"series":[{"type":"candlestick","data":${encode(values)},"itemStyle":{"color":"#69F0AE","color0":"#FF5252","borderColor":"#69F0AE","borderColor0":"#FF5252"}}]}',
    ),
    echartsCard(
      'Candlestick con zoom',
      '{${darkBase()}${tooltip()}${dataZoom()}"xAxis":{"type":"category","data":${encode(categories)},"axisLabel":{"color":"#aaa"}},"yAxis":{"type":"value","min":0,"max":10,"axisLabel":{"color":"#aaa"}},"series":[{"type":"candlestick","data":${encode(values)}}]}',
    ),
  ];
}
