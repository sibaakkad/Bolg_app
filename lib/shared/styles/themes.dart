import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  // primarySwatch: defaultColor,
  scaffoldBackgroundColor: defaultColorBlack,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarColor: HexColor('333739'),
    //   statusBarIconBrightness: Brightness.light,

    // ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: defaultColorBlack,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: defaultColorBlack,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: defaultColorWhite,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -1,
    ),
    iconTheme: IconThemeData(
      color: defaultColorWhite,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColorBlack,
    unselectedItemColor: Colors.grey,
    elevation: 10.0,
    // backgroundColor: HexColor('333739'),
    backgroundColor: defaultColorBlack,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: defaultColorWhite,
    ),
  ),
  fontFamily: 'Montserrat',
  iconTheme: const IconThemeData(color: defaultColorBlue),
);

ThemeData lightTheme = ThemeData(
  // primarySwatch: defaultColor,
  scaffoldBackgroundColor: const Color.fromRGBO(252, 252, 253, 1),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Color.fromRGBO(252, 252, 253, 1),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: defaultColorBlack,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
      letterSpacing: -1,
    ),
    iconTheme: IconThemeData(
      color: defaultColorBlack,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColorBlack,
    unselectedItemColor: defaultColorGrey,
    selectedIconTheme: IconThemeData(color: defaultColorBlack),
    // unselectedIconTheme: IconThemeData(color: ),
    elevation: 10.0,
    backgroundColor: defaultColorWhite,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: defaultColorBlack,
      letterSpacing: -1,
    ),
  ),
  fontFamily: 'Montserrat',
  iconTheme: const IconThemeData(color: defaultColorBlue),
);
