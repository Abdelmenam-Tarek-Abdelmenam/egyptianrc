part of 'theme_manager.dart';

TextTheme _textTheme(bool dark) => TextTheme(
      displayLarge: GoogleFonts.poppins(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: dark ? ColorManager.whiteColor : ColorManager.darkBlue),
      displayMedium: GoogleFonts.alegreyaSans(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: dark ? ColorManager.whiteColor : ColorManager.whiteColor),
      displaySmall: GoogleFonts.alegreyaSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: dark ? ColorManager.mainBlue : ColorManager.darkBlue),
      headlineMedium: GoogleFonts.alegreyaSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: dark ? ColorManager.lightGrey : ColorManager.lightGrey),
      bodySmall: GoogleFonts.alegreyaSans(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: dark ? ColorManager.whiteColor : ColorManager.darkGrey),
      titleMedium: GoogleFonts.alegreyaSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: dark ? ColorManager.whiteColor : ColorManager.whiteColor),
      titleSmall: GoogleFonts.alegreyaSans(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: dark ? ColorManager.lightBlue : ColorManager.mainBlue),
      labelLarge:
          GoogleFonts.alegreyaSans(fontSize: 22, fontWeight: FontWeight.w500),
      labelSmall: GoogleFonts.alegreyaSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          color: dark ? ColorManager.blackColor : ColorManager.blackColor),
    );
