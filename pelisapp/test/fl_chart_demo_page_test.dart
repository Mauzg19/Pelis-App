import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pelisapp/app.dart';
import 'package:pelisapp/features/charts/presentation/fl_chart_demo_page.dart';

void main() {
  testWidgets('FL Chart demo page shows sections', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FlChartDemoPage(),
      ),
    );

    expect(find.text('FL Chart'), findsOneWidget);
    expect(find.text('Gráficos básicos (43)'), findsOneWidget);
    expect(find.text('Gráficos avanzados (36)'), findsOneWidget);
  });

  testWidgets('Selecting chart tab shows FL Chart screen', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AppShell()));

    await tester.tap(find.byIcon(Icons.bar_chart));
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.text('FL Chart'),
      ),
      findsOneWidget,
    );
  });
}
