
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transit_app/Config/dark_theme_preference.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DarkThemePreference', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('saves and loads dark theme', () async {
      final themePref = DarkThemePreference();
      await themePref.setDarkTheme(true);
      final result = await themePref.getTheme();
      expect(result, true);
    });

    test('default theme is false', () async {
      final themePref = DarkThemePreference();
      final result = await themePref.getTheme();
      expect(result, false);
    });
  });
}
