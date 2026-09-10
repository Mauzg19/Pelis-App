import 'package:flutter_test/flutter_test.dart';

import 'package:pelisapp/app.dart';

void main() {
  testWidgets('MovieApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MovieApp());
    expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Buscar'), findsOneWidget);
  });
}
