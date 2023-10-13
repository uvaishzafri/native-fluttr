// Made for FlexColorScheme version 7.0.1. Make sure you
// use same or higher package version, but still same major version.
// If you use a lower version, some properties may not be supported.
// In that case remove them after copying this theme to your app.

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final _appThemeDataLight = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xffBE94C6),
    primaryContainer: Color(0xffffffff),
    secondary: Color(0xff7BC6CC),
    secondaryContainer: Color(0xffff8738),
    tertiary: Color(0xffa5a7b3),
    tertiaryContainer: Color(0x0D7B7B7B),
    appBarColor: Color(0xffff8738),
    error: Color(0xffb00020),
  ),
  subThemesData: const FlexSubThemesData(
    interactionEffects: false,
    tintedDisabledControls: false,
    blendOnColors: false,
    inputDecoratorBorderType: FlexInputBorderType.underline,
    inputDecoratorUnfocusedBorderIsColored: false,
    tooltipRadius: 4,
    tooltipSchemeColor: SchemeColor.inverseSurface,
    tooltipOpacity: 0.9,
    snackBarElevation: 6,
    snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedLabel: false,
    navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedIcon: false,
    navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationBarIndicatorOpacity: 1.00,
    navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedLabel: false,
    navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedIcon: false,
    navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationRailIndicatorOpacity: 1.00,
    navigationRailBackgroundSchemeColor: SchemeColor.surface,
    navigationRailLabelType: NavigationRailLabelType.none,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the playground font, add GoogleFonts package and uncomment
  fontFamily: 'Poppins',
  // fontFamily: GoogleFonts.poppins().fontFamily,
).copyWith(
  splashFactory: InkSplash.splashFactory,
  splashColor: const Color(0xffBE94C6),
);

final _appThemeDataDark = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xff9fc9ff),
    primaryContainer: Color(0xff00325b),
    secondary: Color(0xffffb59d),
    secondaryContainer: Color(0xff872100),
    tertiary: Color(0xff86d2e1),
    tertiaryContainer: Color(0xff004e59),
    appBarColor: Color(0xff872100),
    error: Color(0x0dcf6679),
  ),
  subThemesData: const FlexSubThemesData(
    interactionEffects: false,
    tintedDisabledControls: false,
    inputDecoratorBorderType: FlexInputBorderType.underline,
    inputDecoratorUnfocusedBorderIsColored: false,
    tooltipRadius: 4,
    tooltipSchemeColor: SchemeColor.inverseSurface,
    tooltipOpacity: 0.9,
    snackBarElevation: 6,
    snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedLabel: false,
    navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedIcon: false,
    navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationBarIndicatorOpacity: 1.00,
    navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedLabel: false,
    navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedIcon: false,
    navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationRailIndicatorOpacity: 1.00,
    navigationRailBackgroundSchemeColor: SchemeColor.surface,
    navigationRailLabelType: NavigationRailLabelType.none,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.poppins().fontFamily,
).copyWith(
  splashFactory: InkSplash.splashFactory,
  splashColor: const Color(0x0dBE94C6),
);

ThemeData getThemeData(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return _appThemeDataLight;
    case ThemeMode.dark:
      return _appThemeDataDark;
    default:
      return _appThemeDataLight;
  }
}

SystemUiOverlayStyle createOverlayStyle({
  required Brightness brightness,
  required Color primaryColor,
}) {
  final isDark = brightness == Brightness.dark;

  return SystemUiOverlayStyle(
    systemNavigationBarColor: primaryColor,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
  );
}
