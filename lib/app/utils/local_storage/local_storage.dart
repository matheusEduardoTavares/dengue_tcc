abstract class LocalStorage {
  Future<bool> contains(String key);
  Future<void> clear();
  Future<void> remove(String key);
  Future<T?> read<T>(String key);
  Future<void> write<T>(String key, T value);
}