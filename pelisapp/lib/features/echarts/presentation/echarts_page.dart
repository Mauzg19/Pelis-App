import 'package:flutter/material.dart';

import '../../../core/models/movie.dart';
import '../../home/data/tmdb_movie_repository.dart';
import 'advanced/echarts_gauge.dart';
import 'advanced/echarts_graph.dart';
import 'advanced/echarts_heatmap.dart';
import 'advanced/echarts_mixed.dart';
import 'advanced/echarts_parallel.dart';
import 'advanced/echarts_sankey.dart';
import 'advanced/echarts_sunburst.dart';
import 'advanced/echarts_theme_river.dart';
import 'advanced/echarts_treemap.dart';
import 'basic/echarts_area.dart';
import 'basic/echarts_bar.dart';
import 'basic/echarts_boxplot.dart';
import 'basic/echarts_candlestick.dart';
import 'basic/echarts_funnel.dart';
import 'basic/echarts_line.dart';
import 'basic/echarts_pie.dart';
import 'basic/echarts_radar.dart';
import 'basic/echarts_scatter.dart';

class EchartsPage extends StatefulWidget {
  const EchartsPage({super.key});

  @override
  State<EchartsPage> createState() => _EchartsPageState();
}

class _EchartsPageState extends State<EchartsPage>
    with SingleTickerProviderStateMixin {
  final TmdbMovieRepository _repository = TmdbMovieRepository();
  List<Movie> _movies = [];
  bool _loading = true;
  String? _error;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final movies = await _repository.getPopularMovies();
      if (!mounted) return;
      setState(() {
        _movies = movies;
        _loading = false;
        _error = null;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'No se pudieron cargar los datos para ECharts';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111526),
        title: const Text('Flutter ECharts'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF7C4DFF),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: 'Básicos (43)'),
            Tab(text: 'Avanzados (36)'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildError()
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildChartList(_basicCharts()),
                    _buildChartList(_advancedCharts()),
                  ],
                ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 12),
            Text(
              _error!,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _loading = true;
                  _error = null;
                });
                _loadData();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartList(List<Widget> charts) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: charts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, index) => charts[index],
    );
  }

  List<Widget> _basicCharts() => [
        ...buildEchartsLineCharts(_movies),
        ...buildEchartsBarCharts(_movies),
        ...buildEchartsAreaCharts(_movies),
        ...buildEchartsScatterCharts(_movies),
        ...buildEchartsPieCharts(_movies),
        ...buildEchartsRadarCharts(_movies),
        ...buildEchartsCandlestickCharts(_movies),
        ...buildEchartsBoxplotCharts(_movies),
        ...buildEchartsFunnelCharts(_movies),
      ];

  List<Widget> _advancedCharts() => [
        ...buildEchartsHeatmapCharts(_movies),
        ...buildEchartsTreemapCharts(_movies),
        ...buildEchartsSunburstCharts(_movies),
        ...buildEchartsGaugeCharts(_movies),
        ...buildEchartsSankeyCharts(_movies),
        ...buildEchartsGraphCharts(_movies),
        ...buildEchartsParallelCharts(_movies),
        ...buildEchartsThemeRiverCharts(_movies),
        ...buildEchartsMixedCharts(_movies),
      ];
}
