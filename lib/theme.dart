import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  primaryColor: const Color.fromARGB(255, 0, 132, 255),
  dividerColor: const Color.fromARGB(21, 198, 234, 250),
  primaryTextTheme: TextTheme(
    // Section Headings
    headline1: GoogleFonts.montserrat(
        color:const Color.fromARGB(255, 233, 252, 249),
        fontSize: 22,
        fontWeight: FontWeight.bold),

    // List Font
    bodyText1: GoogleFonts.montserrat(
        color: const Color.fromARGB(255, 17, 17, 19),
         fontSize: 20 ,
        //  fontWeight: FontWeight.w500
         ),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: const Color.fromARGB(255, 39, 53, 243)),
);

ThemeData dark = ThemeData(
    primaryColor: const Color.fromRGBO(31, 31, 31, 1.0),
    dividerColor: const Color.fromARGB(24, 46, 41, 41),
    primaryTextTheme: TextTheme(
      // Section Headings
      headline1: GoogleFonts.montserrat(
          color: const Color.fromARGB(255, 233, 252, 249),
          fontSize: 22,
          fontWeight: FontWeight.bold),

      // List Font
      bodyText1: GoogleFonts.montserrat(
          color: const Color.fromARGB(255, 102, 102, 102), fontSize: 16),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color.fromRGBO(200, 200, 200, 1)));

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  // ignore: prefer_typing_uninitialized_variables
  var _prefs;
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  getSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ThemeNotifier() {
    _isDarkTheme = false;
    _getThemPref();
  }

  // Switch theme
  toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _setThemePrefs();
    notifyListeners();
  }

  // Get saved theme preference
  _getThemPref() async {
    await _initPrefs();
    _isDarkTheme = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  // Set theme preference
  _setThemePrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _isDarkTheme);
  }

  // Initiate a preference
  _initPrefs() async {
    // ignore: prefer_conditional_assignment
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }
}
