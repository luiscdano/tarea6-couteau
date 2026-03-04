import 'package:flutter_test/flutter_test.dart';
import 'package:tarea6_couteau/main.dart';

void main() {
  testWidgets('Carga la app de Tarea 6', (WidgetTester tester) async {
    await tester.pumpWidget(const CouteauApp());
    expect(find.text('Home'), findsOneWidget);
  });
}
