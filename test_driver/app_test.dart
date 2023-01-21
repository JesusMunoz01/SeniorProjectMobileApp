import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Grocery Application', () {
    final mainText = find.byValueKey('main');
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    group("Template", () {
      test("template test", () async {
        final testVariable = find.byValueKey('templateKey');
        final templateVar = "Template";
        expect(templateVar, "Template");
      });

      test("template test", () async {
        final testVariable = find.byValueKey('templateKey');
        expect(await driver.getText(testVariable), "Template");
      }, skip: true);
    });
  });
}
