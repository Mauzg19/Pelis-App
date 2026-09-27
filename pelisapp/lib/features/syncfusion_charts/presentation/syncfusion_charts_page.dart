import 'package:flutter/material.dart';

import '../../../core/models/movie.dart';
import '../../home/data/tmdb_movie_repository.dart';

// ── Gráficos Básicos ───────────────────────────────────────────────
import 'basic/line_charts.dart';
import 'basic/column_charts.dart';
import 'basic/bar_charts.dart';
import 'basic/area_charts.dart';
import 'basic/spline_charts.dart';
import 'basic/step_line_charts.dart';
import 'basic/fast_line_charts.dart';
import 'basic/scatter_charts.dart';
import 'basic/bubble_charts.dart';

// ── Gráficos Avanzados ─────────────────────────────────────────────
import 'advanced/stacked_charts.dart';
import 'advanced/range_charts.dart';
import 'advanced/financial_charts.dart';
import 'advanced/circular_charts.dart';
import 'advanced/pyramid_funnel_charts.dart';
import 'advanced/waterfall_charts.dart';
import 'advanced/histogram_box_charts.dart';
import 'advanced/spark_charts.dart';

class SyncfusionChartsPage extends StatefulWidget {
  const SyncfusionChartsPage({super.key});

  @override
  State<SyncfusionChartsPage> createState() => _SyncfusionChartsPageState();
}

class _SyncfusionChartsPageState extends State<SyncfusionChartsPage>
    with SingleTickerProviderStateMixin {
  final TmdbMovieRepository _repository = TmdbMovieRepository();
  List<Movie> _movies = [];
  bool _loading = true;
  String? _error;
  late TabController _tabController;

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
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'No se pudieron cargar los datos para las gráficas';
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
        title: const Text('Syncfusion Charts'),
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
                    _buildBasicTab(),
                    _buildAdvancedTab(),
                  ],
                ),
    );
  }

  Widget _buildError() {
    return Center(
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
    );
  }

  Widget _buildBasicTab() {
    final allBasic = <Widget>[
      ...buildLineCharts(_movies),
      ...buildColumnCharts(_movies),
      ...buildBarCharts(_movies),
      ...buildAreaCharts(_movies),
      ...buildSplineCharts(_movies),
      ...buildStepLineCharts(_movies),
      ...buildFastLineCharts(_movies),
      ...buildScatterCharts(_movies),
      ...buildBubbleCharts(_movies),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: allBasic.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, index) => allBasic[index],
    );
  }

  Widget _buildAdvancedTab() {
    final allAdvanced = <Widget>[
      ...buildStackedCharts(_movies),
      ...buildRangeCharts(_movies),
      ...buildFinancialCharts(_movies),
      ...buildCircularCharts(_movies),
      ...buildPyramidFunnelCharts(_movies),
      ...buildWaterfallCharts(_movies),
      ...buildHistogramBoxCharts(_movies),
      ...buildSparkCharts(_movies),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: allAdvanced.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, index) => allAdvanced[index],
    );
  }
}
