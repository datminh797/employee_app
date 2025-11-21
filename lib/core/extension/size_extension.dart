import '../utils/size_config.dart';

extension ResponsiveSizeExtension on double {
  // --------------------- width ---------------------
  double w() {
    double percentage = (this / SizeConfig.designWidth) * 100;
    return percentage * SizeConfig.blockSizeHorizontal;
  }

  // --------------------- height ---------------------
  double h() {
    double percentage = (this / SizeConfig.designHeight) * 100;
    return percentage * SizeConfig.blockSizeVertical;
  }

  // --------------------- scale ---------------------
  double sp() {
    double scaleFactor = SizeConfig.isPortrait
        ? SizeConfig.screenWidth / SizeConfig.designWidth
        : SizeConfig.screenHeight / SizeConfig.designHeight;
    return this * scaleFactor;
  }

  // --------------------- border radius ---------------------
  double r() {
    double scaleFactor = SizeConfig.screenWidth < SizeConfig.screenHeight
        ? SizeConfig.screenWidth / SizeConfig.designWidth
        : SizeConfig.screenHeight / SizeConfig.designHeight;
    return this * scaleFactor;
  }

  // --------------------- padding/margin ---------------------
  double a() {
    double scaleFactor = SizeConfig.screenWidth < SizeConfig.designWidth ? 0.8 : 1.0;
    return this * scaleFactor;
  }
}
