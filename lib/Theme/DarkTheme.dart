import 'package:flutter/material.dart';

class DarkTheme {
  ThemeData get theme =>
      ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF202023),
        primaryColorLight: Color(0xFFe5e3d8),
        canvasColor: Color(0xFF3A6EA5),
        scaffoldBackgroundColor: Color(0xFF202023),
        hoverColor: Color(0xFF2c3a47),
        primaryColorDark: Color(0xFF2e2e33),
        cardColor: Color(0xFF2e2e33),
        disabledColor: Color(0xFF3A87D1)
      );

}
