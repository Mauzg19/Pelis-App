import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class EchartsRenderer extends StatelessWidget {
  const EchartsRenderer({required this.option, super.key});

  final String option;

  @override
  Widget build(BuildContext context) => Echarts(option: option);
}
