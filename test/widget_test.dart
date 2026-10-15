import 'package:flutter_test/flutter_test.dart';
import 'package:calc_web/main.dart';

void main() {
  testWidgets('Переход в калькулятор и возвращение на главную',
      (tester) async {
    await tester.pumpWidget(const CalcApp());
    await tester.pumpAndSettle();

    expect(find.text('Главная'), findsOneWidget);

    await tester.tap(find.text('Калькулятор'));
    await tester.pumpAndSettle();

    expect(find.text('Калькулятор'), findsOneWidget);

    await tester.tap(find.byTooltip('На главную'));
    await tester.pumpAndSettle();

    expect(find.text('Главная'), findsOneWidget);
  });
}
