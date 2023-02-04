import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

part "color_manager.dart";
part "font_manager.dart";

ThemeData lightThemeData = ThemeData(
  appBarTheme: AppBarTheme(
      color: ColorManager.whiteColor,
      iconTheme:
          IconThemeData(color: ColorManager.darkRed.withOpacity(0.8), size: 28),
      titleTextStyle: GoogleFonts.acme(
          fontWeight: FontWeight.w600,
          color: ColorManager.whiteColor.withOpacity(0.8),
          fontSize: 22),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white.withOpacity(0),
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showUnselectedLabels: true,
    selectedIconTheme: const IconThemeData(color: ColorManager.mainColor),
    backgroundColor: Colors.transparent,
    selectedLabelStyle:
        GoogleFonts.notoSansArabic(fontWeight: FontWeight.bold, fontSize: 12),
    unselectedLabelStyle:
        GoogleFonts.notoSansArabic(fontWeight: FontWeight.bold, fontSize: 12),
    elevation: 0,
    unselectedItemColor: ColorManager.lightGrey,
    selectedItemColor: ColorManager.mainColor,
  ),
  dividerColor: ColorManager.mainColor.withOpacity(0.4),
  splashFactory: InkRipple.splashFactory,
  scaffoldBackgroundColor: ColorManager.whiteColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorManager.whiteColor,
    foregroundColor: ColorManager.darkGrey,
  ),
  primaryTextTheme: _textTheme(),
  primaryColor: ColorManager.mainColor,
  iconTheme:
      IconThemeData(color: ColorManager.whiteColor.withOpacity(0.8), size: 30),
  primaryColorDark: ColorManager.mainColor,
  primaryColorLight: ColorManager.mainColor,
  listTileTheme: ListTileThemeData(
    tileColor: ColorManager.whiteColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    textStyle: MaterialStateProperty.all(_textTheme().displayMedium),
    foregroundColor: MaterialStateProperty.all(ColorManager.darkWhite),
  )),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(ColorManager.mainColor),
    fixedSize: MaterialStateProperty.all(const Size(120, 30)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    )),
    textStyle: MaterialStateProperty.all(_textTheme().displayMedium),
    foregroundColor: MaterialStateProperty.all(ColorManager.darkWhite),
  )),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    side: MaterialStateBorderSide.resolveWith((states) =>
        BorderSide(color: Colors.grey.withOpacity(0.4), width: 2.0)),
    foregroundColor: MaterialStateProperty.all(ColorManager.mainColor),
  )),
  textTheme: _textTheme(),
  colorScheme: const ColorScheme(
    primary: ColorManager.darkColor, // used
    background: ColorManager.whiteColor, // used
    onSurface: ColorManager.mainColor, // used
    onBackground: ColorManager.darkGrey, // used
    onSecondary: ColorManager.lightGrey, // used
    onPrimary: ColorManager.darkWhite, // used
    secondary: ColorManager.lightColor, //used

    surface: ColorManager.blackColor,
    error: ColorManager.darkRed,
    onError: ColorManager.lightRed,
    brightness: Brightness.light,
  ),
);
