import 'package:flutter/material.dart';

class AppTypography {
  static const _fontFamily = 'Mulish';

  //Headings
  static const TextStyle heading1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  //Subheading
  static const TextStyle subheading1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 0.6,
  );

  static const TextStyle subheading2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.75,
  );

  //Body
  static const TextStyle body1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.71,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    height: 1.71,
  );

  //Metadata
  static const TextStyle metadata1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    height: 0.6,
  );

  static const TextStyle metadata2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    height: 0.62,
  );
}
