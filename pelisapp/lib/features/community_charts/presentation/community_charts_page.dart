import 'package:flutter/material.dart';

import '../../../core/models/movie.dart';
import '../../home/data/tmdb_movie_repository.dart';
import '../data/community_chart_data_processor.dart';
import 'community_chart_card.dart';
import 'community_chart_catalog.dart';

class CommunityChartsPage extends StatefulWidget {
  const CommunityChartsPage({super.key});

  @override
  State<CommunityChartsPage> createState() => _CommunityChartsPageState();
}

class _CommunityChartsPageState extends State<CommunityChartsPage>
    with SingleTickerProviderStateMixin {
  final TmdbMovieRepository _repository = TmdbMovieRepository();
  late final TabController _tabController;
  List<Movie> _movies = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadMovies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadMovies() async {
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
        _error =
            'No se pudieron cargar los datos de TMDB para Community Charts';
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
        title: const Text('Community Charts Flutter'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 21,
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
                _buildChartList(CommunityChartCatalog.basic),
                _buildChartList(CommunityChartCatalog.advanced),
              ],
            ),
    );
  }

  Widget _buildError() => Center(
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
              _loadMovies();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    ),
  );

  Widget _buildChartList(List<CommunityChartDefinition> definitions) {
    final data = CommunityChartDataProcessor.movies(_movies);
    if (data.isEmpty) {
      return const Center(
        child: Text(
          'TMDB no devolvió películas para mostrar en las gráficas.',
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: definitions.length + 1,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (_, index) => index == 0
          ? const Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(
                'Fuente de datos: películas populares de TMDB API',
                style: TextStyle(color: Color(0xFFB8B8C8), fontSize: 14),
              ),
            )
          : CommunityChartCard(
              key: ValueKey(definitions[index - 1].title),
              definition: definitions[index - 1],
              data: data,
            ),
    );
  }
}
