import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

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
    });

    test("ACCOUNT SIGN IN", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("sign_in_input_email"));
      await driver.enterText("lucileremigy@gmail.com");
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("sign_in_input_pw"));
      await driver.enterText("lucile");
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("sign_in_button"));
      sleep(const Duration(seconds: 2));
    });

    /*test("ACCOUNT SIGN UP", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("go_to_sign_up_page"));
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("sign_up_input_first_name"));
      await driver.enterText("Mathis");
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("sign_up_input_last_name"));
      await driver.enterText("Debochie");
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("sign_up_input_email"));
      await driver.enterText("MathisD@gmail.com");
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("sign_up_input_pw"));
      await driver.enterText("MathisD");
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("sign_up_button"));
      sleep(const Duration(seconds: 2));
    });*/

    // HOME PAGE
    test("HOME PAGE SEARCH FUNCTION BY P", () async {
      sleep(const Duration(seconds: 10));
      await driver.tap(find.byValueKey("home_input_search"));
      await driver.enterText("p");
      sleep(const Duration(seconds: 5));
    });

    test("HOME PAGE SEARCH FUNCTION BY PL", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("home_input_search"));
      await driver.enterText("pl");
      sleep(const Duration(seconds: 5));
    });

    test("HOME PAGE WITHOUT SEARCH", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("home_input_search"));
      await driver.enterText("");
      sleep(const Duration(seconds: 5));
    });

    test("HOME PAGE SORT BY KM", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("km_sort_button"));
      sleep(const Duration(seconds: 5));
    });

    test("HOME PAGE SORT BY DATE", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("date_sort_button"));
      sleep(const Duration(seconds: 5));
    });

    /*test("NAVIGATE TO ADD VEHICULE PAGE AND ADD VEHICULE WITH CAMERA",
        () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("go_to_add_vehicule_page"));
      sleep(const Duration(seconds: 5));
      await driver.tap(find.byValueKey("add_image_button"));
      sleep(const Duration(seconds: 5));
      await driver.tap(find.byValueKey("camera_button"));
      sleep(const Duration(seconds: 5));
      await driver.tap(find.byValueKey("turn_camera_button"));
      sleep(const Duration(seconds: 5));
      await driver.tap(find.byValueKey("take_picture_button"));
      sleep(const Duration(seconds: 5));
      await driver.tap(find.byValueKey("add_vehicule_input_name"));
      await driver.enterText("test_camera");
      sleep(const Duration(seconds: 5));
      await driver.tap(find.byValueKey("add_vehicule_input_km"));
      await driver.enterText("125");
      sleep(const Duration(seconds: 5));
      await driver.tap(find.byValueKey("add_vehicule_input_km"));
      await driver.enterText("125");
      sleep(const Duration(seconds: 5));
      await driver.tap(find.byValueKey("add_vehicule_input_date"));
      await driver.enterText("09/08/1996");
      await driver.tap(find.byValueKey("add_vehicule_button"));
      sleep(const Duration(seconds: 5));
    });*/

    test("GO TO STAT", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("nav_bar_stat"));
      sleep(const Duration(seconds: 2));
    });

    test("GO TO PROFILE", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("nav_bar_profil"));
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("go_to_modif_profile"));
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("modif_profile_input_first_name"));
      await driver.enterText("Hesna");
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("modif_profile_input_last_name"));
      await driver.enterText("Cailliau");
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("modif_profile_save_button"));
    });

    /*test("GO TO DELETE MY ACCOUNT", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("nav_bar_profil"));
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("go_to_delete_account"));
    });*/

    test("GO TO ADMIN", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("nav_bar_admin"));
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("text delete_button"));
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("Selim up_admin_button"));
      sleep(const Duration(seconds: 2));
    });

    test("GO TO VEHICULE", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("nav_bar_vehicule"));
      sleep(const Duration(seconds: 2));
    });

    test("GO TO DISCONNECT", () async {
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("nav_bar_profil"));
      sleep(const Duration(seconds: 2));
      await driver.tap(find.byValueKey("go_to_disconnect"));
    });
  });
}
