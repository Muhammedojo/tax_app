import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../../../../core/theme/colors.dart';


/// A single row in the "What TaxLight offers" feature list.
class FeatureListItem extends StatelessWidget {
  const FeatureListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,

  });

  final String icon;
  final String title;
  final String subtitle;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FeatureIcon(icon: icon,),
        16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.toText(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
               2.verticalSpace,
                subtitle.toText(
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _FeatureIcon extends StatelessWidget {
  const _FeatureIcon({required this.icon,});
  final String icon;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.sp,
      height: 40.sp,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r

      ),
        border: Border.all(
          color: AppColors.border,
          width: 1.5.sp,
        ),
        color: AppColors.white,
      ),
      child: Center(
        child: SvgPicture.asset(icon, width: 24.sp, height: 24.sp,),
      ),
    );
  }
}