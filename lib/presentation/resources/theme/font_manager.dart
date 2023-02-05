part of 'theme_manager.dart';

TextTheme _textTheme() => TextTheme(
      headlineLarge: GoogleFonts.notoSansArabic(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: ColorManager.blackColor),
      headlineMedium: GoogleFonts.notoSansArabic(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ColorManager.blackColor),
      headlineSmall: GoogleFonts.notoSansArabic(
          fontSize: 16,
          fontWeight: FontWeight.w200,
          color: ColorManager.darkGrey),
      // till here
      displayLarge: GoogleFonts.notoSansArabic(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: ColorManager.darkColor),
      displayMedium: GoogleFonts.notoSansArabic(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: ColorManager.whiteColor),
      displaySmall: GoogleFonts.notoSansArabic(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: ColorManager.darkColor),
      bodySmall: GoogleFonts.notoSansArabic(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: ColorManager.darkGrey),
      titleMedium: GoogleFonts.notoSansArabic(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: ColorManager.whiteColor),
      titleSmall: GoogleFonts.notoSansArabic(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: ColorManager.mainColor),
      labelLarge:
          GoogleFonts.notoSansArabic(fontSize: 22, fontWeight: FontWeight.w500),
      labelSmall: GoogleFonts.notoSansArabic(
          fontSize: 14.sp, fontWeight: FontWeight.w500),
    );
