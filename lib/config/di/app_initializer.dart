import 'package:get_it/get_it.dart';

class AppInitializer {
   static late GetIt instanceLocator;
  AppInitializer._();

  static void close() {
    instanceLocator.reset();
  }

}