import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/models/movie.dart';
import '../../home/data/tmdb_movie_repository.dart';

class FlChartDemoPage extends StatefulWidget {
  const FlChartDemoPage({super.key});

  @override
  State<FlChartDemoPage> createState() => _FlChartDemoPageState();
}

class _FlChartDemoPageState extends State<FlChartDemoPage> {
  final TmdbMovieRepository _repository = TmdbMovieRepository();
  List<Movie> _movies = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadChartData();
  }

  Future<void> _loadChartData() async {
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
    final basicVariants = [
      _ChartVariant('Línea', 'curva'),
      _ChartVariant('Línea', 'con puntos'),
      _ChartVariant('Línea', 'escalonada'),
      _ChartVariant('Línea', 'multiserie'),
      _ChartVariant('Línea', 'con relleno'),
      _ChartVariant('Línea', 'con gradiente'),
      _ChartVariant('Barras', 'verticales'),
      _ChartVariant('Barras', 'horizontales'),
      _ChartVariant('Barras', 'agrupadas'),
      _ChartVariant('Barras', 'apiladas'),
      _ChartVariant('Barras', 'con gradiente'),
      _ChartVariant('Barras', 'con etiquetas'),
      _ChartVariant('Área', 'básica'),
      _ChartVariant('Área', 'con relleno'),
      _ChartVariant('Área', 'gradiente'),
      _ChartVariant('Área', 'apilada'),
      _ChartVariant('Área', 'multiserie'),
      _ChartVariant('Línea', 'lineal'),
      _ChartVariant('Línea', 'dinámica'),
      _ChartVariant('Barras', 'doble eje'),
      _ChartVariant('Barras', 'redondeadas'),
      _ChartVariant('Área', 'con puntos'),
      _ChartVariant('Línea', 'interpolada'),
      _ChartVariant('Barras', 'con valor'),
      _ChartVariant('Área', 'semitransparente'),
      _ChartVariant('Línea', 'con sombras'),
      _ChartVariant('Barras', 'segmentadas'),
      _ChartVariant('Área', 'alterna'),
      _ChartVariant('Línea', 'cíclica'),
      _ChartVariant('Barras', 'sombreada'),
      _ChartVariant('Área', 'realista'),
      _ChartVariant('Línea', 'compacta'),
      _ChartVariant('Barras', 'mini'),
      _ChartVariant('Área', 'estrecha'),
      _ChartVariant('Línea', 'ancho variable'),
      _ChartVariant('Barras', 'con borde'),
      _ChartVariant('Área', 'degradada'),
      _ChartVariant('Línea', 'de comparación'),
      _ChartVariant('Barras', 'sintética'),
      _ChartVariant('Área', 'sobrepuesta'),
      _ChartVariant('Línea', 'densidad'),
      _ChartVariant('Barras', 'porcentaje'),
      _ChartVariant('Área', 'múltiple'),
      _ChartVariant('Línea', 'analítica'),
      _ChartVariant('Barras', 'combinada'),
      _ChartVariant('Área', 'cronológica'),
    ];

    final advancedVariants = [
      _ChartVariant('Dona', 'básica'),
      _ChartVariant('Dona', 'con centro hueco'),
      _ChartVariant('Dona', 'etiquetada'),
      _ChartVariant('Dona', 'con gradiente'),
      _ChartVariant('Dona', 'semicírculo'),
      _ChartVariant('Dona', 'personalizada'),
      _ChartVariant('Radar', 'básica'),
      _ChartVariant('Radar', 'con relleno'),
      _ChartVariant('Radar', 'multiserie'),
      _ChartVariant('Radar', 'con etiquetas'),
      _ChartVariant('Radar', 'circular'),
      _ChartVariant('Radar', 'angular'),
      _ChartVariant('Dispersión', 'básica'),
      _ChartVariant('Dispersión', 'burbuja'),
      _ChartVariant('Dispersión', 'multicolor'),
      _ChartVariant('Dispersión', 'con rango'),
      _ChartVariant('Dispersión', 'por tendencia'),
      _ChartVariant('Dispersión', 'por grupos'),
      _ChartVariant('Dona', 'ancha'),
      _ChartVariant('Dona', 'compacta'),
      _ChartVariant('Radar', 'de comparación'),
      _ChartVariant('Radar', 'simétrica'),
      _ChartVariant('Dispersión', 'sobrepuesta'),
      _ChartVariant('Dispersión', 'correlación'),
      _ChartVariant('Dona', 'animada'),
      _ChartVariant('Dona', 'con leyenda'),
      _ChartVariant('Radar', 'tipo mapa'),
      _ChartVariant('Radar', 'con índices'),
      _ChartVariant('Dispersión', 'por clusters'),
      _ChartVariant('Dispersión', 'de densidad'),
      _ChartVariant('Dona', 'sectorial'),
      _ChartVariant('Radar', 'de métricas'),
      _ChartVariant('Dispersión', 'combinada'),
      _ChartVariant('Dona', 'circular'),
      _ChartVariant('Radar', 'con ejes'),
      _ChartVariant('Dispersión', 'alfa'),
      _ChartVariant('Dona', 'proporcional'),
      _ChartVariant('Radar', 'multinivel'),
      _ChartVariant('Dispersión', 'analítica'),
    ];

    final basicCharts = List.generate(43, (index) {
      final variant = basicVariants[index % basicVariants.length];
      return _ChartTile(
        title: 'Básico ${index + 1}',
        subtitle: '${variant.family} • ${variant.variant}',
        preview: switch (variant.family) {
          'Línea' => _lineChart(index),
          'Barras' => _barChart(index),
          'Área' => _areaChart(index),
          _ => _lineChart(index),
        },
      );
    });

    final advancedCharts = List.generate(36, (index) {
      final variant = advancedVariants[index % advancedVariants.length];
      return _ChartTile(
        title: 'Avanzado ${index + 1}',
        subtitle: '${variant.family} • ${variant.variant}',
        preview: switch (variant.family) {
          'Dona' => _pieChart(index),
          'Radar' => _radarChart(index),
          'Dispersión' => _scatterChart(index),
          _ => _pieChart(index),
        },
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFF111526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111526),
        title: const Text('FL Chart'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Gráficos básicos (43)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Datos: películas populares obtenidas desde TMDB API',
                style: TextStyle(color: Color(0xFFB8B8C8), fontSize: 14),
              ),
              const SizedBox(height: 12),
              if (_loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_error != null)
                _ErrorPanel(message: _error!, onRetry: _loadChartData)
              else ...[
                Wrap(spacing: 12, runSpacing: 12, children: basicCharts),
              ],
              const SizedBox(height: 24),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  collapsedIconColor: Colors.white,
                  iconColor: Colors.white,
                  title: const Text(
                    'Gráficos avanzados (36)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    const SizedBox(height: 12),
                    if (!_loading && _error == null)
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: advancedCharts,
                      )
                    else if (_loading)
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      )
                    else
                      _ErrorPanel(message: _error!, onRetry: _loadChartData),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lineChart(int index) {
    final color = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.cyan,
    ][index % 6];

    return SizedBox(
      height: 110,
      width: 180,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: color,
              barWidth: 2.5,
              belowBarData: BarAreaData(
                show: true,
                color: color.withOpacity(0.15),
              ),
              spots: _ratingSpots(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barChart(int index) {
    final colors = [
      Colors.amber,
      Colors.green,
      Colors.purple,
      Colors.red,
      Colors.cyan,
    ];
    return SizedBox(
      height: 110,
      width: 180,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            for (int i = 0; i < 5; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: _movieValue(i + index),
                    color: colors[(i + index) % colors.length],
                    width: 10,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _areaChart(int index) {
    final color = [
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.deepOrange,
    ][index % 4];
    return SizedBox(
      height: 110,
      width: 180,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: color,
              barWidth: 2,
              belowBarData: BarAreaData(
                show: true,
                color: color.withOpacity(0.2),
              ),
              spots: _popularitySpots(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pieChart(int index) {
    final colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.cyan,
    ];
    return SizedBox(
      height: 110,
      width: 180,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 20,
          sections: [
            for (int i = 0; i < 4; i++)
              PieChartSectionData(
                value: _genreValue(i + index),
                color: colors[(i + index) % colors.length],
                radius: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _radarChart(int index) {
    final labels = ['A', 'B', 'C', 'D', 'E'];
    return SizedBox(
      height: 110,
      width: 180,
      child: RadarChart(
        RadarChartData(
          dataSets: [
            RadarDataSet(
              fillColor: const Color(0xFF7C4DFF).withOpacity(0.25),
              borderColor: const Color(0xFF7C4DFF),
              entryRadius: 2,
              dataEntries: [
                for (int i = 0; i < 5; i++)
                  RadarEntry(value: _radarValue(i + index)),
              ],
            ),
          ],
          borderData: FlBorderData(show: false),
          radarBorderData: const BorderSide(color: Colors.white24),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 8),
          getTitle: (i, angle) =>
              RadarChartTitle(text: labels[i], angle: angle),
        ),
      ),
    );
  }

  Widget _scatterChart(int index) {
    final colors = [
      Colors.pink,
      Colors.yellow,
      Colors.teal,
      Colors.deepPurple,
      Colors.orange,
    ];
    return SizedBox(
      height: 110,
      width: 180,
      child: ScatterChart(
        ScatterChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          scatterSpots: [
            for (int i = 0; i < 6; i++)
              ScatterSpot(
                i.toDouble(),
                _movieValue(i + index),
                dotPainter: FlDotCirclePainter(
                  radius: 5,
                  color: colors[(i + index) % colors.length],
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _ratingSpots(int index) {
    return _chartMovies(index).asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.voteAverage);
    }).toList();
  }

  List<FlSpot> _popularitySpots(int index) {
    return _chartMovies(index).asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.popularity);
    }).toList();
  }

  List<Movie> _chartMovies(int index) {
    if (_movies.isEmpty) return const [];
    final start = index % _movies.length;
    return List.generate(
      _movies.length < 6 ? _movies.length : 6,
      (offset) => _movies[(start + offset) % _movies.length],
    );
  }

  double _movieValue(int index) {
    if (_movies.isEmpty) return 0;
    return _movies[index % _movies.length].voteAverage;
  }

  double _genreValue(int index) {
    if (_movies.isEmpty) return 1;
    final movie = _movies[index % _movies.length];
    return movie.genreIds.isEmpty ? 1 : movie.genreIds.length.toDouble();
  }

  double _radarValue(int index) {
    if (_movies.isEmpty) return 1;
    final movie = _movies[index % _movies.length];
    return switch (index % 4) {
      0 => movie.voteAverage,
      1 => movie.popularity.clamp(0, 10).toDouble(),
      2 => movie.genreIds.length.toDouble(),
      _ => movie.overview.length.clamp(1, 10).toDouble(),
    };
  }
}

class _ChartVariant {
  final String family;
  final String variant;

  const _ChartVariant(this.family, this.variant);
}

class _ErrorPanel extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorPanel({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2030),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}

class _ChartTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget preview;

  const _ChartTile({
    required this.title,
    required this.subtitle,
    required this.preview,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1D2235),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Color(0xFFB8B8C8), fontSize: 12),
          ),
          const SizedBox(height: 8),
          Center(child: preview),
        ],
      ),
    );
  }
}
