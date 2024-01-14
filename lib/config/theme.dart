import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeData = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.nunitoSansTextTheme(),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.indigo,
    accentColor: Colors.yellowAccent,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
