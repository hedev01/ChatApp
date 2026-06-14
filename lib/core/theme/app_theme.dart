import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15))
        ),
        textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        backgroundColor: WidgetStatePropertyAll(
          AppColors.lightbackgroundButtonColor,
        ),
        foregroundColor: WidgetStatePropertyAll(AppColors.lightBackground),
      ),
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0XFFFFFFFF),
      hintStyle: TextStyle(color: Color(0XFFACADB9)),
      contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),

    fontFamily: "Poppins SemiBold",
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(),
    fontFamily: "Poppins SemiBold",
  );
}
