import 'package:flutter_test/flutter_test.dart';
import 'package:jurassica/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JurassicaApp());
  });
}