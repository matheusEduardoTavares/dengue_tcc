import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';
import 'package:dengue_tcc/app/modules/sign/models/create_account_model.dart';
import 'package:dengue_tcc/app/modules/sign/repositories/signup_repository.dart';
import 'package:dengue_tcc/app/utils/rest_client/api_definitions/api_definitions.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client_exception.dart';

class SignupRepositoryImpl implements SignupRepository {
  SignupRepositoryImpl({
    required RestClient client,
  }) : _client = client;

  final RestClient _client;

  @override
  Future<Either<String, UserModel>> createAccount({
    required CreateAccountModel model,
  }) async {
    try {
      final userResponse = await _client.unauth().post(
            ApiDefinitions.signup,
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
