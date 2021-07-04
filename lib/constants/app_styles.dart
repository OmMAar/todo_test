import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/constants/app_config.dart';
import 'package:morphosis_flutter_demo/constants/app_font_size.dart';

class AppStyles {
  AppStyles._();

  static TextStyle get defaultTextStyle => TextStyle(
        fontSize: AppFontSize.text_14,
      );

  static TextStyle get text40Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_40,
      );

  static TextStyle get text35Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_35,
      );

  static TextStyle get text29Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_29,
      );

  static TextStyle get text26Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_26,
      );

  static TextStyle get text23Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_23,
      );

  static TextStyle get text20Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_20,
      );

  static TextStyle get text17Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_17,
      );

  static TextStyle get text14Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_14,
      );

  static TextStyle get text11Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_11,
      );

  static TextStyle get text9Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_9,
      );

  static TextStyle get text7Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_7,
      );

  static TextStyle get text5Style => AppConfigs.baseFont.copyWith(
        fontSize: AppFontSize.text_5,
      );
}
