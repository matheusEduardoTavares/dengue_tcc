import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';
import 'package:dengue_tcc/app/modules/core/repositories/auth_repository/auth_repository.dart';
import 'package:dengue_tcc/app/modules/core/models/login/login_model.dart';
import 'package:dengue_tcc/app/utils/rest_client/api_definitions/api_definitions.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required RestClient client,
  }) : _client = client;

  final RestClient _client;

  @override
  Future<Either<String, void>> logout() async {
    try {
      await _client.auth().post(ApiDefinitions.logout);
      return const Right(null);
    } on RestClientException catch (e) {
      return Left(e.message ?? e.error.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> login({required LoginModel model}) async {
    try {
      final userResponse = await _client.unauth().post(
            ApiDefinitions.signin,
            data: model.toMap(),
          );

      return Right(UserModel.fromMap(userResponse.data));
    } on RestClientException catch (e) {
      return Left(e.message ?? e.error.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> refreshToken(
      {required UserModel model}) async {
    try {
      final userResponse = await _client.auth().post(
            ApiDefinitions.refreshToken,
            data: model.toMap(),
          );

      return Right(UserModel.fromMap(userResponse.data));
    } on RestClientException catch (e) {
      return Left(e.message ?? e.error.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
