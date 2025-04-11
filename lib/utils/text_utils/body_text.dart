import 'package:flutter/material.dart';
import 'package:material_portfolio/theme/text_style.dart';

// Body Text - Standard
Text bodyText(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return Text(
    text,
    style: AppTextStyles.bodyText.copyWith(
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
Text bodyTextBold({String text = '', Color? color, double? fontSize}) {
  return bodyText(
    text,
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
  );
}

// Body Text - Italic
Text bodyTextItalic({String text = '', Color? color, double? fontSize}) {
  return Text(
    text,
    style: AppTextStyles.bodyText.copyWith(
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
Text bodyTextLight({String text = '', Color? color, double? fontSize}) {
  return bodyText(
    text,
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w300,
  );
}

// Body Text - Small (For captions or smaller text)
Text bodyTextSmall({String text = '', Color? color, double? fontSize}) {
  return bodyText(
    text,
    color: color ?? Colors.black54,
    fontSize: fontSize ?? 14.0,
  );
}

// Body Text - Medium (Normal weight)
Text bodyTextMedium({String text = '', Color? color, double? fontSize}) {
  return bodyText(
    text,
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
  );
}
