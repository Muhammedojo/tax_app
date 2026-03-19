import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';

import '../contract/offline_pack_contract.dart';
import '../widgets/general_scaffold.dart';
import '../widgets/tax_button.dart';

class OfflinePackView extends StatelessWidget
    implements OfflinePackViewContract {
  const OfflinePackView({super.key, required this.controller});

  final OfflinePackControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return TaxLightScaffold(
      body: Column(
        children: [
          Padding(
            padding: REdgeInsets.only(top: 18, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back, size: 28.sp),
                30.horizontalSpace,
                Expanded(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryGreen),
                    backgroundColor: AppColors.border,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                Container(),
              ],
            ),
          ),
          13.verticalSpace,
      
          'Offline Pack'.toText(fontSize: 24, fontWeight: FontWeight.w800),
          31.verticalSpace,
      
          Container(
            // padding: REdgeInsets.symmetric(horizontal: 170, vertical: 41.6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.5.r),
              border: Border.all(color: AppColors.border, width: 2.sp),
              color: AppColors.white,
            ),
            child: Padding(
              padding:  REdgeInsets.symmetric(horizontal: 170, vertical: 41.6),
              child: Center(
                child: 
                // Image.asset('assets/images/document-download.png')
                'document-download'.toSvg(
                  width: 45.7.sp,
                  height: 48.15.sp,
                
                ),
              ),
            ),
          ),
          11.7.verticalSpace,
          'Download law pack for offline reading'.toText(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          8.verticalSpace,
      
          'Small size. One-time download. Read anytime.'.toText(
            color: AppColors.secondaryText,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textHeight: 20 / 14,
          ),
          45.verticalSpace,
          TaxLightButton(label: 'Download', onPressed: () {}),
      
          12.verticalSpace,
      
          TaxLightButton(
            label: 'Skip for now',
            onPressed: () {
              controller.goToHome();
            },
            variant: TaxLightButtonVariant.ghost,
          ),
        ],
      ),
    );
  }
}
