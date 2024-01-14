import 'package:flutter/material.dart';

extension ThemeExt on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get color => Theme.of(this).colorScheme;
}
