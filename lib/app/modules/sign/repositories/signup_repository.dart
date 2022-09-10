import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';
import 'package:dengue_tcc/app/modules/sign/models/create_account_model.dart';

abstract class SignupRepository {
  SignupRepository._();

  Future<Either<String, UserModel>> createAccount({
    required CreateAccountModel model,
  });
}
