import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tax_app/core/utils/extensions.dart';
import 'package:tax_app/core/utils/styles.dart';

import '../../../../core/theme/colors.dart';


/// The circular TaxLight logo icon with optional app-name label below.
class TaxLightLogo extends StatelessWidget {
  const TaxLightLogo({
    super.key,
    this.size = 80,
    this.showLabel = true,
  });

  final double size;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       SvgPicture.asset('assets/vectors/appLogo.svg', fit: BoxFit.contain, width: 89.sp, height: 89.sp,),
        if (showLabel) ...[
          const SizedBox(height: 12),
          'TaxLight'.toText(
            color: AppColors.secondaryText,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
         
          ),
        ],
      ],
    );
  }
}

