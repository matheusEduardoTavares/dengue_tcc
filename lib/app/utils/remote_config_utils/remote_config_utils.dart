import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigUtils {
  RemoteConfigUtils._();

  static Future<void> initialize() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 5),
    ));
  }

  static String? getStringValue({
    required String key,
  }) {
    final remoteConfig = FirebaseRemoteConfig.instance;
    return remoteConfig.getString(key);
  }

  static double? getDoubleValue({
    required String key,
  }) {
    final remoteConfig = FirebaseRemoteConfig.instance;
    return remoteConfig.getDouble(key);
  }
}
