import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pelisapp/app.dart';
import 'package:pelisapp/core/models/movie.dart';
import 'package:pelisapp/features/community_charts/data/community_chart_data_processor.dart';
import 'package:pelisapp/features/community_charts/presentation/community_chart_card.dart';
import 'package:pelisapp/features/community_charts/presentation/community_chart_catalog.dart';

void main() {
  final movies = [
    _movie(
      id: 1,
      rating: 8,
      popularity: 25,
      releaseDate: '2024-03-01',
      genreIds: [28, 18],
    ),
    _movie(
      id: 2,
      rating: 6,
      popularity: 5,
      releaseDate: '2023-06-15',
      genreIds: [35],
    ),
  ];

  test('Community Charts has separate basic and advanced catalogs', () {
    expect(CommunityChartCatalog.basic, hasLength(43));
    expect(CommunityChartCatalog.advanced, hasLength(36));
    expect(
      CommunityChartCatalog.basic.map((chart) => chart.title).toSet(),
      hasLength(43),
    );
    expect(
      CommunityChartCatalog.advanced.map((chart) => chart.title).toSet(),
      hasLength(36),
    );
  });

  test('chart data comes from TMDB movie fields and normalizes popularity', () {
    final data = CommunityChartDataProcessor.movies(movies);

    expect(data, hasLength(2));
    expect(data.first.rating, 8);
    expect(data.first.popularity, 10);
    expect(data.first.genreCount, 2);
    expect(data.first.releaseYear, 2024);
    expect(data.last.popularity, 2);
    expect(data.last.releaseYear, 2023);
  });

  test('release year remains absent for movies without a valid API date', () {
    final data = CommunityChartDataProcessor.movies([
      _movie(id: 3, rating: 7, popularity: 2, releaseDate: '', genreIds: []),
    ]);

    expect(data.single.releaseYear, isNull);
  });

  testWidgets('each Community Charts renderer builds with TMDB data', (
    tester,
  ) async {
    final data = CommunityChartDataProcessor.movies(movies);
    final renderedTypes = <CommunityChartType>{};

    for (final definition in [
      ...CommunityChartCatalog.basic,
      ...CommunityChartCatalog.advanced,
    ]) {
      if (!renderedTypes.add(definition.type)) continue;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommunityChartCard(definition: definition, data: data),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('Community Charts is a separate app navigation destination', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AppShell()));
    await tester.tap(find.byIcon(Icons.insert_chart_outlined));
    await tester.pump();

    expect(find.text('Community Charts Flutter'), findsOneWidget);
  });
}

Movie _movie({
  required int id,
  required double rating,
  required double popularity,
  required String releaseDate,
  required List<int> genreIds,
}) => Movie(
  id: id,
  title: 'Película $id',
  overview: 'Descripción $id',
  posterPath: '',
  backdropPath: '',
  releaseDate: releaseDate,
  voteAverage: rating,
  genreIds: genreIds,
  runtime: null,
  budget: null,
  revenue: null,
  originalLanguage: 'es',
  status: 'Released',
  popularity: popularity,
);
