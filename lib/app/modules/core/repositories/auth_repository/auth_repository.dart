import 'package:dartz/dartz.dart';
import 'package:dengue_tcc/app/modules/core/models/login/login_model.dart';
import 'package:dengue_tcc/app/modules/core/models/login/login_response_model.dart';
import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, void>> logout();
  Future<Either<String, LoginResponseModel>> login({
    required LoginModel model,
  });

  Future<Either<String, UserModel>> refreshToken({
    required UserModel model,
  });
}
