import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';
import 'package:dengue_tcc/app/modules/core/repositories/local_repository/local_repository.dart';
import 'package:dengue_tcc/app/utils/local_storage/local_storage.dart';
import 'package:dengue_tcc/app/utils/local_storage/local_storage_keys.dart';

class LocalRepositoryImpl implements LocalRepository {
  LocalRepositoryImpl({
    required LocalStorage localStorage,
  }) : _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  Future<UserModel?> getUser() async {
    final user = await _localStorage.read<String>(LocalStorageKeys.user);
    if (user != null) {
      return UserModel.fromJson(user);
    }
    return null;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userEncoded = user.toJson();
    await _localStorage.write<String>(
      LocalStorageKeys.user,
      userEncoded,
    );
  }

  @override
  Future<bool> hasUser() async {
    return _localStorage.contains(LocalStorageKeys.user);
  }

  @override
  Future<void> clearLocal() async {
    await _localStorage.clear();
  }
}
