import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String _sharedPreferencesKey = 'isDark';
final isDarkModeProvider = StateProvider<bool?>((ref) => false);

class ThemeVM {
  getCurrentTheme(WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? getBool = prefs.getBool(_sharedPreferencesKey);
    ref.read(isDarkModeProvider.notifier).update((state) => getBool);
  }

  Future onThemeChaged(String key, bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
}
