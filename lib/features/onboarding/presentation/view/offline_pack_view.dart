import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';

import '../bloc/offline_pack/offline_pack_cubit.dart';
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
      body: BlocBuilder<OfflinePackCubit, OfflinePackState>(
        builder: (context, state) {
          final isLoading = state is OfflinePackLoading;

          return Column(
            children: [
              13.verticalSpace,
              'Offline Pack'.toText(fontSize: 24, fontWeight: FontWeight.w800),
              31.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.5.r),
                  border: Border.all(color: AppColors.border, width: 2.sp),
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: REdgeInsets.symmetric(
                    horizontal: 170,
                    vertical: 41.6,
                  ),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: AppColors.primaryGreen,
                          )
                        : 'document-download'.toSvg(
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
              if (state is OfflinePackFailure) ...[
                8.verticalSpace,
                state.error.toText(
                  color: Colors.red,
                  fontSize: 13,
                  translate: false,
                ),
              ],
              45.verticalSpace,
              TaxLightButton(
                label: isLoading ? 'Downloading...' : 'Download',
                onPressed: isLoading ? null : controller.downloadPack,
              ),
              12.verticalSpace,
              TaxLightButton(
                label: 'Skip for now',
                onPressed: isLoading ? null : controller.goToHome,
                variant: TaxLightButtonVariant.ghost,
              ),
            ],
          );
        },
      ),
    );
  }
}
