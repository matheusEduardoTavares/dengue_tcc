import 'package:dengue_tcc/app/utils/input_formatter/input_formatter.dart';
import 'package:dengue_tcc/app/utils/input_formatter/input_formatter_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputFormatter formatter;
  late String mockedPhone;
  late String mockedUnsmaskedPhone;
  late String mockedMaskedPhoneWithoutDash;
  late TextEditingController controller;
  late Widget phonePage;

  Future<void> fillFormField({
    required WidgetTester tester,
    required String text,
    required Widget page,
    Key? textFieldKey,
  }) async {
    await tester.pumpWidget(page);
    await tester.pump();

    await tester.enterText(
        textFieldKey != null
            ? find.byKey(textFieldKey)
            : find.byType(TextField),
        text);
    await tester.pump();
  }

  Widget getPage(List<TextInputFormatter> inputFormatters) {
    return MaterialApp(
      home: Scaffold(
        body: TextField(
          controller: controller,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }

  setUp(() {
    mockedPhone = '(14) 38497-5698';
    mockedMaskedPhoneWithoutDash = '(14) 384975698';
    mockedUnsmaskedPhone = '14384975698';
    formatter = InputFormatterImpl();
    controller = TextEditingController();
    phonePage = getPage([
      formatter.getInputFormatterPhone(),
    ]);
  });

  tearDown(() {
    controller.dispose();
  });

  Future<void> loadWidget({
    required WidgetTester tester,
    required Widget page,
  }) async {
    await tester.pumpWidget(
      page,
    );

    await tester.pump();
  }

  group('phone formatter tests', () {
    test('should get only numbers from phone', () {
      final formattedPhone = formatter.getPhoneUnmask(mockedPhone);
      expect(formattedPhone, equals(mockedUnsmaskedPhone));
    });

    testWidgets('should get phone with mask', (WidgetTester tester) async {
      await loadWidget(
        tester: tester,
        page: phonePage,
      );
      final formattedPhone = formatter.getPhoneMask(mockedUnsmaskedPhone);
      expect(formattedPhone, equals(mockedMaskedPhoneWithoutDash));
    });

    testWidgets('should format phone correctly', (WidgetTester tester) async {
      await fillFormField(
        tester: tester,
        text: mockedUnsmaskedPhone,
        page: phonePage,
      );

      expect(controller.text, isNotEmpty);
      expect(controller.text, equals(mockedPhone));
    });
  });

  group('get numbers only tests', () {
    test('should get only numbers', () {
      var formattedString = formatter.getNumbersOnly(mockedPhone);
      expect(formattedString, equals(mockedUnsmaskedPhone));

      formattedString =
          formatter.getNumbersOnly('1dAC@56515avam;0]ccsd#~çef-%8');
      expect(formattedString, equals('15651508'));
    });
  });
}
