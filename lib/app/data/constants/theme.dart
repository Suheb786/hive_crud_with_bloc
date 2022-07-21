import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData Themes() {
  return ThemeData(
    textTheme: ThemeData.dark().textTheme.copyWith(
          headline3: const TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
  );
}
