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
      test("basic path test", () async {
        final screenTwoTestText = find.byValueKey('secondScreenTest');
        final screenTwoButton = find.byValueKey("secondScreenButtonTest");
        final mainScreenText = find.byValueKey("mainScreenText");
        final mainScreenBudgetText = find.byValueKey("budgetText");
        final mainScreenButton = find.byValueKey("mainScreenButton");
        final mainScreenButtonText = find.byValueKey("buttonText");

        expect(await driver.getText(screenTwoTestText), "Test Screen");
        await driver.tap(screenTwoButton);

        expect(await driver.getText(mainScreenText), "Test Screen");
        expect(await driver.getText(mainScreenButtonText), "Test");
        expect(await driver.getText(mainScreenBudgetText),
            "User Budget\n\$${500}");
        //await driver.tap(mainScreenButton);
      });

      test("template test", () async {
        final testVariable = find.byValueKey('templateKey');
        expect(await driver.getText(testVariable), "Template");
      }, skip: true);
    });
  });
}
