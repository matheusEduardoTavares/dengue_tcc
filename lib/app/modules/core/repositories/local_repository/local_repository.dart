import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';

abstract class LocalRepository {
  LocalRepository._();

  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user);
  Future<bool> hasUser();
  Future<void> clearLocal();
}
