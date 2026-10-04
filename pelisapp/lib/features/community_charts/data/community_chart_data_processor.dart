import '../../../core/models/movie.dart';

class CommunityMovieDatum {
  const CommunityMovieDatum({
    required this.label,
    required this.index,
    required this.rating,
    required this.popularity,
    required this.genreCount,
    required this.releaseYear,
  });

  final String label;
  final int index;
  final double rating;
  final double popularity;
  final double genreCount;
  final int? releaseYear;
}

class CommunityChartDataProcessor {
  CommunityChartDataProcessor._();

  static List<CommunityMovieDatum> movies(List<Movie> movies, {int count = 10}) {
    final subset = movies.take(count).toList();
    final maxPopularity = subset.fold<double>(
      1,
      (maximum, movie) =>
          movie.popularity > maximum ? movie.popularity : maximum,
    );

    return [
      for (var index = 0; index < subset.length; index++)
        CommunityMovieDatum(
          label: _shortTitle(subset[index].title, index),
          index: index,
          rating: subset[index].voteAverage.clamp(0, 10).toDouble(),
          popularity: (subset[index].popularity / maxPopularity * 10)
              .clamp(0, 10)
              .toDouble(),
          genreCount: subset[index].genreIds.length.toDouble(),
          releaseYear: _releaseYear(subset[index].releaseDate),
        ),
    ];
  }

  static String _shortTitle(String title, int index) {
    final shortened = title.length > 13 ? '${title.substring(0, 12)}…' : title;
    return '${index + 1}. $shortened';
  }

  static int? _releaseYear(String date) {
    if (date.length < 4) return null;
    return int.tryParse(date.substring(0, 4));
  }
}
