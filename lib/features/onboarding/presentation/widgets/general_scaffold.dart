import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tax_app/core/utils/extensions.dart';

import '../../../../core/theme/colors.dart';

/// The shared scaffold used across all TaxLight screens.
/// Renders the light-green blob background at the bottom and the
/// "Powered by" footer, while exposing a [body] slot for screen content.
class TaxLightScaffold extends StatelessWidget {
  const TaxLightScaffold({
    super.key,
    required this.body,
    this.showTopActions = false,
    this.onThemeToggle,
    this.onSettings,
    this.customTitle,
     this.widgetTitle,
     this.noHeader = false,
    this.title,
    this.showLogo = false,
  });

  final Widget body;

  /// Whether to show the dark-mode toggle and settings icons in the top-right.
  final bool showTopActions;
  final bool showLogo;
  final bool noHeader;
  final String? title;
  final Widget? widgetTitle;
  final bool? customTitle;
  final VoidCallback? onThemeToggle;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Light_Splash_Screen.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 16.sp,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/powered.png',
                width: 105.sp,
                height: 125.sp,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showTopActions
                        ? Row(
                            children: [
                              if (showLogo)
                                SvgPicture.asset(
                                  'assets/vectors/appLogo.svg',
                                  fit: BoxFit.contain,
                                  width: 47.sp,
                                  height: 47.sp,
                                ),
                              if (title != null)
                                Padding(
                                  padding: REdgeInsets.only(left: 16),
                                  child: title!.toText(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              const Spacer(), // always pushes icons to the right
                              noHeader ? SizedBox() :
                              Padding(
                                padding:  REdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.dark_mode_outlined,
                                        color: AppColors.primaryText,
                                        size: 22,
                                      ),
                                      onPressed: onThemeToggle,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.settings_outlined,
                                        color: AppColors.secondaryText,
                                        size: 22,
                                      ),
                                      onPressed: onSettings,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.arrow_back),
                              ),
                              8.horizontalSpace,
                              customTitle == true
                                  ? widgetTitle!
                                  : (title ?? '').toText(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.dark_mode_outlined,
                                  color: AppColors.primaryText,
                                  size: 22,
                                ),
                                onPressed: onThemeToggle,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.settings_outlined,
                                  color: AppColors.secondaryText,
                                  size: 22,
                                ),
                                onPressed: onSettings,
                              ),
                            ],
                          ),
                    Expanded(child: body),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
