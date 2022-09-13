import 'package:dengue_tcc/app/utils/environment/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentImpl implements Environment {
  @override
  void clear() {
    dotenv.clean();
  }

  @override
  Future<void> configureEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  @override
  String? getVariable(String key) {
    return dotenv.env[key];
  }
}
