import 'package:flutter/cupertino.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  // Device orientation
  static late bool isPortrait;
  static late bool isLandscape;

  // Safe area values
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double safeAreaHorizontal;
  static late double safeAreaVertical;

  // Reference screen size (design mockup size)
  static const double designWidth = 375.0; // iPhone X width used in design mockups
  static const double designHeight = 812.0; // iPhone X height used in design mockups

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    isPortrait = _mediaQueryData.orientation == Orientation.portrait;
    isLandscape = _mediaQueryData.orientation == Orientation.landscape;

    // Calculate blocks
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    // Calculate safe area
    safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;
  }
}
