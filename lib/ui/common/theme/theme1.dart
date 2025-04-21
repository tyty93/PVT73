import "package:flutter/material.dart";

class MaterialTheme {
  MaterialTheme._();

  static ThemeData lightTheme = light();
  static ThemeData darkTheme = dark();

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xffcac3ff),
      surfaceTint: Color(0xff5c559e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffada5f4),
      onPrimaryContainer: Color(0xff3f387e),
      secondary: Color(0xff5e5b79),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe1dbff),
      onSecondaryContainer: Color(0xff635f7e),
      tertiary: Color(0xff00647d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff007f9d),
      onTertiaryContainer: Color(0xfffafdff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffcf8ff),
      onSurface: Color(0xff1c1b20),
      onSurfaceVariant: Color(0xff474550),
      outline: Color(0xff787581),
      outlineVariant: Color(0xffc9c4d2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313035),
      inversePrimary: Color(0xffc6bfff),
      primaryFixed: Color(0xffe4dfff),
      onPrimaryFixed: Color(0xff180b57),
      primaryFixedDim: Color(0xffc6bfff),
      onPrimaryFixedVariant: Color(0xff443d84),
      secondaryFixed: Color(0xffe4dfff),
      onSecondaryFixed: Color(0xff1b1833),
      secondaryFixedDim: Color(0xffc8c2e6),
      onSecondaryFixedVariant: Color(0xff464360),
      tertiaryFixed: Color(0xffb8eaff),
      onTertiaryFixed: Color(0xff001f28),
      tertiaryFixedDim: Color(0xff77d2f3),
      onTertiaryFixedVariant: Color(0xff004d61),
      surfaceDim: Color(0xffddd8df),
      surfaceBright: Color(0xfffcf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f2f9),
      surfaceContainer: Color(0xfff1ecf3),
      surfaceContainerHigh: Color(0xffebe7ee),
      surfaceContainerHighest: Color(0xffe5e1e8),
    );
  }

  static ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff5c559e),
      surfaceTint: Color(0xffc6bfff),
      onPrimary: Color(0xff2e256c),
      primaryContainer: Color(0xffada5f4),
      onPrimaryContainer: Color(0xff3f387e),
      secondary: Color(0xffc8c2e6),
      onSecondary: Color(0xff302d49),
      secondaryContainer: Color(0xff464360),
      onSecondaryContainer: Color(0xffb6b1d4),
      tertiary: Color(0xff77d2f3),
      onTertiary: Color(0xff003544),
      tertiaryContainer: Color(0xff007f9d),
      onTertiaryContainer: Color(0xfffafdff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141318),
      onSurface: Color(0xffe5e1e8),
      onSurfaceVariant: Color(0xffc9c4d2),
      outline: Color(0xff928f9b),
      outlineVariant: Color(0xff474550),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e1e8),
      inversePrimary: Color(0xff5c559e),
      primaryFixed: Color(0xffe4dfff),
      onPrimaryFixed: Color(0xff180b57),
      primaryFixedDim: Color(0xffc6bfff),
      onPrimaryFixedVariant: Color(0xff443d84),
      secondaryFixed: Color(0xffe4dfff),
      onSecondaryFixed: Color(0xff1b1833),
      secondaryFixedDim: Color(0xffc8c2e6),
      onSecondaryFixedVariant: Color(0xff464360),
      tertiaryFixed: Color(0xffb8eaff),
      onTertiaryFixed: Color(0xff001f28),
      tertiaryFixedDim: Color(0xff77d2f3),
      onTertiaryFixedVariant: Color(0xff004d61),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff3a383e),
      surfaceContainerLowest: Color(0xff0e0e12),
      surfaceContainerLow: Color(0xff1c1b20),
      surfaceContainer: Color(0xff201f24),
      surfaceContainerHigh: Color(0xff2a292e),
      surfaceContainerHighest: Color(0xff353439),
    );
  }

  static ThemeData dark() {
    return theme(darkScheme());
  }

  static ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );
}
