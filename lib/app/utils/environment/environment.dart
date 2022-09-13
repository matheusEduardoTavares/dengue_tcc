abstract class Environment {
  void clear();
  Future<void> configureEnvironment();
  String? getVariable(String key);
}
