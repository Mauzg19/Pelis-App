import 'dart:convert';

import '../../../core/constants/tmdb_constants.dart';
import '../../../core/models/movie.dart';
import '../../../core/network/tmdb_client.dart';

class TmdbMovieRepository {
  Future<List<Movie>> getPopularMovies() async {
    final response = await TmdbClient.get('/movie/popular');
    final decoded = jsonDecode(response.body);
    final results = decoded['results'] as List;
    return results.map((e) => Movie.fromJson(e)).toList();
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.trim().isEmpty) return [];

    final response = await TmdbClient.get(
      '/search/movie',
      queryParameters: {'query': query},
    );

    final decoded = jsonDecode(response.body);
    final results = decoded['results'] as List;
    return results.map((e) => Movie.fromJson(e)).toList();
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final response = await TmdbClient.get('/movie/$movieId');
    final decoded = jsonDecode(response.body);
    return Movie.fromJson(decoded);
  }

  Future<List<String>> getGenres() async {
    final response = await TmdbClient.get('/genre/movie/list');
    final decoded = jsonDecode(response.body);
    final genres = decoded['genres'] as List;
    return genres.map((e) => e['name'].toString()).toList();
  }

  String getImageUrl(String path) {
    return '${TmdbConstants.imageBaseUrl}$path';
  }
}
