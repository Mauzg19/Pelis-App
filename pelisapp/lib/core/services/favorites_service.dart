import 'package:flutter/foundation.dart';

import '../../features/home/data/tmdb_movie_repository.dart';
import '../../core/models/movie.dart';

class FavoriteService {
  static final ValueNotifier<Set<int>> favoriteMovieIds =
      ValueNotifier<Set<int>>(<int>{});

  static final ValueNotifier<List<Movie>> favoriteMovies =
      ValueNotifier<List<Movie>>(<Movie>[]);

  static final TmdbMovieRepository _repository = TmdbMovieRepository();

  static bool isFavorite(int movieId) {
    return favoriteMovieIds.value.contains(movieId);
  }

  static void toggleFavorite(Movie movie) {
    final updated = Set<int>.from(favoriteMovieIds.value);
    if (updated.contains(movie.id)) {
      updated.remove(movie.id);
      favoriteMovies.value = favoriteMovies.value
          .where((element) => element.id != movie.id)
          .toList();
    } else {
      updated.add(movie.id);
      final list = List<Movie>.from(favoriteMovies.value);
      if (!list.any((element) => element.id == movie.id)) {
        list.add(movie);
      }
      favoriteMovies.value = list;
    }
    favoriteMovieIds.value = updated;
  }

  static Future<void> syncMovieFromApi(int movieId) async {
    try {
      final movie = await _repository.getMovieDetails(movieId);
      final list = List<Movie>.from(favoriteMovies.value);
      final index = list.indexWhere((element) => element.id == movie.id);
      if (index >= 0) {
        list[index] = movie;
      } else {
        list.add(movie);
      }
      favoriteMovies.value = list;
    } catch (_) {
      // Ignora y conserva el estado local.
    }
  }
}
