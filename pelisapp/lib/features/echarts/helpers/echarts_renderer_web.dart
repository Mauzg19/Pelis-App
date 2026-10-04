import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/echarts_script.dart' show echartsScript;
import 'package:web/web.dart' as web;

class EchartsRenderer extends StatefulWidget {
  const EchartsRenderer({required this.option, super.key});

  final String option;

  @override
  State<EchartsRenderer> createState() => _EchartsRendererState();
}

class _EchartsRendererState extends State<EchartsRenderer> {
  static int _nextViewId = 0;

  late final String _viewType;
  late final web.HTMLIFrameElement _iframe;

  @override
  void initState() {
    super.initState();
    _viewType = 'echarts-view-${_nextViewId++}';
    _iframe = web.HTMLIFrameElement()
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.border = '0'
      ..srcdoc = _documentFor(widget.option).toJS;
    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) => _iframe,
    );
  }

  @override
  void didUpdateWidget(EchartsRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.option != widget.option) {
      _iframe.srcdoc = _documentFor(widget.option).toJS;
    }
  }

  @override
  Widget build(BuildContext context) => HtmlElementView(viewType: _viewType);

  String _documentFor(String option) {
    final safeOption = option.replaceAll(
      RegExp(r'</script', caseSensitive: false),
      r'<\/script',
    );
    return '''
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    html, body, #chart { width: 100%; height: 100%; margin: 0; }
  </style>
</head>
<body>
  <div id="chart"></div>
  <script>
    $echartsScript
    const chart = echarts.init(document.getElementById('chart'));
    chart.setOption($safeOption, true);
    window.addEventListener('resize', () => chart.resize());
  </script>
</body>
</html>
''';
  }
}
