import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/styles.dart';
import 'bloc/theme_cubit.dart';
import 'colors.dart';

bool isDarkTheme(BuildContext context) {
  final themeState = context.read<ThemeCubit>().state;
  final theme = themeState.appliedTheme;

  if (theme == 'Light') {
    return false;
  } else if (theme == 'Dark') {
    return true;
  } else {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }
}

/// Creates light and dark [ThemeData].
class AppTheme {
  /// Light theme
  late ThemeData lightTheme;

  /// Dark theme
  late ThemeData darkTheme;

  /// Constructs an [AppTheme].
  AppTheme() {
    lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryGreen,
      scaffoldBackgroundColor: AppColors.primaryBackground,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      shadowColor: Colors.grey.shade100,
      fontFamily: Styles.fontFAMILY,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          disabledForegroundColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.black,
          ),
          elevation: 0,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: Colors.black,
          ),
          elevation: 0,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryGreen;
          }
          return Colors.grey;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return AppColors.primaryGreen;
          }
          return Colors.transparent;
        }),
      ),
      tabBarTheme: TabBarThemeData(
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.black,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.primaryBackground,
        elevation: 2,
        shadowColor: Colors.grey.shade100,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
          fontFamily: Styles.fontFAMILY,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          color: Colors.black,
          fontFamily: Styles.fontFAMILY,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.0,
        ),
      ),
    );

    darkTheme = ThemeData(  
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryGreen.withAlpha((0.25 * 255).toInt()),
      scaffoldBackgroundColor: AppColors.accentElement,
      // splashColor: Colors.transparent,
      // highlightColor: Colors.transparent,
      shadowColor: Colors.grey.shade900,
      fontFamily: Styles.fontFAMILY,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          disabledForegroundColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: Styles.fontFAMILY,
            fontSize: 13.sp,
            color: Colors.white,
          ),
          elevation: 0,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: Colors.white,
          ),
          elevation: 0,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryGreen;
          }
          return Colors.grey;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return AppColors.primaryGreen;
          }
          return Colors.transparent;
        }),
      ),
      tabBarTheme: TabBarThemeData(
        unselectedLabelColor: Colors.blueGrey.withValues(alpha: 0.5),
        labelColor: Colors.grey.shade100,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.accentText,
        elevation: 2,
        shadowColor: Colors.grey.shade900,
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: Colors.white,
          fontFamily: Styles.fontFAMILY,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
          fontFamily: Styles.fontFAMILY,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
          fontFamily: Styles.fontFAMILY,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.0,
        ),
      ),
    );
  }

  /// returns app current theme depending on if [isDarkMode] is ```true``` or otherwise
  ThemeData? themeData({required bool isDarkModeOn}) {
    return isDarkModeOn ? darkTheme : lightTheme;
  }
}
