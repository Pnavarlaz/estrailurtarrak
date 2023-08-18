import 'package:flutter/material.dart';

// MAIN COLORS
const Color _mainColorPurple = Color(0xFF9747FF);
const Color _mainColorBlue = Color(0xFF00DADA);

const List<Color> _colorThemes = [
  _mainColorPurple,
  _mainColorBlue
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert((selectedColor < _colorThemes.length) && (selectedColor >= 0),
            'Colors must be between 0 and ${_colorThemes.length - 1}');

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
    );
  }
  
}
