import 'package:flutter/material.dart';

const Map<String, String> myIcons = {
  'Favorite': 'assets/icons/Combined-Shape.svg',
  'BookMark': 'assets/icons/Vector.svg',
  'Dot': 'assets/icons/Dot.svg',
  'Categoris': 'assets/icons/Document.svg',
  'Profile': 'assets/icons/Profile.svg',
  'Settings': 'assets/icons/Setting.svg',
  'Home': 'assets/icons/Home.svg',
};

ThemeMode convertToThemeMode(int themeNumber) {
  switch (themeNumber) {
    case 0:
      {
        return ThemeMode.system;
      }
    case 1:
      {
        return ThemeMode.light;
      }

    default:
      {
        return ThemeMode.dark;
      }
  }
}

int convertToThemeNumber(ThemeMode themeData) {
  switch (themeData) {
    case ThemeMode.system:
      {
        return 0;
      }
    case ThemeMode.light:
      {
        return 1;
      }

    default:
      {
        return 2;
      }
  }
}

String token = '';
bool isAuth = false;
