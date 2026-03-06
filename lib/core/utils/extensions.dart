import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'date_utils.dart';

extension StringExtension on String {
  SubstringHighlight toText(
      {bool translate = true,
      FontWeight fontWeight = FontWeight.w400,
      double fontSize = 14,
      double textHeight = 27.45 / 14.0,
      Color? color,
      TextDecoration? decoration,
      TextAlign? textAlign,
      FontStyle? fontStyle,
      TextOverflow? textOverflow,
      String? searchTerm = ''}) {
    return SubstringHighlight(
      text: translate ? this.tr() : this, // each string needing highlighting
      term: searchTerm,
      caseSensitive: false, // user typed "m4a"
      overflow: textOverflow ?? TextOverflow.visible,
      textStyle: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: fontWeight,
          height: textHeight,
          decoration: decoration ?? TextDecoration.none,
          fontSize: fontSize.sp,
          fontStyle: fontStyle,
          color: color ?? const Color(0xff0A0D14),
          overflow: textOverflow ?? TextOverflow.visible),
      textStyleHighlight: const TextStyle(
        // highlight style
        color: Colors.red,
        decoration: TextDecoration.underline,
      ),
    );
    // return Text(
    //   translate ? this.tr() : this,
    //   textAlign: textAlign,
    //   style: TextStyle(
    //       fontFamily: 'Sora',
    //       fontWeight: fontWeight,
    //       height: textHeight,
    //       decoration: decoration ?? TextDecoration.none,
    //       fontSize: fontSize.sp,
    //       fontStyle: fontStyle,
    //       color: color,
    //       overflow: textOverflow ?? TextOverflow.visible),
    // );
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  SvgPicture toSvg({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/vectors/$this.svg',
      width: width,
      height: height,
      // ignore: deprecated_member_use
      color: color,
      fit: fit ?? BoxFit.contain,
    );
  }

  Image pngPicture({
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Image.asset(
      'assets/images/$this',
      width: width,
      height: height,
      fit: fit,
    );
  }

  String readableDateTime(Locale locale) {
    if (isEmpty) return "";
    return DateFormat('d MMM y hh:mm aa', locale.languageCode)
        .format(DateTime.parse(this));
  }
}

String currentDateTime() {
  var now = DateTime.now();
  String formattedDate = DateAndTimeUtil.serverDateFormat.format(now);
  return formattedDate;
}

extension NumExtension on num {
  String format() {
    return NumberFormat("#,##0.##").format(this);
  }

  String currencyFormat() {
    final format = NumberFormat.currency(locale: "en_NG", symbol: "₦");
    return "₦${format.format(this).replaceAll("₦", "").trim()}";
  }
}
