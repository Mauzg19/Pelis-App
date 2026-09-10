class Movie {
  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds,
    required this.runtime,
    required this.budget,
    required this.revenue,
    required this.originalLanguage,
    required this.status,
    required this.popularity,
  });

  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double voteAverage;
  final List<int> genreIds;
  final int? runtime;
  final int? budget;
  final int? revenue;
  final String originalLanguage;
  final String status;
  final double popularity;

  String get posterUrl => posterPath.isNotEmpty
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : 'https://via.placeholder.com/500x750?text=No+Image';

  String get backdropUrl => backdropPath.isNotEmpty
      ? 'https://image.tmdb.org/t/p/original$backdropPath'
      : 'https://via.placeholder.com/1200x675?text=No+Image';

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] ?? json['name'] ?? 'Sin título',
      overview: json['overview'] ?? 'Sin descripción disponible',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      releaseDate: json['release_date'] ?? json['first_air_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      runtime: json['runtime'] as int?,
      budget: json['budget'] as int?,
      revenue: json['revenue'] as int?,
      originalLanguage: json['original_language'] ?? '',
      status: json['status'] ?? 'Released',
      popularity: (json['popularity'] ?? 0).toDouble(),
    );
  }
}
