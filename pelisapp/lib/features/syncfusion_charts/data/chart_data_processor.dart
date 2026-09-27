import '../../../core/models/movie.dart';

// ─── Modelos de datos para gráficas ────────────────────────────────

/// Dato genérico: etiqueta + valor numérico.
class MovieChartData {
  MovieChartData(this.label, this.value, [this.value2]);
  final String label;
  final double value;
  final double? value2;
}

/// Dato con categoría y múltiples valores (para series múltiples / stacked).
class MultiValueChartData {
  MultiValueChartData(this.label, this.v1, this.v2, [this.v3, this.v4]);
  final String label;
  final double v1;
  final double v2;
  final double? v3;
  final double? v4;
}

/// Dato con rango (mín-máx).
class RangeChartData {
  RangeChartData(this.label, this.low, this.high);
  final String label;
  final double low;
  final double high;
}

/// Dato financiero (OHLC / Candle).
class FinancialChartData {
  FinancialChartData(this.date, this.open, this.high, this.low, this.close);
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
}

/// Dato para Bubble (x, y, tamaño).
class BubbleChartData {
  BubbleChartData(this.x, this.y, this.size, this.label);
  final double x;
  final double y;
  final double size;
  final String label;
}

/// Dato para Waterfall.
class WaterfallChartData {
  WaterfallChartData(this.label, this.value, {this.isTotal = false});
  final String label;
  final double value;
  final bool isTotal;
}

// ─── Procesador ────────────────────────────────────────────────────

class ChartDataProcessor {
  ChartDataProcessor._();

  // ── Ratings por película (top N) ──────────────────────────────
  static List<MovieChartData> ratingsData(
    List<Movie> movies, [
    int count = 10,
  ]) {
    final subset = movies.take(count).toList();
    return subset
        .map((m) => MovieChartData(_shortTitle(m.title), m.voteAverage))
        .toList();
  }

  // ── Popularidad por película ──────────────────────────────────
  static List<MovieChartData> popularityData(
    List<Movie> movies, [
    int count = 10,
  ]) {
    final subset = movies.take(count).toList();
    return subset
        .map((m) => MovieChartData(_shortTitle(m.title), m.popularity))
        .toList();
  }

  // ── Rating + Popularidad (normalizada) — para multiserie ─────
  static List<MultiValueChartData> ratingVsPopularity(
    List<Movie> movies, [
    int count = 10,
  ]) {
    final subset = movies.take(count).toList();
    final maxPop = subset.fold<double>(
      1,
      (p, m) => m.popularity > p ? m.popularity : p,
    );
    return subset
        .map(
          (m) => MultiValueChartData(
            _shortTitle(m.title),
            m.voteAverage,
            (m.popularity / maxPop) * 10,
          ),
        )
        .toList();
  }

  // ── Distribución de géneros (conteo) ──────────────────────────
  static List<MovieChartData> genreDistribution(List<Movie> movies) {
    final counts = <int, int>{};
    for (final m in movies) {
      for (final g in m.genreIds) {
        counts[g] = (counts[g] ?? 0) + 1;
      }
    }
    final genreNames = _genreMap();
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .take(8)
        .map(
          (e) => MovieChartData(
            genreNames[e.key] ?? 'G${e.key}',
            e.value.toDouble(),
          ),
        )
        .toList();
  }

  // ── Distribución de idiomas ───────────────────────────────────
  static List<MovieChartData> languageDistribution(List<Movie> movies) {
    final counts = <String, int>{};
    for (final m in movies) {
      final lang = m.originalLanguage.isNotEmpty ? m.originalLanguage : 'N/A';
      counts[lang] = (counts[lang] ?? 0) + 1;
    }
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .take(6)
        .map((e) => MovieChartData(e.key.toUpperCase(), e.value.toDouble()))
        .toList();
  }

  // ── Datos de rango (rating mín/máx por lotes) ────────────────
  static List<RangeChartData> rangeData(List<Movie> movies, [int groups = 6]) {
    if (movies.isEmpty || groups <= 0) return const [];
    final result = <RangeChartData>[];
    final size = (movies.length / groups).ceil();
    for (int i = 0; i < groups && i * size < movies.length; i++) {
      final chunk = movies.skip(i * size).take(size).toList();
      final ratings = chunk.map((m) => m.voteAverage).toList();
      final low = ratings.reduce((a, b) => a < b ? a : b);
      final high = ratings.reduce((a, b) => a > b ? a : b);
      result.add(RangeChartData('Grupo ${i + 1}', low, high));
    }
    return result;
  }

  // ── Rating y popularidad TMDB por fecha de estreno (rango OHLC)
  static List<FinancialChartData> financialData(
    List<Movie> movies, [
    int count = 12,
  ]) {
    final subset = movies.take(count).toList();
    final maxPopularity = subset.fold<double>(
      1,
      (maximum, movie) =>
          movie.popularity > maximum ? movie.popularity : maximum,
    );
    final result = <FinancialChartData>[];
    for (final movie in subset) {
      final date = DateTime.tryParse(movie.releaseDate);
      if (date == null) continue;
      final rating = movie.voteAverage.clamp(0, 10).toDouble();
      final popularity = (movie.popularity / maxPopularity * 10)
          .clamp(0, 10)
          .toDouble();
      result.add(
        FinancialChartData(
          date,
          rating,
          rating > popularity ? rating : popularity,
          rating < popularity ? rating : popularity,
          popularity,
        ),
      );
    }
    return result;
  }

  // ── Datos Bubble ──────────────────────────────────────────────
  static List<BubbleChartData> bubbleData(
    List<Movie> movies, [
    int count = 10,
  ]) {
    final subset = movies.take(count).toList();
    return subset
        .map(
          (m) => BubbleChartData(
            m.voteAverage,
            m.popularity.clamp(0, 500),
            m.genreIds.length.toDouble() * 3 + 5,
            _shortTitle(m.title),
          ),
        )
        .toList();
  }

  // ── Datos Waterfall ───────────────────────────────────────────
  static List<WaterfallChartData> waterfallData(List<Movie> movies) {
    final result = <WaterfallChartData>[];
    double running = 0;
    final subset = movies.take(8).toList();
    for (int i = 0; i < subset.length; i++) {
      final delta = subset[i].voteAverage - 5; // diferencia desde 5
      running += delta;
      result.add(WaterfallChartData(_shortTitle(subset[i].title), delta));
    }
    result.add(WaterfallChartData('Total', running, isTotal: true));
    return result;
  }

  // ── Datos para Stacked (4 series agrupadas) ───────────────────
  static List<MultiValueChartData> stackedData(
    List<Movie> movies, [
    int count = 8,
  ]) {
    final subset = movies.take(count).toList();
    return subset
        .map(
          (m) => MultiValueChartData(
            _shortTitle(m.title),
            m.voteAverage,
            (m.popularity / 50).clamp(0, 10),
            m.genreIds.length.toDouble(),
            (m.overview.length / 50).clamp(0, 10),
          ),
        )
        .toList();
  }

  // ── Datos Histogram (valores de rating) ───────────────────────
  static List<MovieChartData> histogramData(List<Movie> movies) {
    return movies.map((m) => MovieChartData(m.title, m.voteAverage)).toList();
  }

  // ── Datos Spark (mini serie) ──────────────────────────────────
  static List<double> sparkData(List<Movie> movies, [int count = 15]) {
    return movies.take(count).map((m) => m.voteAverage).toList();
  }

  // ── Helpers ───────────────────────────────────────────────────

  static String _shortTitle(String title) {
    return title.length > 12 ? '${title.substring(0, 10)}…' : title;
  }

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
