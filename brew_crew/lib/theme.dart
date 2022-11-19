import 'package:flutter/material.dart';

 var themeBrew= ThemeData(
    scaffoldBackgroundColor: Colors.brown[50],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.brown[400],
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.brown[400]),
        foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
   floatingActionButtonTheme: FloatingActionButtonThemeData(
     backgroundColor: Colors.brown[400],
     elevation: 0,
   )
);
