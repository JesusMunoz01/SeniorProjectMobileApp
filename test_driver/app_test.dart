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

    group("Valid Paths", () {
      test("Basic path test (all screens)", () async {
        // Login Screen Section
        final screenTwoTestText = find.byValueKey('secondScreenTest');
        final screenTwoLoginBox = find.byValueKey("usernameText");
        final screenTwoPasswordBox = find.byValueKey("passwordText");
        final screenTwoLoginButton = find.byValueKey("loginButton");
        final screenTwoLoginTextButton = find.byValueKey("loginTextButton");
        final usernameField = find.byValueKey("usernameTextField");
        final passwordField = find.byValueKey("passwordTextField");
        final createAccText = find.byValueKey("createAccText");
        final createAccButton = find.byValueKey("createAccButton");

        // Create Account Screen
        final createAccBackButton = find.byValueKey("createAccBack");
        final createAccScreenText = find.byValueKey("createAccScreenText");
        final createUsernameFieldTxt = find.byValueKey("createAccUsernameText");
        final createPasswordFieldTxt = find.byValueKey("createAccPasswordText");
        final submitText = find.byValueKey("submitAccTextButton");
        final submitButton = find.byValueKey("submitAccButton");

        // Main Screen (Home tab)
        final mainScreenText = find.byValueKey("favoriteText");
        final mainScreenBudgetText = find.byValueKey("budgetText");
        final mainScreenButton = find.byValueKey("mainScreenButton");
        final mainScreenButtonText = find.byValueKey("buttonText");
        final homeTab = find.byValueKey('homeTab');
        final itemsTab = find.byValueKey('itemsTab');
        final mealTab = find.byValueKey('mealTab');

        // Items Screen (Items tab)
        final itemsScreenText = find.byValueKey("itemsMainText");
        final itemsScreenButton = find.byValueKey("itemsScreenButton");
        final itemsButtonText = find.byValueKey("itemsButtonText");

        // Search section
        final searchButton = find.byValueKey("searchButton");
        final searchBack = find.byValueKey("returnSearch");

        // Settings
        final personalText = find.byValueKey("personalText");
        final settingsText = find.byValueKey("settingsText");
        final budgetText = find.byValueKey("budgetTextSet");
        final logoutText = find.byValueKey("logoutText");
        final deleteText = find.byValueKey("deleteText");
        final settingsButton = find.byValueKey("settingsButton");
        final logoutButton = find.byValueKey("logoutButton");

        // Check login screen and use test account for logging to the app
        //expect(await driver.getText(screenTwoTestText), "Login");
        expect(await driver.getText(screenTwoLoginBox), "Username");
        expect(await driver.getText(screenTwoPasswordBox), "Password");
        expect(await driver.getText(screenTwoLoginTextButton), "Login");
        expect(await driver.getText(createAccText), "Create an Account");

        // Move to create account, check info, move back
        await driver.tap(createAccButton);
        expect(await driver.getText(createAccScreenText), "Create \nNew \nAccount!!!");
        expect(await driver.getText(createUsernameFieldTxt), "Username");
        expect(await driver.getText(createPasswordFieldTxt), "Password");
        expect(await driver.getText(submitText), "Create Account");
        await driver.tap(submitButton);
        await driver.tap(createAccBackButton);

        // Back in Login Screen, Log in with test account
        await driver.tap(usernameField);
        await driver.enterText("TestAccount");
        await driver.tap(passwordField);
        await driver.enterText("TestPassword");
        await driver.tap(screenTwoLoginButton);

        // Main screen section
        expect(await driver.getText(mainScreenText), "Favorites");
        expect(await driver.getText(mainScreenButtonText), "Confirm");
        expect(await driver.getText(mainScreenBudgetText),
            "User Budget\n\$0.00/\$50000.0");
        
        await driver.tap(mainScreenButton);
        await driver.tap(itemsTab);

        // Items screen section
        expect(await driver.getText(itemsScreenText), "Items");
        expect(await driver.getText(itemsButtonText), "Confirm");

        // Search section
        await driver.tap(searchButton);
        await driver.tap(searchBack);

        // Settings section
        await driver.tap(settingsButton);

        expect(await driver.getText(settingsText), "Settings");
        expect(await driver.getText(personalText), "Personal Info");
        expect(await driver.getText(budgetText), "Budget");
        expect(await driver.getText(logoutText), "Logout");
        expect(await driver.getText(deleteText), "Delete Account");

        await driver.tap(logoutText);
        
      } ,);

      // Not Logged in path
      test("Create account, move screens, and delete account", () async {
        // Login Screen Section
        final screenTwoTestText = find.byValueKey('secondScreenTest');
        final screenTwoLoginBox = find.byValueKey("usernameText");
        final screenTwoPasswordBox = find.byValueKey("passwordText");
        final screenTwoLoginButton = find.byValueKey("loginButton");
        final screenTwoLoginTextButton = find.byValueKey("loginTextButton");
        final usernameField = find.byValueKey("usernameTextField");
        final passwordField = find.byValueKey("passwordTextField");
        final createAccText = find.byValueKey("createAccText");
        final createAccButton = find.byValueKey("createAccButton");

        // Create Account Screen
        final createAccScreenText = find.byValueKey("createAccScreenText");
        final createUsernameFieldTxt = find.byValueKey("createAccUsernameText");
        final createPasswordFieldTxt = find.byValueKey("createAccPasswordText");
        final createUsernameField = find.byValueKey("createAccUsernameField");
        final createPasswordField = find.byValueKey("createAccPasswordField");
        final submitText = find.byValueKey("submitAccTextButton");
        final submitButton = find.byValueKey("submitAccButton");

        // Info Screen
        final nameField = find.byValueKey("nameTextField");
        final nameText = find.byValueKey("nameText");
        final nameButton = find.byValueKey("nameButton");
        final ageField = find.byValueKey("ageTextField");
        final ageText = find.byValueKey("ageText");
        final ageButton = find.byValueKey("ageButton");
        final sexField = find.byValueKey("sexTextField");
        final sexText = find.byValueKey("sexText");
        final sexButton = find.byValueKey("sexButton");
        final weightField = find.byValueKey("weightTextField");
        final weightText = find.byValueKey("weightText");
        final weightButton = find.byValueKey("weightButton");
        final heightField = find.byValueKey("heightTextField");
        final heightText = find.byValueKey("heightText");
        final heightButton = find.byValueKey("heightButton");
        final budgetField = find.byValueKey("budgetTextField");
        final budgetText = find.byValueKey("budgetText");
        final budgetButton = find.byValueKey("budgetButton");
        final option2 = find.byValueKey("option2");
        final timeText = find.byValueKey("timeFrameText");
        final timeButton = find.byValueKey("timeFrameButton");

        // Main Screen (Home tab)
        final mainScreenText = find.byValueKey("favoriteText");
        final mainScreenBudgetText = find.byValueKey("budgetText");
        final mainScreenButton = find.byValueKey("mainScreenButton");
        final mainScreenButtonText = find.byValueKey("buttonText");
        final homeTab = find.byValueKey('homeTab');
        final itemsTab = find.byValueKey('itemsTab');
        final mealTab = find.byValueKey('mealTab');

        // Items Screen (Items tab)
        final itemsScreenText = find.byValueKey("itemsMainText");
        final itemsScreenButton = find.byValueKey("itemsScreenButton");
        final itemsButtonText = find.byValueKey("itemsButtonText");
        final itemsAdd0 = find.byValueKey("itemAdd0");

        // Search section
        final searchButton = find.byValueKey("searchButton");
        final searchBack = find.byValueKey("returnSearch");

        // Settings
        final settingsButton = find.byValueKey("settingsButton");
        final deleteButton = find.byValueKey("deleteButton");

        // Check login screen and use test account for logging to the app
        //expect(await driver.getText(screenTwoTestText), "Login");
        expect(await driver.getText(screenTwoLoginBox), "Username");
        expect(await driver.getText(screenTwoPasswordBox), "Password");
        expect(await driver.getText(screenTwoLoginTextButton), "Login");
        expect(await driver.getText(createAccText), "Create an Account");

        // Move to create account, enter info, submit
        await driver.tap(createAccButton);
        expect(await driver.getText(createAccScreenText), "Create \nNew \nAccount!!!");
        expect(await driver.getText(createUsernameFieldTxt), "Username");
        expect(await driver.getText(createPasswordFieldTxt), "Password");
        expect(await driver.getText(submitText), "Create Account");

        await driver.tap(createUsernameField);
        await driver.enterText("TestAccount3");
        await driver.tap(createPasswordField);
        await driver.enterText("TestPassword3");
        await driver.tap(submitButton);

        // Back in Login Screen, Log in with new test account
        await driver.tap(usernameField);
        await driver.enterText("TestAccount3");
        await driver.tap(passwordField);
        await driver.enterText("TestPassword3");
        await driver.tap(screenTwoLoginButton);

        // First login, enter info screen before main screen
        expect(await driver.getText(nameText), "Enter Your Name");
        await driver.tap(nameField);
        await driver.enterText("Tester");
        await driver.tap(nameButton);

        expect(await driver.getText(ageText), "Enter Your Age");
        await driver.tap(ageField);
        await driver.enterText("21");
        await driver.tap(ageButton);

        expect(await driver.getText(sexText), "Enter Your Sex");
        await driver.tap(sexField);
        await driver.enterText("Male");
        await driver.tap(sexButton);

        expect(await driver.getText(weightText), "Enter Your Weight");
        await driver.tap(weightField);
        await driver.enterText("160");
        await driver.tap(weightButton);

        expect(await driver.getText(heightText), "Enter Your Height");
        await driver.tap(heightField);
        await driver.enterText("5'11");
        await driver.tap(heightButton);

        expect(await driver.getText(budgetText), "Enter Your Budget");
        await driver.tap(budgetField);
        await driver.enterText("5000");
        await driver.tap(budgetButton);

        expect(await driver.getText(timeText), "Select Your Time Frame");
        await driver.tap(option2);
        await driver.enterText("Monthly");
        await driver.tap(timeButton);


        // Main screen section
        expect(await driver.getText(mainScreenText), "Favorites");
        expect(await driver.getText(mainScreenButtonText), "Confirm");
        expect(await driver.getText(mainScreenBudgetText),
            "User Budget\n\$0.00/\$5000.0");

        // Move to items, add the first item and confirm

        await driver.tap(mainScreenButton);
        await driver.tap(itemsTab);
        await driver.tap(itemsAdd0);
        await driver.tap(itemsScreenButton);

        // Move back to main screen and check updated price

        expect(await driver.getText(mainScreenBudgetText),
            "User Budget\n\$4.20/\$5000.0");

        // Go to settings and delete account
        await driver.tap(settingsButton);
        await driver.tap(deleteButton);
      },);
    });
  });
}
