import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'config/di/app_initializer.dart';
import 'core/navigation/app_router.dart';
import 'features/law/presentation/bloc/laws/laws_cubit.dart';
import 'features/onboarding/presentation/bloc/language/language_cubit.dart';
import 'features/onboarding/presentation/bloc/offline_pack/offline_pack_cubit.dart';
import 'features/onboarding/presentation/bloc/role/role_cubit.dart';
import 'features/onboarding/presentation/bloc/topic/topic_cubit.dart';
import 'features/update/presentation/bloc/update/update_cubit.dart';

class TaxApp extends StatelessWidget {
  const TaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppInitializer.instanceLocator.get<RoleCubit>(),
        ),
        BlocProvider(
          create: (context) => AppInitializer.instanceLocator.get<TopicCubit>(),
        ),
        BlocProvider(
          create: (context) => AppInitializer.instanceLocator.get<LawsCubit>(),
        ),
        BlocProvider(
          create: (context) => AppInitializer.instanceLocator.get<UpdateCubit>(),
        ),
        BlocProvider(
          create: (context) => AppInitializer.instanceLocator.get<OfflinePackCubit>(),
        ),
        BlocProvider(
          create: (context) => AppInitializer.instanceLocator.get<LanguageCubit>(),
        ),
      ],
      child: ScreenUtilInit(
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
              textScaleFactor: MediaQuery.of(context).size.width > 428
                  ? 1
                  : 1.05,
            ),
            child: SkeletonizerConfig(
              data: const SkeletonizerConfigData.dark(),
              //  theme == lightTheme
              //     ? const SkeletonizerConfigData.light()
              //     : const SkeletonizerConfigData.dark(),
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Tax Light',

                theme: ThemeData(useMaterial3: true),
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
      ),
    );
  }
}
