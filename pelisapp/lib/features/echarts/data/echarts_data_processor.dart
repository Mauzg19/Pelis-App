import 'dart:convert';

import '../../../core/models/movie.dart';

/// Transforma datos de [Movie] en estructuras JSON para Apache ECharts.
class EchartsDataProcessor {
  EchartsDataProcessor._();

  // ── Nombres cortos ───────────────────────────────────────────────
  static String _short(String t) => t.length > 10 ? '${t.substring(0, 8)}…' : t;

  // ── Categorías (nombres de películas) ────────────────────────────
  static List<String> movieLabels(List<Movie> m, [int n = 10]) =>
      m.take(n).map((e) => _short(e.title)).toList();

  // ── Ratings ──────────────────────────────────────────────────────
  static List<double> ratings(List<Movie> m, [int n = 10]) =>
      m.take(n).map((e) => e.voteAverage).toList();

  // ── Popularidad ──────────────────────────────────────────────────
  static List<double> popularity(List<Movie> m, [int n = 10]) =>
      m.take(n).map((e) => e.popularity).toList();

  // ── Popularidad normalizada 0-10 ─────────────────────────────────
  static List<double> popularityNorm(List<Movie> m, [int n = 10]) {
    final sub = m.take(n).toList();
    final mx = sub.fold<double>(
      1,
      (p, e) => e.popularity > p ? e.popularity : p,
    );
    return sub
        .map((e) => double.parse(((e.popularity / mx) * 10).toStringAsFixed(1)))
        .toList();
  }

  // ── Géneros (distribución) ───────────────────────────────────────
  static List<Map<String, dynamic>> genrePieData(List<Movie> m) {
    final counts = <int, int>{};
    for (final movie in m) {
      for (final g in movie.genreIds) {
        counts[g] = (counts[g] ?? 0) + 1;
      }
    }
    final names = _genreMap();
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .take(8)
        .map((e) => {'name': names[e.key] ?? 'G${e.key}', 'value': e.value})
        .toList();
  }

  // ── Idiomas (distribución) ───────────────────────────────────────
  static List<Map<String, dynamic>> languagePieData(List<Movie> m) {
    final counts = <String, int>{};
    for (final movie in m) {
      final l = movie.originalLanguage.isNotEmpty
          ? movie.originalLanguage.toUpperCase()
          : 'N/A';
      counts[l] = (counts[l] ?? 0) + 1;
    }
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .take(6)
        .map((e) => {'name': e.key, 'value': e.value})
        .toList();
  }

  // ── Radar indicadores ────────────────────────────────────────────
  static List<Map<String, dynamic>> radarIndicators() => [
    {'name': 'Rating', 'max': 10},
    {'name': 'Popularidad', 'max': 10},
    {'name': 'Géneros', 'max': 10},
    {'name': 'Sinopsis', 'max': 10},
    {'name': 'Año', 'max': 10},
  ];

  static List<double> radarValues(Movie m) {
    final year = m.releaseDate.length >= 4
        ? int.tryParse(m.releaseDate.substring(0, 4)) ?? 0
        : 0;
    return [
      m.voteAverage,
      (m.popularity.clamp(0, 500) / 50).clamp(0, 10),
      m.genreIds.length.toDouble().clamp(0, 10),
      (m.overview.length / 50).clamp(0, 10),
      ((year - 2010) / 1.5).clamp(0, 10),
    ];
  }

  // ── Comparación de rating y popularidad normalizada ──────────────
  static List<List<double>> candleData(List<Movie> m, [int n = 12]) {
    final movies = m.take(n).toList();
    final normalizedPopularity = popularityNorm(movies, movies.length);
    return List.generate(movies.length, (index) {
      final rating = movies[index].voteAverage.clamp(0, 10);
      final popularity = normalizedPopularity[index];
      return [
        double.parse(rating.toStringAsFixed(1)),
        popularity,
        double.parse(
          (rating < popularity ? rating : popularity).toStringAsFixed(1),
        ),
        double.parse(
          (rating > popularity ? rating : popularity).toStringAsFixed(1),
        ),
      ];
    });
  }

  static List<String> candleCategories(List<Movie> m, [int n = 12]) =>
      movieLabels(m, n);

  // ── Heatmap data [x, y, value] ───────────────────────────────────
  static List<List<dynamic>> heatmapData(List<Movie> m) {
    final result = <List<dynamic>>[];
    final sub = m.take(10).toList();
    for (int i = 0; i < sub.length; i++) {
      for (int j = 0; j < 5; j++) {
        final val = switch (j) {
          0 => sub[i].voteAverage,
          1 => (sub[i].popularity / 50).clamp(0, 10),
          2 => sub[i].genreIds.length.toDouble(),
          3 => (sub[i].overview.length / 50).clamp(0, 10),
          _ => sub[i].voteAverage * 0.8,
        };
        result.add([i, j, double.parse(val.toStringAsFixed(1))]);
      }
    }
    return result;
  }

  // ── Treemap data ─────────────────────────────────────────────────
  static List<Map<String, dynamic>> treemapData(List<Movie> m) {
    final genres = genrePieData(m);
    return genres
        .map(
          (g) => {
            'name': g['name'],
            'children': m
                .where(
                  (movie) =>
                      movie.genreIds.any((id) => _genreMap()[id] == g['name']),
                )
                .map(
                  (movie) => {
                    'name': _short(movie.title),
                    'value': 1,
                  },
                )
                .toList(),
          },
        )
        .toList();
  }

  // ── Sunburst data ────────────────────────────────────────────────
  static List<Map<String, dynamic>> sunburstData(List<Movie> m) {
    final langCounts = <String, List<Movie>>{};
    for (final movie in m) {
      final l = movie.originalLanguage.isNotEmpty
          ? movie.originalLanguage.toUpperCase()
          : 'N/A';
      langCounts.putIfAbsent(l, () => []).add(movie);
    }
    return langCounts.entries
        .take(5)
        .map(
          (e) => {
            'name': e.key,
            'children': e.value
                .take(4)
                .map(
                  (movie) => {
                    'name': _short(movie.title),
                    'value': (movie.voteAverage * 10).round(),
                  },
                )
                .toList(),
          },
        )
        .toList();
  }

  // ── Sankey links ─────────────────────────────────────────────────
  static Map<String, dynamic> sankeyData(List<Movie> m) {
    final nodes = <String>{};
    final links = <Map<String, dynamic>>[];
    final gMap = _genreMap();

    for (final movie in m.take(15)) {
      final lang = movie.originalLanguage.isNotEmpty
          ? movie.originalLanguage.toUpperCase()
          : 'N/A';
      nodes.add(lang);
      for (final gId in movie.genreIds.take(2)) {
        final gName = gMap[gId] ?? 'G$gId';
        nodes.add(gName);
        links.add({'source': lang, 'target': gName, 'value': 1});
      }
    }

    // Merge duplicate links
    final merged = <String, Map<String, dynamic>>{};
    for (final l in links) {
      final key = '${l['source']}->${l['target']}';
      if (merged.containsKey(key)) {
        merged[key]!['value'] = (merged[key]!['value'] as int) + 1;
      } else {
        merged[key] = Map.from(l);
      }
    }

    return {
      'nodes': nodes.map((n) => {'name': n}).toList(),
      'links': merged.values.toList(),
    };
  }

  // ── Graph data ───────────────────────────────────────────────────
  static Map<String, dynamic> graphData(List<Movie> m) {
    final sub = m.take(12).toList();
    final nodes = sub
        .map(
          (movie) => {
            'name': '${_short(movie.title)} #${movie.id}',
            'symbolSize': (movie.voteAverage * 5).round(),
            'value': movie.voteAverage,
            'category': movie.voteAverage < 4
                ? 0
                : movie.voteAverage < 7
                    ? 1
                    : 2,
          },
        )
        .toList();

    final links = <Map<String, dynamic>>[];
    for (int i = 0; i < sub.length; i++) {
      for (int j = i + 1; j < sub.length; j++) {
        final shared = sub[i].genreIds
            .where((g) => sub[j].genreIds.contains(g))
            .length;
        if (shared > 0) {
          links.add({
            'source': '${_short(sub[i].title)} #${sub[i].id}',
            'target': '${_short(sub[j].title)} #${sub[j].id}',
            'value': shared,
          });
        }
      }
    }

    return {
      'nodes': nodes,
      'links': links,
      'categories': [
        {'name': 'Rating < 4'},
        {'name': 'Rating 4–7'},
        {'name': 'Rating ≥ 7'},
      ],
    };
  }

  // ── Parallel data ────────────────────────────────────────────────
  static List<List<double>> parallelData(List<Movie> m, [int n = 10]) {
    return m.take(n).map((movie) {
      final year = movie.releaseDate.length >= 4
          ? int.tryParse(movie.releaseDate.substring(0, 4)) ?? 0
          : 0;
      return [
        movie.voteAverage,
        (movie.popularity / 50).clamp(0.0, 10.0),
        movie.genreIds.length.toDouble(),
        (movie.overview.length / 50).clamp(0.0, 10.0),
        (year - 2010).toDouble().clamp(0.0, 16.0),
      ];
    }).toList();
  }

  // ── ThemeRiver data ──────────────────────────────────────────────
  static List<List<dynamic>> themeRiverData(List<Movie> m) {
    final result = <List<dynamic>>[];
    final genres = ['Acción', 'Drama', 'Comedia', 'Terror', 'Ciencia F.'];
    final gIds = [28, 18, 35, 27, 878];
    final years =
        m
            .map(
              (movie) => movie.releaseDate.length >= 4
                  ? int.tryParse(movie.releaseDate.substring(0, 4))
                  : null,
            )
            .whereType<int>()
            .toSet()
            .toList()
          ..sort();

    for (final year in years) {
      for (int gi = 0; gi < genres.length; gi++) {
        final count = m.where((movie) {
          final y = movie.releaseDate.length >= 4
              ? int.tryParse(movie.releaseDate.substring(0, 4))
              : null;
          return y == year && movie.genreIds.contains(gIds[gi]);
        }).length;
        if (count > 0) result.add(['$year', count, genres[gi]]);
      }
    }
    return result;
  }

  // ── Boxplot data ─────────────────────────────────────────────────
  static List<List<double>> boxplotData(List<Movie> m) {
    final ratings = m.map((e) => e.voteAverage).toList()..sort();
    if (ratings.length < 5) return [ratings];

    final chunks = <List<double>>[];
    final size = (ratings.length / 4).ceil();
    for (int i = 0; i < 4; i++) {
      final chunk = ratings.skip(i * size).take(size).toList();
      if (chunk.isNotEmpty) chunks.add(chunk);
    }
    return chunks;
  }

  // ── Gauge value ──────────────────────────────────────────────────
  static double avgRating(List<Movie> m) {
    if (m.isEmpty) return 0;
    return double.parse(
      (m.fold<double>(0, (s, e) => s + e.voteAverage) / m.length)
          .toStringAsFixed(1),
    );
  }

  // ── JSON encode helper ───────────────────────────────────────────
  static String encode(Object? value) => jsonEncode(value);

  // ── Genre map ────────────────────────────────────────────────────
  static Map<int, String> _genreMap() => {
    28: 'Acción',
    12: 'Aventura',
    16: 'Animación',
    35: 'Comedia',
    80: 'Crimen',
    99: 'Documental',
    18: 'Drama',
    10751: 'Familia',
    14: 'Fantasía',
    36: 'Historia',
    27: 'Terror',
    10402: 'Música',
    9648: 'Misterio',
    10749: 'Romance',
    878: 'Ciencia F.',
    10770: 'TV Movie',
    53: 'Suspense',
    10752: 'Bélica',
    37: 'Western',
  };
}
