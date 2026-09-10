import 'dart:convert';

import '../../../core/network/tmdb_client.dart';
import '../../../core/models/movie.dart';

class MovieDetailProvider {
  Future<Movie> getMovieDetails(int movieId) async {
    final response = await TmdbClient.get('/movie/$movieId');
    final decoded = jsonDecode(response.body);
    return Movie.fromJson(decoded);
  }
}
