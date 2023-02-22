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
        final createAccText = find.byValueKey("createAccText");
        final createAccButton = find.byValueKey("createAccButton");
        final screenTwoLoginBox = find.byValueKey("usernameText");
        final screenTwoPasswordBox = find.byValueKey("passwordText");
        final screenTwoLoginButton = find.byValueKey("loginButton");
        final screenTwoLoginTextButton = find.byValueKey("loginTextButton");
        final usernameField = find.byValueKey("usernameTextField");
        final passwordField = find.byValueKey("passwordTextField");

        final mainScreenText = find.byValueKey("mainScreenText");
        final mainScreenBudgetText = find.byValueKey("budgetText");
        final mainScreenButton = find.byValueKey("mainScreenButton");
        final mainScreenButtonText = find.byValueKey("buttonText");

        expect(await driver.getText(screenTwoTestText), "Login");
        expect(await driver.getText(screenTwoLoginBox), "Username");
        expect(await driver.getText(screenTwoPasswordBox), "Password");
        expect(await driver.getText(screenTwoLoginTextButton), "Login");
        expect(await driver.getText(createAccText), "Create an Account");

        await driver.tap(usernameField);
        await driver.enterText("TestAccount");
        await driver.tap(passwordField);
        await driver.enterText("TestPassword");
        await driver.tap(screenTwoLoginButton);
        //await driver.tap(createAccButton);

        expect(await driver.getText(mainScreenText), "Recommended");
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
