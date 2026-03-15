import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'core/navigation/app_router.dart';

// ValueNotifier<ThemeData> themeNotifier = ValueNotifier(darkTheme);

class TaxApp extends StatefulWidget {
  const TaxApp({super.key});

  @override
  State<TaxApp> createState() => _TaxAppState();
}

class _TaxAppState extends State<TaxApp> {
  // This widget is the root of your application.
  //   ThemeMode _themeMode = ThemeMode.light;

  // void _toggleTheme() {
  //   setState(() {
  //     _themeMode =
  //         _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return 
      ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: false,
        fontSizeResolver: FontSizeResolvers.height,
        rebuildFactor: (old, data) {
          return true;
        },
        builder: (context, child) {
          ResponsiveBreakpoints.builder(
            child: child ?? const SizedBox(),
            breakpoints: [
              Breakpoint(start: 0, end: 450, name: MOBILE),
               Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          );
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                // ignore: deprecated_member_use
                textScaleFactor:
                    MediaQuery.of(context).size.width > 428 ? 1 : 1.05),
            child: SkeletonizerConfig(
              data: const SkeletonizerConfigData.dark(),
              //  theme == lightTheme
              //     ? const SkeletonizerConfigData.light()
              //     : const SkeletonizerConfigData.dark(),
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                // localizationsDelegates: [
                //   ...context.localizationDelegates,
                //   // YrMaterialLocalizations.delegate,
                //   // YrCupertinoLocalizations.delegate,
                //   // YrWidgetLocalizations.delegate,
                // ],
                supportedLocales: const [
                  Locale('en'),
                  // Locale('yr'),
                ],
                // locale: context.locale,
                // builder: EasyLoading.init(),
                routerConfig: router,
                // theme: darkTheme,
              ),
            ),
          );
        },
      )

 
    ;
  }
}