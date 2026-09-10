import 'package:flutter/material.dart';

import '../../../core/models/movie.dart';
import '../../../core/services/favorites_service.dart';
import '../../movie_detail/presentation/movie_detail_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111526),
        title: const Text('Favoritos'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
      ),
      body: ValueListenableBuilder<List<Movie>>(
        valueListenable: FavoriteService.favoriteMovies,
        builder: (context, movies, _) {
          if (movies.isEmpty) {
            return const Center(
              child: Text(
                'No tienes películas favoritas',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: movies.length,
            itemBuilder: (_, index) {
              final movie = movies[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF22263A),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailPage(movie: movie),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          movie.posterUrl,
                          width: 64,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Icon(Icons.image, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MovieDetailPage(movie: movie),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              movie.releaseDate.isEmpty ? 'Sin fecha' : movie.releaseDate,
                              style: const TextStyle(color: Color(0xFFB8B8C8)),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  movie.voteAverage.toStringAsFixed(1),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.pink),
                      onPressed: () {
                        FavoriteService.toggleFavorite(movie);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
