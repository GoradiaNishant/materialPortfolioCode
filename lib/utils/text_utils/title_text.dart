import 'package:flutter/material.dart';
import 'package:material_portfolio/theme/text_style.dart';

// Body Text - Standard
Text titleText(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return Text(
    text,
    style: AppTextStyles.heading1.copyWith(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    ),
    textHeightBehavior: TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    ),
  );
}

// Body Text - Bold
Text titleTextBold({String text = '', Color? color, double? fontSize}) {
  return titleText(
    text,
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
  );
}

// Body Text - Italic
Text titleTextItalic({String text = '', Color? color, double? fontSize}) {
  return Text(
    text,
    style: AppTextStyles.heading1.copyWith(
      fontSize: fontSize,
      fontStyle: FontStyle.italic,
      color: color,
    ),
    textHeightBehavior: TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    ),
  );
}

// Body Text - Light
Text titleTextLight({String text = '', Color? color, double? fontSize}) {
  return titleText(
    text,
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w300,
  );
}

// Body Text - Small (For captions or smaller text)
Text titleTextSmall({String text = '', Color? color, double? fontSize}) {
  return titleText(
    text,
    fontSize: fontSize ?? 14.0,
  );
}

// Body Text - Medium (Normal weight)
Text titleTextMedium({String text = '', Color? color, double? fontSize}) {
  return titleText(
    text,
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
  );
}
