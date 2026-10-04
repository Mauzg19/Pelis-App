enum CommunityChartType { bar, line, area, pie, scatter, combo }

enum CommunityChartMetric { rating, popularity, genreCount, releaseYear }

class CommunityChartDefinition {
  const CommunityChartDefinition({
    required this.title,
    required this.type,
    required this.metric,
    required this.variant,
  });

  final String title;
  final CommunityChartType type;
  final CommunityChartMetric metric;
  final int variant;
}

class CommunityChartCatalog {
  CommunityChartCatalog._();

  static const _metrics = CommunityChartMetric.values;
  static const _barVariants = [
    'Columnas de calificación',
    'Barras horizontales de popularidad',
    'Barras agrupadas por película',
    'Barras apiladas por película',
    'Barras agrupadas y apiladas',
    'Barras horizontales agrupadas',
    'Barras de recuento de géneros',
    'Barras de año de estreno',
    'Barras de comparación',
    'Barras de películas populares',
    'Barras con valores de rating',
    'Barras de popularidad normalizada',
    'Barras compactas',
    'Barras con esquinas redondeadas',
    'Barras de métrica por película',
  ];
  static const _lineVariants = [
    'Línea de calificaciones',
    'Línea de popularidad',
    'Línea con puntos',
    'Línea de comparación de métricas',
    'Línea con área',
    'Línea de área apilada',
    'Línea de estreno por película',
    'Línea multiserie',
    'Línea con segmentos',
    'Línea de rating por título',
    'Línea de popularidad por título',
    'Línea de recuento de géneros',
    'Línea con puntos y área',
    'Línea de series comparadas',
    'Línea de datos TMDB',
  ];
  static const _areaVariants = [
    'Área de calificaciones',
    'Área de popularidad',
    'Área con puntos',
    'Área apilada',
    'Área de comparación',
    'Área multiserie',
    'Área de rating por estreno',
    'Área de recuento de géneros',
    'Área de popularidad por título',
    'Área con series apiladas',
    'Área de películas mejor valoradas',
    'Área de datos normalizados',
    'Área de métricas TMDB',
  ];
  static const _pieVariants = [
    'Circular de calificaciones',
    'Dona de calificaciones',
    'Circular de popularidad',
    'Dona de popularidad',
    'Circular de recuento de géneros',
    'Dona de géneros',
    'Circular de estrenos',
    'Dona de estrenos',
    'Circular de películas populares',
    'Dona de popularidad normalizada',
    'Circular de ratings por película',
    'Dona de ratings por película',
  ];
  static const _scatterVariants = [
    'Rating frente a popularidad',
    'Rating frente a géneros',
    'Popularidad frente a géneros',
    'Rating frente al año de estreno',
    'Popularidad frente al año de estreno',
    'Dispersión con puntos grandes',
    'Dispersión por películas',
    'Dispersión de métricas TMDB',
    'Rating frente a popularidad normalizada',
    'Rating por número de géneros',
    'Puntos de películas populares',
    'Dispersión de estrenos',
  ];
  static const _comboVariants = [
    'Barras de rating y línea de popularidad',
    'Barras de popularidad y línea de rating',
    'Barras de rating con línea de géneros',
    'Barras de géneros con línea de rating',
    'Barras de estreno y línea de popularidad',
    'Barras de popularidad por título con línea',
    'Comparación combinada de calificación',
    'Comparación combinada de popularidad',
    'Gráfico combinado por película',
    'Gráfico combinado de ratings TMDB',
    'Gráfico combinado de popularidad TMDB',
    'Series combinadas de películas',
  ];

  static final basic = [
    ..._definitions(_barVariants, CommunityChartType.bar),
    ..._definitions(_lineVariants, CommunityChartType.line),
    ..._definitions(_areaVariants, CommunityChartType.area),
  ];

  static final advanced = [
    ..._definitions(_pieVariants, CommunityChartType.pie),
    ..._definitions(_scatterVariants, CommunityChartType.scatter),
    ..._definitions(_comboVariants, CommunityChartType.combo),
  ];

  static List<CommunityChartDefinition> _definitions(
    List<String> titles,
    CommunityChartType type,
  ) => [
    for (var index = 0; index < titles.length; index++)
      CommunityChartDefinition(
        title: titles[index],
        type: type,
        metric: _metrics[index % _metrics.length],
        variant: index,
      ),
  ];
}
