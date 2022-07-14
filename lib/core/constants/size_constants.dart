import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/color_constants.dart';

double screenWidth = 0;
double screenHeight = 0;
double blockSizeHorizontal = 0;
double blockSizeVertical = 0;

double bottomPadding = 0;
double topPadding = 0;

double basicFontSize = 0;
FontWeight basicFontWeight = FontWeight.normal;
FontWeight basicFontWeight2 = FontWeight.bold;

double contentHeaderFontSize = 0;
FontWeight contentHeaderFontWeight = FontWeight.bold;

double bottomTabBarHeight = 0;

TextStyle navbarInactiveTitleTextStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: LIGHT_COLOR,
);

TextStyle tabbarActiveTitleTextStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.normal,
  color: LIGHT_COLOR,
);

TextStyle getBasicTextStyle({required Color color}) {
  return TextStyle(
    fontSize: basicFontSize,
    fontWeight: basicFontWeight,
    color: color,
  );
}

TextStyle getBasicTextStyle2({required Color color}) {
  return TextStyle(
    fontSize: basicFontSize,
    fontWeight: basicFontWeight2,
    color: color,
  );
}

TextStyle getContentHeaderTextStyle({required Color color}) {
  return TextStyle(
    fontSize: contentHeaderFontSize,
    fontWeight: contentHeaderFontWeight,
    color: color,
  );
}

TextStyle contentHeaderTextStyle = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: MAIN_GREEN,
);

TextStyle contentHeaderTextStyleBig = const TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: MAIN_GREEN,
);

TextStyle smokingCountText = const TextStyle(
  fontSize: 60,
  fontWeight: FontWeight.bold,
  color: LIGHT_COLOR,
);

TextStyle smokingDataText = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.normal,
  color: LIGHT_COLOR,
);

TextStyle balanceDataText = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: LIGHT_COLOR,
);

TextStyle balanceText = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: LIGHT_COLOR,
);

TextStyle cardTitleText = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: LIGHT_COLOR,
);

void sizeConfigInit(BuildContext context) {
  final MediaQueryData _mq = MediaQuery.of(context);
  screenWidth = _mq.size.width;
  screenHeight = _mq.size.height;
  blockSizeHorizontal = screenWidth / 100;
  blockSizeVertical = screenHeight / 100;

  bottomPadding = _mq.padding.bottom;
  topPadding = _mq.padding.top;

  bottomTabBarHeight = blockSizeVertical * 10;
}
