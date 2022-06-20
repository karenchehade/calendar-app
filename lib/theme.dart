import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  primaryColor:Color.fromARGB(255, 4, 127, 250),
  dividerColor: Color.fromARGB(22, 227, 244, 252),
  primaryTextTheme: TextTheme(
    // Section Headings
    headline1: GoogleFonts.montserrat(
        color: Color.fromARGB(255, 12, 16, 58),
        fontSize: 22,
        fontWeight: FontWeight.bold),

    // List Font
    bodyText1: GoogleFonts.montserrat(
        color:Color.fromARGB(255, 192, 218, 213), fontSize: 16),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color.fromARGB(255, 87, 175, 247)),
);

ThemeData dark = ThemeData(
    primaryColor: const Color.fromRGBO(31, 31, 31, 1.0),
    dividerColor:const Color.fromRGBO(200, 200, 200, 0.1),
    primaryTextTheme: TextTheme(
        // Section Headings
        headline1: GoogleFonts.montserrat(
            color:const Color.fromRGBO(250, 250, 250, 1),
            fontSize: 22,
            fontWeight: FontWeight.bold),

        // List Font
        bodyText1: GoogleFonts.montserrat(
            color:const Color.fromRGBO(200, 200, 200, 1), fontSize: 16),

        
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color.fromRGBO(200, 200, 200, 1)));

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  // ignore: prefer_typing_uninitialized_variables
  var _prefs ;
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

getSharedPreferences () async
{
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