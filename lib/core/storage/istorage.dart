abstract class LocalStorage implements DatabaseStorage, CacheStorage {}


abstract class DatabaseStorage {}


abstract class CacheStorage {
   Future<void> setThemeSetting(String theme);
  Future<String?> getThemeSetting();
}