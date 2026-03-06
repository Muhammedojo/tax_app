// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';

class Styles {
  static const textFormFamily = 'Nunito';
  static const fontFAMILY = textFormFamily;

  static RoundedRectangleBorder roundCornerBorderShape(double radius, Color color) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: BorderSide(color: color),
    );
  }

  static final containerSmallTextStyle = TextStyle(
    fontSize: 12.sp,
    color: AppColors.x848484,
         fontFamily: fontFAMILY,
    fontWeight: FontWeight.w400,
  );
  static final containerBigTextStyle = TextStyle(
    fontSize: 24.sp,
     fontFamily: fontFAMILY,
    color: AppColors.x000000,
    fontWeight: FontWeight.w700,
  );

  static final boldWeightWhiteBiggerTextStyle = TextStyle(
    fontSize: 20.0.sp,
     fontFamily: fontFAMILY,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const boldWeightWhiteBigSizeTextStyle = TextStyle(
    fontSize: 17.0,
     fontFamily: fontFAMILY,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const boldWeightWhiteBiggestTextStyle = TextStyle(
    fontSize: 25.0,
     fontFamily: fontFAMILY,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final normalWeightGreyNormalSizeTextStyle = TextStyle(
    fontSize: 15.0.sp,
    fontFamily: fontFAMILY,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  static const normalWeightGreySmallSizeTextStyle = TextStyle(
    fontSize: 13.0,
     fontFamily: fontFAMILY,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  static const boldWeightGreySmallSizeTextStyle = TextStyle(
    fontSize: 13.0,
     fontFamily: fontFAMILY,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );

  static const normalWeightGreySmallerSizeTextStyle = TextStyle(
    fontSize: 11.0,
     fontFamily: fontFAMILY,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  static const normalWeightWhiteNormalSizeTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static const normalWeightWhiteSmallerSizeTextStyle = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static const buttonWhiteTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static textFormFieldDecoration(
    String hintText,
    String labelText, {
    IconData? iconData,
    String? validationText,
    bool? check,
  }) {
    return InputDecoration(
      border: const UnderlineInputBorder(),
      hintText: hintText,
      labelText: labelText,
      labelStyle: x14dp_A4A9B3(14.0.sp),
      hintStyle: x16dp_textFieldHint(16.0.sp),
      errorText: check != null && check ? validationText : null,
      suffixIcon: iconData != null ? Icon(iconData, size: 20.sp) : null,
    );
  }

  static textFormFieldDecorationNoBorder(
    String hintText,
    String labelText, {
    IconData? iconData,
    String? validationText,
    bool? check,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff111411), width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff111411), width: 1.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff111411), width: 1.w),
      ),
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintText: hintText,
      labelText: labelText,
      labelStyle: normal_000000(14.0.sp),
      hintStyle: normal_000000(12.0.sp),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.only(bottom: 15.sp, left: 15.sp, right: 15.sp),
      errorText: check != null && check ? validationText : null,
      suffixIcon:
          iconData != null
              ? Icon(iconData, size: 20.sp, color: AppColors.x000000_grey)
              : null,
    );
  }

  static textFormFieldDecorationBorderWithBackground(
    String hintText,
    String labelText, {
    IconData? iconData,
    Widget? prefixIconData,
    String? validationText,
    bool? check,
    Function()? onIconPressed,
    bool? showPrefixIcon = false,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        borderSide: BorderSide(color: Color(0xff909190), width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        borderSide: BorderSide(color: Color(0xff088008), width: 1.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        borderSide: BorderSide(color: AppColors.lightGrey, width: 1.5.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        borderSide: BorderSide(color: Color(0xffE93426), width: 1.w),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        borderSide: BorderSide(color: Color(0xff909190), width: 1.w),
      ),
      hintText: hintText,
      fillColor: AppColors.xFFFFFF,
      filled: true,
      labelStyle: x14dp_A4A9B3(12.0.sp),
      hintStyle: x16dp_textFieldHint(14.0.sp),
      errorText: check != null && check ? validationText : null,
      suffixIcon:
          iconData != null
              ? IconButton(
                icon: Icon(iconData, size: 20.sp, color: Color(0xff909190)),
                onPressed: onIconPressed,
              )
              : null,
      prefix:
          showPrefixIcon != null && showPrefixIcon
              ? prefixIconData
              //  Container(
              //   width: 20.sp,
              //   height: 20.sp,
              //   margin: REdgeInsets.only(right: 4),
              //   alignment: Alignment.center,
              //   child: CircularProgressIndicator(
              //     strokeWidth: 2,
              //     color: Color(0xff909190),
              //   ),
              // )
              : null,
    );
  }

  static boxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 0, style: BorderStyle.none),
      color: AppColors.xF3F3F5,
      borderRadius: BorderRadius.circular(3.r),
    );
  }

  static amountFormFieldDecoration(
    String hintText,
    String labelText, {
    String? validationText,
    bool? check,
  }) {
    return InputDecoration(
      //border: InputBorder.none,
      border: UnderlineInputBorder(),
      hintText: hintText,
      labelText: labelText,
      //labelStyle: x14dp_9B9B9B(12.0)
      labelStyle: x24dp_404040(24.0.sp),
      hintStyle: x16dp_textFieldHint(16.0.sp),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SvgPicture.asset(
          'assets/images/naira.svg',
          width: 7.w,
          height: 7.h,
          fit: BoxFit.fill,
        ),
      ),
      errorText: check != null && check ? validationText : null,
      contentPadding: EdgeInsets.only(bottom: 15.0),
    );
  }

  static dropdownFormFieldDecoration(
    String hintText,
    String labelText, {
    String? validationText,
    bool? check,
  }) {
    return InputDecoration(
      isDense: true,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      isCollapsed: false,
      //hasFloatingPlaceholder: true,
      labelText: labelText,
      labelStyle: x14dp_A4A9B3(14.0.sp),
      hintStyle: x16dp_textFieldHint(16.0.sp),
      border: UnderlineInputBorder(),
      hintText: hintText,
      errorText: check != null && check ? validationText : null,
      contentPadding: EdgeInsets.only(bottom: 10.0.sp),
    );
  }

  static textFormFieldDecorationNoBorderWithBackground(
    String hintText,
    String labelText, {
    IconData? iconData,
    String? validationText,
    bool? check,
    Function()? onIconPressed,
    bool showPrefixIcon = false,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff909190), width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff088008), width: 1.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff909190), width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffE93426), width: 1.w),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff909190), width: 1.w),
      ),
      hintText: hintText,
      fillColor: AppColors.xF3F3F5,
      filled: true,
      labelStyle: x14dp_A4A9B3(14.0.sp),
      hintStyle: x16dp_textFieldHint(14.0.sp),
      errorText: check != null && check ? validationText : null,
      suffixIcon:
          iconData != null
              ? IconButton(
                icon: Icon(iconData, size: 20.sp, color: Color(0xff909190)),
                onPressed: onIconPressed,
              )
              : null,
      prefix:
          showPrefixIcon
              ? Container(
                width: 20.sp,
                height: 20.sp,
                margin: EdgeInsets.only(right: 4.sp),
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.colorPrimary,
                ),
              )
              : null,
    );
  }

  static dropdownFormFieldDecorationNoBorderWithBackground(
    String hintText,
    String labelText, {
    String? validationText,
    bool? check,
  }) {
    return InputDecoration(
      labelStyle: x14dp_A4A9B3(14.0.sp),
      hintStyle: x16dp_textFieldHint(16.0.sp),
      //border: UnderlineInputBorder(),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0.r),
        borderSide: BorderSide(width: 0, style: BorderStyle.none),
      ),
      fillColor: AppColors.xF3F3F5,
      filled: true,
      hintText: hintText,
      errorText: check != null && check ? validationText : null,
      contentPadding: EdgeInsets.symmetric(
        vertical: 18.0.sp,
        horizontal: 10.0.sp,
      ),
    );
  }

  static passwordFieldDecoration(
    String hintText,
    String labelText,
    bool obscurePassword,
    Function() onPasswordVisible, {
    String? validationText,
    bool? check,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff909190), width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff088008), width: 1.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGrey, width: 1.5.w),
      ),
      hintText: hintText,
      labelText: '*** **** ***',
      labelStyle: x14dp_A4A9B3(14.0.sp),
      hintStyle: x16dp_textFieldHint(12.0.sp),
      counterStyle: x16dp_textFieldHint(16.0.sp),
      errorText: check != null && check ? validationText : null,
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword ? Icons.visibility_off : Icons.visibility,
          size: 20.sp,
          color: AppColors.ColorAccent,
        ),
        onPressed: onPasswordVisible,
      ),
    );
  }

  static csdFieldDecoration(
    String hintText,
    String labelText,
    Function onRemoveCsd, {
    String? validationText,
    bool? check,
  }) {
    return InputDecoration(
      border: UnderlineInputBorder(),
      hintText: hintText,
      labelText: labelText,
      labelStyle: x14dp_A4A9B3(14.0.sp),
      hintStyle: x16dp_textFieldHint(16.0.sp),
      errorText: check != null && check ? validationText : null,
      suffixIcon: IconButton(
        icon: Icon(
          // Based on passwordVisible state choose the icon
          Icons.remove_circle,
          size: 20.sp,
          color: AppColors.xD61A0D,
        ),
        onPressed: () {},
      ),
    );
  }

  static searchFieldBorderlessDecoration(
    String hintText,
    String labelText, {
    Color? color,
  }) {
    return InputDecoration(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: color ?? Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color ?? Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color ?? Colors.white),
      ),
      hintText: hintText,
      labelText: labelText,
      //labelStyle: Styles.x16dp_FFFFF(16.0),
      //counterStyle: Styles.x16dp_FFFFF(16.0),
      //hintStyle: TextStyle(fontSize: 18.0, fontWeight: Fonts.regular, fontStyle: FontStyle.normal, fontFamily: textFormFamily, color: AppColors.xFFFFFF),
      prefixIcon: RotatedBox(
        quarterTurns: 3,
        child: Icon(
          //LineAwesomeIcons.search,
          Icons.search,
          color: color ?? Colors.white,
          size: 20.sp,
        ),
      ),
    );
  }

  static searchFieldBorderlessDecorationIcon(String hintText, {Color? color}) {
    return InputDecoration(
      prefixIcon: Icon(Icons.search, color: color, size: 20.0.sp),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: color ?? AppColors.xC7C7CC),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color ?? AppColors.xC7C7CC),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color ?? AppColors.xC7C7CC),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: textFormFamily,
        color: color,
        fontSize: 16.sp,
      ),
    );
  }

  static textFormFieldDecorationWithIconAttachment(
    String hintText,
    String labelText,
  ) {
    return InputDecoration(
      border: UnderlineInputBorder(),
      icon: Icon(Icons.attach_file, color: Colors.grey, size: 20.sp),
      hintMaxLines: null,
      hintText: hintText,
      labelText: labelText,
      //labelStyle: x18dp_regular_141A22,
      hintStyle: x10dp_regular_6E7F8D(10.sp),
    );
  }

  static TextStyle oval_dark_button_style(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: const Color(0xffffffff),
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  static TextStyle oval_dark_button_style_bold(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: const Color(0xffffffff),
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static TextStyle oval_view_button_style(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: Color(0xff111411), //AppColors.xC4C4C4,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static const TextStyle ovalRedButtonStyle = TextStyle();
  static TextStyle oval_green_button_style(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle oval_bordered_button_style(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x52965E,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle oval_bordered_open_trade_button_style(double fontsize) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.xD0D0D0,
        height: 1.5,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      );
  static TextStyle oval_market_button_style(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x848484,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  static TextStyle x24dp_bold_4A4A4A(double fontsize) => TextStyle(
    fontFamily: fontFAMILY,
    fontSize: fontsize,
    color: AppColors.x4A4A4A,
    fontWeight: FontWeight.w400,
    height: 1.16,
    fontStyle: FontStyle.normal,
  );
  static TextStyle normal_000000(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x000000,
    fontWeight: FontWeight.w400,
    height: 1.16,
    fontStyle: FontStyle.normal,
  );
  static TextStyle normal_54565B_07(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x54565B_07,
    fontWeight: FontWeight.w400,
    height: 1.16,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x18dp_bold_404040(double fontsize) => TextStyle(
    fontFamily: fontFAMILY,
    fontSize: fontsize,
    color: AppColors.x404040,
    fontWeight: FontWeight.w400,
    height: 1.16,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x18dp_bold_404040_text(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x404040,
    fontWeight: FontWeight.bold,
    height: 1.16,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x32dp_bold_FFFFFF(double fontsize) => TextStyle(
    fontFamily: fontFAMILY,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x24dp_4A4A4A(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x4A4A4A,
    fontWeight: FontWeight.w400,
    height: 1.28,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x17dp_000000(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x000000,
    fontWeight: FontWeight.w600,
    height: 1.28,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x16dp_4A4A4A(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x4A4A4A,
    fontWeight: FontWeight.w600,
    height: 1.28,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x16dp_4A4A4A_2(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x4A4A4A,
    fontWeight: FontWeight.w400,
    height: 1.28,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x16dp_A4A9B3(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xA4A9B3,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_A4A9B3(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xA4A9B3,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x16dp_textFieldHint(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xTextFieldHint,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_4A4A4A(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x4A4A4A,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );

  static TextStyle x14dp_green(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x54565B_07,
    fontWeight: FontWeight.w600,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );

  static TextStyle x14dp_red(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xD61A0D,
    fontWeight: FontWeight.w600,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );

  static TextStyle x14dp_404040(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x404040,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );

  static TextStyle x11dp_404040(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x404040,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x16dp_bold_404040(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x404040,
    fontWeight: FontWeight.w700,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_bold_404040(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x404040,
    fontWeight: FontWeight.w700,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_bold_D61A0D(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xD61A0D,
    fontWeight: FontWeight.w700,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x16dp_404040(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x404040,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x12dp_404040(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x404040,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x24dp_404040(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x404040,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_heavy_404040(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x404040,
    fontWeight: FontWeight.w600,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x12dp_heavy_FFFFFF(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w600,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x18dp_4A4A4A(double fontsize) => TextStyle(
    fontFamily: fontFAMILY,
    fontSize: fontsize,
    color: AppColors.x4A4A4A,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x18dp_4A4A4A_2(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x4A4A4A,
    fontWeight: FontWeight.w700,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x18dp_4A4A4A_light(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x4A4A4A,
    fontWeight: FontWeight.w300,
    height: 1.3,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_D61A0D(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xD61A0D,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_D0D0D0(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xD0D0D0,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_ACACAC(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xACACAC,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x10dp_ACACAC(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xACACAC,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x10dp_9B9B9B(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x9B9B9B,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_52965E(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x52965E,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x8dp_848484(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x848484,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x28dp_D61A0D(double fontsize) => TextStyle(
    fontFamily: fontFAMILY,
    fontSize: fontsize,
    color: AppColors.xD61A0D,
    fontWeight: FontWeight.w400,
    height: 1.28,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x28dp_FFFFFF(double fontsize) => TextStyle(
    fontFamily: fontFAMILY,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w400,
    height: 1.28,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x22dp_D61A0D(double fontsize) => TextStyle(
    fontFamily: fontFAMILY,
    fontSize: fontsize,
    color: AppColors.xD61A0D,
    fontWeight: FontWeight.w400,
    height: 1.28,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_B9B9B9(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xB9B9B9,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w400,
    height: 2.14,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_9B9B9B(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xB9B9B9,
    fontWeight: FontWeight.w400,
    height: 2.14,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_FC5D68(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFC5D68,
    fontWeight: FontWeight.w400,
    height: 1.16,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x18dp_9B9B9B(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xB9B9B9,
    fontWeight: FontWeight.w400,
    height: 2.14,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x18dp_D81600(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xD81600,
    fontWeight: FontWeight.w400,
    height: 2.14,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x16dp_FFFFF(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w400,
    height: 1.16,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x16dp_medium_FFFFF(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w500,
    height: 1.16,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x16dp_bold_FFFFF(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w600,
    height: 1.16,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x16dp_bold_000000(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x000000,
    fontWeight: FontWeight.w600,
    height: 1.16,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_FFFFFF(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w300,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x18dp_FFFFFF(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w300,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x18dp_bold_FFFFFF(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w700,
    height: 1.5,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x22dp_bold_FFFFF(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x10dp_regular_6E7F8D(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x6E7F8D,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x10dp_light_FFFFFF(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x12dp_light_FFFFFF(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.xFFFFFF,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x14dp_light_505154(double fontsize) => TextStyle(
    fontFamily: textFormFamily,
    fontSize: fontsize,
    color: AppColors.x505154,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
  );
  static TextStyle x12dp_9B9B9B(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.x9B9B9B,
        fontWeight: FontWeight.w400,
        height: 1.3,
        fontStyle: FontStyle.normal,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.x9B9B9B,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle x12dp_B9B9B9(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.xB9B9B9,
        fontWeight: FontWeight.w300,
        height: 1.3,
        fontStyle: FontStyle.normal,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.x9B9B9B,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle x12dp_D61A0D(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.xD61A0D,
        fontWeight: FontWeight.w300,
        height: 1.3,
        fontStyle: FontStyle.normal,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.x9B9B9B,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle x12dp_D81600(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.xD81600,
        fontWeight: FontWeight.w300,
        height: 1.3,
        fontStyle: FontStyle.normal,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.x9B9B9B,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle x16dp_D81600(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.xD81600,
        fontWeight: FontWeight.w300,
        height: 1.3,
        fontStyle: FontStyle.normal,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.x9B9B9B,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle x16dp_52965E(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.x52965E,
        fontWeight: FontWeight.w300,
        height: 1.3,
        fontStyle: FontStyle.normal,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.x9B9B9B,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle x12dp_52965E(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.x52965E,
        fontWeight: FontWeight.w300,
        height: 1.3,
        fontStyle: FontStyle.normal,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.x9B9B9B,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle x12dp_ACACAC(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.xACACAC,
        fontWeight: FontWeight.w300,
        height: 1.3,
        fontStyle: FontStyle.normal,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.x9B9B9B,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle x12dp_italic_ACACAC(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.xACACAC,
        fontWeight: FontWeight.w300,
        height: 1.3,
        fontStyle: FontStyle.italic,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.x9B9B9B,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle x20dp_404040(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.x404040,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      );
  static TextStyle x10dp_00CE94(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.x00CE94,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
      );
  static TextStyle x10dp_FFFFFF(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.xFFFFFF,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.xFFFFFF,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle x10dp_404040(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.x404040,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      );
  static TextStyle x10dp_323232(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.x323232,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        decoration:
            isUnderlined != null && isUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationColor: AppColors.x9B9B9B,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2.0,
      );
  static TextStyle italic_323232(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.x323232,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
      );
  static TextStyle x10dp_323232_06(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.x323232_06,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      );
  static TextStyle x10dp_medium_323232(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.x323232,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      );
  static TextStyle x10dp_C4C4C4(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.xC4C4C4,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      );
  static TextStyle x10dp_medium_C4C4C4(double fontsize, {bool? isUnderlined}) =>
      TextStyle(
        fontFamily: textFormFamily,
        fontSize: fontsize,
        color: AppColors.xC4C4C4,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      );

  static TextStyle highlight = TextStyle(
    fontFamily: textFormFamily,
    color: AppColors.x52965E,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    decoration: TextDecoration.underline,
  );

  static ovalShape() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0));
  }

  static ovalDarkDecoration({Color? color, double? radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 40.0),
      color: color ?? AppColors.x404040,
    );
  }

  static colorComboDecoration(context) {
    return BoxDecoration(
      color: isDarkTheme(context) ?AppColors.accentText: AppColors.primaryBackground ,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x0F5CD53C).withAlpha((0.1 * 255).toInt()),
          Color(0x005CD53C),
        ],
      ),
    );
  }

  static ovalMarketDecoration({Color? color, double? radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 40.0),
      color: color ?? AppColors.xF3F3F5,
    );
  }

  static ovalWhiteDecoration({Color? color, double? radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 40.0),
      color: color ?? AppColors.xFFFFFF,
    );
  }

  static ovalGreenDecoration({Color? color, double? radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 40.0),
      color: color ?? AppColors.x008751,
    );
  }

  static ovalBurntGoldDecoration({Color? color, double? radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 40.0),
      color: color ?? AppColors.burntGold,
    );
  }

  static ovalBorderedGreenDecoration({
    Color? color,
    double? radius,
    double? borderWidth,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 28.0),
      color: const Color(0xffffffff),
      border: Border.all(
        color: color ?? AppColors.x52965E,
        style: BorderStyle.solid,
        width: borderWidth ?? 0.80,
      ),
    );
  }

  static ovalBorderedTradeDecoration({
    Color? color,
    double? radius,
    double? borderWidth,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 28.0),
      color: const Color(0x00000000),
      border: Border.all(
        color: color ?? AppColors.xD0D0D0,
        style: BorderStyle.solid,
        width: borderWidth ?? 0.80,
      ),
    );
  }

  static ovalBorderedViewDecoration({
    Color? color,
    double? radius,
    double? borderWidth,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 4.0),
      color: const Color(0xffffffff),
      border: Border.all(
        color: color ?? Color(0xff111411),
        style: BorderStyle.solid,
        width: borderWidth ?? 1.0,
      ),
    );
  }

  static ovalRedDecoration({Color? color, double? radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 40.0),
      color: color ?? AppColors.xD61A0D,
    );
  }

  /// ************************end new design styles*******************************
  static outlineBorder(
    EdgeInsets contentPaddingValues,
    Color borderColor,
    double borderWidth,
  ) {
    return InputDecoration(
      filled: true,
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: borderWidth),
      ),
      contentPadding: contentPaddingValues,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: borderWidth),
      ),
    );
  }
}
