import 'package:flutter/material.dart';

import '../../../core/models/movie.dart';
import '../../../core/services/favorites_service.dart';
import '../data/movie_detail_provider.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieDetailProvider _provider = MovieDetailProvider();
  Movie? _movie;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMovie();
  }

  Future<void> _loadMovie() async {
    try {
      final loaded = await _provider.getMovieDetails(widget.movie.id);
      setState(() {
        _movie = loaded;
        _loading = false;
      });
    } catch (_) {
      setState(() {
        _movie = widget.movie;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = _movie ?? widget.movie;

    return Scaffold(
      backgroundColor: const Color(0xFF111526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111526),
        title: const Text('Detalle'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    movie.backdropUrl,
                    height: 260,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox(
                      height: 260,
                      child: Center(child: Icon(Icons.image, color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                movie.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                FavoriteService.toggleFavorite(movie);
                                setState(() {});
                              },
                              icon: Icon(
                                FavoriteService.isFavorite(movie.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: FavoriteService.isFavorite(movie.id)
                                    ? Colors.pink
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 6),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('Descripción', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          movie.overview,
                          style: const TextStyle(color: Color(0xFFB8B8C8), fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          children: [
                            _infoChip('Duración', movie.runtime != null ? '${movie.runtime} min' : 'N/A'),
                            _infoChip('Fecha', movie.releaseDate.isEmpty ? 'N/A' : movie.releaseDate),
                            _infoChip('Idioma', movie.originalLanguage.isEmpty ? 'N/A' : movie.originalLanguage),
                            _infoChip('Estado', movie.status.isEmpty ? 'Released' : movie.status),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _metricsSection(movie),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Chip(
      label: Text('$label: $value'),
      backgroundColor: const Color(0xFF252B45),
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  Widget _metricsSection(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Datos clave', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Presupuesto: ${movie.budget ?? 'N/A'}', style: const TextStyle(color: Colors.white70)),
        Text('Ingresos: ${movie.revenue ?? 'N/A'}', style: const TextStyle(color: Colors.white70)),
        Text('Popularidad: ${movie.popularity.toStringAsFixed(1)}', style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
