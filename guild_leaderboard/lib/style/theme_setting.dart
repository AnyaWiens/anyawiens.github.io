

import 'package:flutter/material.dart';
import 'package:guild_leaderboard/style/app_colors.dart';
import 'package:guild_leaderboard/style/text_styles.dart';

final _base = ThemeData.light();
final _baseDark = ThemeData.dark();

final ThemeData lightTheme = _base.copyWith(
  //colors
  scaffoldBackgroundColor: primaryColor,
  primaryColor: primaryColor,
  canvasColor: primaryColor,
  disabledColor: disabledColor,
  focusColor: primaryColor,
  hintColor: textPrimaryColor,
  hoverColor: selectedColor,
  primaryColorDark: darkPrimaryColor,

  //widgets
  elevatedButtonTheme: buttonStyle(),
  inputDecorationTheme: inputTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
  ),
  iconButtonTheme:
      IconButtonThemeData(style: ButtonStyle(foregroundColor: WidgetStateProperty.all<Color>(textPrimaryColor))),
);

final ThemeData darkTheme = _baseDark.copyWith(
  //colors
  scaffoldBackgroundColor: darkBackgroundColor,
  primaryColor: darkPrimaryColor,
  canvasColor: darkPrimaryColor,
  dialogBackgroundColor: darkGrey,
  disabledColor: darkDisabledColor,
  focusColor: darkPrimaryColor,
  hintColor: darkTextPrimaryColor,
  hoverColor: darkSelectedColor,
  indicatorColor: darkSelectedColor,

  //widgets
  elevatedButtonTheme: darkButtonStyle(),
  inputDecorationTheme: darkInputTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: darkPrimaryColor,
  ),
  iconButtonTheme:
      IconButtonThemeData(style: ButtonStyle(foregroundColor: WidgetStateProperty.all<Color>(darkTextPrimaryColor))),
);

//Button Themes
ElevatedButtonThemeData buttonStyle() {
  return ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return mediumGrey;
        }
        return primaryColor;
      },
    ),
    foregroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return darkBackgroundColor;
        }
        return Colors.black;
      },
    ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    )),
  ));
}

ElevatedButtonThemeData darkButtonStyle() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return darkGrey;
          }
          return darkPrimaryColor;
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return mediumGrey;
          }
          return lightGrey;
        },
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      )),
    ),
  );
}

//Input Text Theme
InputDecorationTheme inputTextTheme() {
  return InputDecorationTheme(
    labelStyle: style_body.copyWith(color: darkGrey),
    hintStyle: style_body.copyWith(color: mediumGrey),
    floatingLabelStyle: style_body.copyWith(color: textPrimaryColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: darkGrey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: mediumGrey),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.red),
    ),
  );
}

InputDecorationTheme darkInputTextTheme() {
  return InputDecorationTheme(
    labelStyle: style_body.copyWith(color: lightGrey),
    hintStyle: style_body.copyWith(color: lightGrey),
    floatingLabelStyle: style_body.copyWith(color: darkTextPrimaryColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: lightGrey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: mediumGrey),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.red),
    ),
  );
}
