import 'package:flutter/material.dart';

import 'features/charts/presentation/fl_chart_demo_page.dart';
import 'features/favorites/presentation/favorite_page.dart';
import 'features/home/presentation/home_page.dart';
import 'features/search/presentation/search_page.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF111526),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7C4DFF)),
        useMaterial3: true,
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final screens = [
    const HomePage(),
    const SearchPage(),
    const FavoritePage(),
    const FlChartDemoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF111526),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          if (index >= 0 && index < screens.length) {
            setState(() => _currentIndex = index);
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favoritos'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Gráficas'),
        ],
      ),
    );
  }
}
