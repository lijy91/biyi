import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _kBlueColor = Color(0xff416ff4);
const _kGreenColor = Color(0xff52c41a);
const _kRedColor = Color(0xfff5222d);
const _kGoldColor = Color(0xfffaad14);

// -------- Colors -----------
const _kPrimaryColor = _kBlueColor;
const _kInfoColor = _kBlueColor;
const _kSuccessColor = _kGreenColor;
const _kErrorColor = _kRedColor;
const _kWarningColor = _kGoldColor;

const _kScaffoldBackgroundColor = const Color(0xff1d1d1d);
const _kCanvasColor = Color(0xff282828);

var darkThemeData = ThemeData(
  brightness: Brightness.dark,
  // VisualDensity? visualDensity,
  // MaterialColor? primarySwatch,
  primaryColor: _kPrimaryColor,
  // Brightness? primaryColorBrightness,
  // Color? primaryColorLight,
  // Color? primaryColorDark,
  // Color? accentColor,
  // Brightness? accentColorBrightness,
  canvasColor: _kCanvasColor,
  // Color? shadowColor,
  scaffoldBackgroundColor: _kScaffoldBackgroundColor,
  // Color? bottomAppBarColor,
  // Color? cardColor,
  // Color? dividerColor,
  // Color? focusColor,
  // Color? hoverColor,
  // Color? highlightColor,
  // Color? splashColor,
  // InteractiveInkFeatureFactory? splashFactory,
  // Color? selectedRowColor,
  // Color? unselectedWidgetColor,
  // Color? disabledColor,
  // Color? buttonColor,
  // ButtonThemeData? buttonTheme,
  // ToggleButtonsThemeData? toggleButtonsTheme,
  // Color? secondaryHeaderColor,
  // Color? backgroundColor,
  dialogBackgroundColor: _kCanvasColor,
  // Color? indicatorColor,
  // Color? hintColor,
  // Color? errorColor,
  // Color? toggleableActiveColor,
  // String? fontFamily,
  textTheme: TextTheme(
    bodyText2: TextStyle(
      fontSize: 14,
    ),
    caption: TextStyle(
      fontSize: 12,
    ),
  ),
  // primaryTextTheme
  // TextTheme? accentTextTheme,
  // InputDecorationTheme? inputDecorationTheme,
  // IconThemeData? iconTheme,
  // IconThemeData? primaryIconTheme,
  // IconThemeData? accentIconTheme,
  // SliderThemeData? sliderTheme,
  // TabBarTheme? tabBarTheme,
  // TooltipThemeData? tooltipTheme,
  // CardTheme? cardTheme,
  // ChipThemeData? chipTheme,
  // TargetPlatform? platform,
  // MaterialTapTargetSize? materialTapTargetSize,
  // bool? applyElevationOverlayColor,
  // PageTransitionsTheme? pageTransitionsTheme,
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    color: _kCanvasColor,
    elevation: 0,
    // this.shadowColor,
    iconTheme: IconThemeData(
      color: Colors.white,
      opacity: 1,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      opacity: 1,
      size: 24,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 15,
    ),
    // this.centerTitle,
    // this.titleSpacing,
  ),
  // BottomAppBarTheme? bottomAppBarTheme,
  // ColorScheme? colorScheme,
  // DialogTheme? dialogTheme,
  // FloatingActionButtonThemeData? floatingActionButtonTheme,
  // NavigationRailThemeData? navigationRailTheme,
  // Typography? typography,
  cupertinoOverrideTheme: CupertinoThemeData(
    primaryColor: _kPrimaryColor,
    barBackgroundColor: _kCanvasColor,
  ),
  // SnackBarThemeData? snackBarTheme,
  // BottomSheetThemeData? bottomSheetTheme,
  // PopupMenuThemeData? popupMenuTheme,
  // MaterialBannerThemeData? bannerTheme,
  // DividerThemeData? dividerTheme,
  // ButtonBarThemeData? buttonBarTheme,
  // BottomNavigationBarThemeData? bottomNavigationBarTheme,
  // TimePickerThemeData? timePickerTheme,
  // TextButtonThemeData? textButtonTheme,
  // ElevatedButtonThemeData? elevatedButtonTheme,
  // OutlinedButtonThemeData? outlinedButtonTheme,
  // TextSelectionThemeData? textSelectionTheme,
  // DataTableThemeData? dataTableTheme,
  // bool? fixTextFieldOutlineLabel,
);
