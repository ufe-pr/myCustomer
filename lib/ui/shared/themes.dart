import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_text_style.dart';

import 'const_color.dart';

ThemeData primaryMaterialTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
      color: ThemeColors.background,
      textTheme: TextTheme(
        headline6: kheadingText,
        bodyText2: bodyTextStyle(FontWeight.normal),
      )),
  bottomAppBarTheme: BottomAppBarTheme(
    color: ThemeColors.primary,
    elevation: 0,
  ),
  backgroundColor: ThemeColors.background,
  textTheme: TextTheme(
      headline1: TextStyle().copyWith(fontFamily: 'Lato'),
      headline2: TextStyle().copyWith(fontFamily: 'Lato'),
      headline4: TextStyle().copyWith(fontFamily: 'Lato'),
      headline3: TextStyle().copyWith(fontFamily: 'Lato'),
      bodyText2: TextStyle().copyWith(fontFamily: 'Lato'),
      bodyText1: TextStyle().copyWith(fontFamily: 'Lato'),
      headline5: TextStyle().copyWith(fontFamily: 'Lato'),
      headline6: TextStyle().copyWith(fontFamily: 'Lato'),
      caption: TextStyle().copyWith(fontFamily: 'Lato'),
      button: TextStyle().copyWith(fontFamily: 'Lato'),
      overline: TextStyle().copyWith(fontFamily: 'Lato')),
  bottomAppBarColor: ThemeColors.primary,
  cursorColor: ThemeColors.black,
  hintColor: const Color.fromARGB(60, 25, 25, 25),
  buttonTheme: ButtonThemeData(
    buttonColor: ThemeColors.primary,
    focusColor: ThemeColors.primary.withOpacity(0.5),
  ),
  iconTheme: IconThemeData(
    color: BrandColors.secondary,
  ),
  accentIconTheme: IconThemeData(
    color: ThemeColors.gray[800],
  ),
  buttonColor: BrandColors.primary,
  textSelectionColor: BrandColors.primary,
);

ThemeData darkMaterialTheme = ThemeData(
  scaffoldBackgroundColor: ThemeColors.black,
  brightness: Brightness.dark,
  backgroundColor: ThemeColors.black,
  cursorColor: ThemeColors.background,
  textSelectionColor: ThemeColors.link,
  textTheme: TextTheme(
      headline1: TextStyle().copyWith(fontFamily: 'Lato'),
      headline2: TextStyle().copyWith(fontFamily: 'Lato'),
      headline4: TextStyle().copyWith(fontFamily: 'Lato'),
      headline3: TextStyle().copyWith(fontFamily: 'Lato'),
      bodyText2: TextStyle().copyWith(fontFamily: 'Lato'),
      bodyText1: TextStyle().copyWith(fontFamily: 'Lato'),
      headline5: TextStyle().copyWith(fontFamily: 'Lato'),
      headline6: TextStyle().copyWith(fontFamily: 'Lato'),
      caption: TextStyle().copyWith(fontFamily: 'Lato'),
      button: TextStyle().copyWith(fontFamily: 'Lato'),
      overline: TextStyle().copyWith(fontFamily: 'Lato'))
);


// final _lightThemeData = ThemeData.light();
// final _darkThemeData = Brightness.dark;

// /// Light Theme
// final primaryMaterialTheme = _lightThemeData.copyWith(
//   textTheme: _lightThemeData.textTheme.apply(
//     fontFamily: 'Lato',
//   ),
//   backgroundColor: ThemeColors.background,
//   bottomAppBarColor: ThemeColors.primary,
//   cursorColor: ThemeColors.black,
//   hintColor: const Color.fromARGB(60, 25, 25, 25),
//   bottomAppBarTheme: _lightThemeData.bottomAppBarTheme.copyWith(
//     color: ThemeColors.primary,
//     elevation: 0,
//   ),
//   buttonTheme: _lightThemeData.buttonTheme.copyWith(
//     buttonColor: ThemeColors.primary,
//     focusColor: ThemeColors.primary.withOpacity(0.5),
//   ),
//   appBarTheme: _lightThemeData.appBarTheme.copyWith(
//     color: ThemeColors.background,
//     textTheme: TextTheme(
//       headline6: kheadingText,
//       bodyText2: bodyTextStyle(FontWeight.normal),
//     ),
//     iconTheme: IconThemeData(
//       color: ThemeColors.black,
//     ),
//   ),
//   iconTheme: _lightThemeData.iconTheme.copyWith(
//     color: BrandColors.secondary,
//   ),
//   accentIconTheme: _lightThemeData.accentIconTheme.copyWith(
//     color: ThemeColors.gray[800],
//   ),
// );

// /// Dark Theme
// // final darkMaterialTheme = _darkThemeData.copyWith(
// //   textTheme: _darkThemeData.textTheme.apply(
// //     fontFamily: 'Lato',
// //   ),
// //   appBarTheme: _lightThemeData.appBarTheme.copyWith(
// //     textTheme: TextTheme(
// //       headline6: kheadingText,
// //       bodyText2: bodyTextStyle(FontWeight.normal),
// //     ),
// //     iconTheme: IconThemeData(
// //       color: ThemeColors.background,
// //     ),
// //   ),
// //   iconTheme: _lightThemeData.iconTheme.copyWith(color: ThemeColors.background),
// //   accentIconTheme: _lightThemeData.accentIconTheme.copyWith(
// //     color: ThemeColors.gray[800],
// //   ),
// // );

// final darkMaterialTheme = ThemeData(
//   primaryColor: ThemeColors.black,
//   brightness: Brightness.dark,
//   fontFamily: 'Lato',
//   appBarTheme: _lightThemeData.appBarTheme.copyWith(
//     textTheme: TextTheme(
//       headline6: kheadingText,
//       bodyText2: bodyTextStyle(FontWeight.normal),
//     ),
//     iconTheme: IconThemeData(
//       color: ThemeColors.background,
//     ),
//   ),
//   iconTheme: _lightThemeData.iconTheme.copyWith(color: ThemeColors.background),
//   accentIconTheme: _lightThemeData.accentIconTheme.copyWith(
//     color: ThemeColors.gray[800],
//   ),
// );

/// Cupertino Theme Data
final primaryCupertinoTheme = CupertinoThemeData(
  primaryColor: CupertinoDynamicColor.withBrightness(
    color: Color(0xFF333CC1),
    darkColor: Colors.cyan,
  ),
);
