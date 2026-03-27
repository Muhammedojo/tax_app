import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/api/api_services.dart';
import '../../core/api/api_services_impl.dart';
import '../../core/api/network/network_info.dart';
import '../../core/api/repository/repository.dart';
import '../../core/api/repository/repository_contract.dart';
import '../../core/api/services/contracts/api_client.dart';
import '../../core/api/services/dio_client.dart';
import '../../core/storage/istorage.dart';
import '../../core/storage/shared_prefs_storage.dart';
import '../../features/law/presentation/bloc/laws/laws_cubit.dart';
import '../../features/onboarding/presentation/bloc/language/language_cubit.dart';
import '../../features/onboarding/presentation/bloc/offline_pack/offline_pack_cubit.dart';
import '../../features/onboarding/presentation/bloc/role/role_cubit.dart';
import '../../features/onboarding/presentation/bloc/topic/topic_cubit.dart';
import '../../features/update/presentation/bloc/update/update_cubit.dart';

class AppInitializer {
  static late GetIt instanceLocator;
  AppInitializer._();

  static void close() {
    instanceLocator.reset();
  }

  static Future create() async {
    if (kDebugMode) {
      // Bloc.observer = AppBlocObserver();
    }
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await EasyLocalization.ensureInitialized();
    await initStorage();

    initializeDi();
  }

  static Future<void> initStorage() async {
    final prefs = await SharedPreferences.getInstance();
    instanceLocator.registerSingleton<LocalStorage>(SharedPrefsStorage(prefs));
  }

    static dynamic initGetIt() async {
    instanceLocator = GetIt.I;
    instanceLocator.allowReassignment = true;
    await create();
  }

  static void initializeDi() {
    initSecurity();
    initGlobalVariables();
    //initLocalDataSources();
    initRemoteDataSources();
    initRepos();
    initBlocs();
    initHelper();
  }

    static void initGlobalVariables() {
    instanceLocator.registerSingleton<String>(
      instanceName: "accessToken",
      "",
      signalsReady: true,
    );
    instanceLocator.registerSingleton<int>(
      instanceName: "userId",
      0,
      signalsReady: true,
    );
  }

    static void initHelper() {}

    static void initSecurity() {}

  static void initBlocs() {
    instanceLocator.registerLazySingleton<RoleCubit>(
      () => RoleCubit(repository: instanceLocator()),
    );
    instanceLocator.registerLazySingleton<TopicCubit>(
      () => TopicCubit(repository: instanceLocator()),
    );
    instanceLocator.registerLazySingleton<LawsCubit>(
      () => LawsCubit(repository: instanceLocator()),
    );
    instanceLocator.registerLazySingleton<UpdateCubit>(
      () => UpdateCubit(repository: instanceLocator()),
    );
    instanceLocator.registerLazySingleton<OfflinePackCubit>(
      () => OfflinePackCubit(
        repository: instanceLocator(),
        storage: instanceLocator(),
      ),
    );
    instanceLocator.registerLazySingleton<LanguageCubit>(
      () => LanguageCubit(repository: instanceLocator()),
    );
  }

  static void initRepos() {
    instanceLocator.registerLazySingleton<IAppRepository>(
      () => AppRepository(
        service: instanceLocator(),
        // sessionManager: instanceLocator(),
      ),
    );
  }

  static void initRemoteDataSources() {
    //remote data sources
    instanceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementation(),
    );
    instanceLocator.registerLazySingleton<IApiClient>(
      () => DioClient(instanceLocator()),
    );
    instanceLocator.registerLazySingleton<ApiService>(
      () => ApiServiceImpl(apiClient: instanceLocator()),
    );
  }

   static void disposeInstance<T extends Bloc>(T blocInstance) {
    instanceLocator.unregister(instance: blocInstance);
  }
}
