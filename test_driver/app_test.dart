import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart' hide find;

void main() {
  group('Flutter driver test App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      await driver.close();
    });
    test("check health", () async {
      final Health health = await driver.checkHealth();
      print(health.status);
    });

    //  ACCOUNT SIGN UP
    test("ACCOUNT SIGN UP", () async {
      sleep(Duration(seconds: 2));
      await driver
          .tap(find.byValueKey("registerButton")); // changement de screen
      sleep(Duration(seconds: 2));

      await driver.tap(find.byValueKey("emailEntry"));
      await driver.enterText("lucile.remigy@epitech.eu");
      sleep(Duration(seconds: 2));

      await driver.tap(find.byValueKey("firstNameEntry"));
      await driver.enterText("Lucile");
      sleep(Duration(seconds: 2));

      await driver.tap(find.byValueKey("lastNameEntry"));
      await driver.enterText("Remigy");
      sleep(Duration(seconds: 2));

      await driver.tap(find.byValueKey("passwordEntry"));
      await driver.enterText("SM");
      sleep(Duration(seconds: 2));

      await driver.tap(find.byValueKey("validationButton"));
      sleep(Duration(seconds: 2));

      await driver.tap(find.byValueKey("backButtonRegister"));
      sleep(Duration(seconds: 2));
    });

    // FORGET PASSWORD
    test("FORGET PASSWORD", () async {
      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("loginButton"));
      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("forgetPassword"));
      await driver.tap(find.byValueKey("emailPasswordForget"));
      await driver.enterText("lucile.remigy@epitech.eu");

      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("validationPasswordForget"));
      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("backButtonForgetPassword"));
      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("arrowBack"));
      sleep(Duration(seconds: 2));
    });

    // ACCOUNT SIGN IN
    test("ACCOUNT SIGN IN", () async {
      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("loginButton"));
      await driver.tap(find.byValueKey("emailEntry"));
      await driver.enterText("lucile.remigy@epitech.eu");

      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("passwordEntry"));
      await driver.enterText("SM");
      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("validationButton"));
      sleep(Duration(seconds: 2));
    });

    // HOME PAGE
    test("HOME PAGE", () async {
      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("dailyConsumption"));
      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("dashboardAlert"));
      sleep(Duration(seconds: 2));
      await driver.tap(find.byValueKey("buttonPlumber"));
      sleep(Duration(seconds: 2));
    });
  });
}
