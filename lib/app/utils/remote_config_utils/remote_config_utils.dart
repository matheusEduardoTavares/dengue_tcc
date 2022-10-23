import 'package:dengue_tcc/app/utils/environment/environment.dart';
import 'package:dengue_tcc/app/utils/environment/environment_keys.dart';
import 'package:dengue_tcc/app/utils/map_utils/map_utils.dart';
import 'package:dengue_tcc/app/utils/remote_config_utils/remote_config_keys.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigUtils {
  RemoteConfigUtils._();

  static Future<void> initialize({
    required Environment environment,
  }) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ));
      await remoteConfig.fetchAndActivate();
    } catch (_) {
      await remoteConfig.setDefaults({
        RemoteConfigKeys.apiURL:
            environment.getVariable(EnvironmentKeys.apiURL),
        RemoteConfigKeys.centerMapLat: MapUtils.barraBonitaCityCenterLat,
        RemoteConfigKeys.centerMapLon: MapUtils.barraBonitaCityCenterLon,
        RemoteConfigKeys.phone: MapUtils.phone,
      });
    }
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
