import 'dart:convert';

import 'package:flutter/material.dart';

import 'echarts_renderer_stub.dart'
    if (dart.library.js_interop) 'echarts_renderer_web.dart';

const kCardBg = Color(0xFF1D2235);

const kColors = [
  '#7C4DFF', '#448AFF', '#69F0AE', '#FFAB40', '#FF5252',
  '#18FFFF', '#FF4081', '#64FFDA', '#FFD740', '#536DFE',
];

String kColorsJson = '["${kColors.join('","')}"]';

/// Wraps an ECharts option string inside a styled card.
Widget echartsCard(String title, String option, {double height = 260}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kCardBg,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: height,
          child: EchartsRenderer(option: option),
        ),
      ],
    ),
  );
}

String darkBase() => '"backgroundColor":"#111526","textStyle":{"color":"#fff"},"color":$kColorsJson,';
String tooltip([String trigger = 'axis']) => '"tooltip":{"trigger":"$trigger","backgroundColor":"#1D2235","borderColor":"#444","textStyle":{"color":"#fff"}},';
String legend(List<String> n) => '"legend":{"data":${jsonEncode(n)},"textStyle":{"color":"#ccc"},"bottom":"0"},';
String catX(List<String> l) => '"xAxis":{"type":"category","data":${jsonEncode(l)},"axisLabel":{"color":"#aaa","fontSize":9,"rotate":30},"axisLine":{"lineStyle":{"color":"#333"}}},';
String numY({double? max, String? name}) => '"yAxis":{"type":"value"${max != null ? ',"max":$max' : ''}${name != null ? ',"name":"$name"' : ''},"axisLabel":{"color":"#aaa","fontSize":9},"splitLine":{"lineStyle":{"color":"#222"}},"axisLine":{"lineStyle":{"color":"#333"}}},';
String dataZoom() => '"dataZoom":[{"type":"inside"},{"type":"slider","height":15,"bottom":5}],';
