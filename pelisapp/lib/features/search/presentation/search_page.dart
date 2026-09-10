import 'package:flutter/material.dart';

import '../../../core/models/movie.dart';
import '../../../core/services/favorites_service.dart';
import '../../home/data/tmdb_movie_repository.dart';
import '../../movie_detail/presentation/movie_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TmdbMovieRepository _repository = TmdbMovieRepository();
  final TextEditingController _controller = TextEditingController();
  List<Movie> _movies = [];
  bool _loading = false;

  Future<void> _search([String? query]) async {
    final q = (query ?? _controller.text).trim();
    if (q.isEmpty) {
      setState(() {
        _movies = [];
        _loading = false;
      });
      return;
    }

    setState(() => _loading = true);

    try {
      final movies = await _repository.searchMovies(q);
      setState(() {
        _movies = movies;
        _loading = false;
      });
    } catch (_) {
      setState(() {
        _loading = false;
        _movies = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111526),
        title: const Text('Buscar'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) => _search(value),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Batman',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF22263A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () => _search(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: _movies.isEmpty
                        ? const Center(
                            child: Text(
                              'Sin resultados',
                              style: TextStyle(color: Colors.white70),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _movies.length,
                            itemBuilder: (_, index) {
                              final movie = _movies[index];
                              return Card(
                                color: const Color(0xFF22263A),
                                child: ListTile(
                                  leading: Image.network(
                                    movie.posterUrl,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    movie.title,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    '${movie.releaseDate} • ${movie.voteAverage.toStringAsFixed(1)}',
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      FavoriteService.isFavorite(movie.id)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: FavoriteService.isFavorite(movie.id)
                                          ? Colors.pink
                                          : Colors.white70,
                                    ),
                                    onPressed: () {
                                      FavoriteService.toggleFavorite(movie);
                                      setState(() {});
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MovieDetailPage(movie: movie),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
