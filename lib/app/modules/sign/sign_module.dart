import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_interface.dart';
import 'package:dengue_tcc/app/modules/sign/modules/forgot_password/forgot_password_module.dart';
import 'package:dengue_tcc/app/modules/sign/repositories/signup_repository.dart';
import 'package:dengue_tcc/app/modules/sign/repositories/signup_repository_impl.dart';
import 'package:dengue_tcc/app/modules/sign/view/sign_in_page.dart';
import 'package:dengue_tcc/app/modules/sign/view/sign_page.dart';
import 'package:dengue_tcc/app/modules/sign/view/sign_up_page.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<SignupRepository>(
      (i) => SignupRepositoryImpl(
        client: Modular.get(),
      ),
    ),
    Bind.lazySingleton<SignControllerInterface>(
      (i) => SignControllerCubit(
        authRepository: Modular.get(),
        signupRepository: Modular.get(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => const SignPage(),
    ),
    ChildRoute(
      ModulesRoute.signModuleSignIN,
      child: (_, __) => SignINPage(
        controller: Modular.get(),
      ),
    ),
    ChildRoute(
      ModulesRoute.signModuleSignUP,
      child: (_, __) => SignUPPage(
        controller: Modular.get(),
      ),
    ),
    ModuleRoute(
      ModulesRoute.forgotPasswordModule,
      module: ForgotPasswordModule(),
    ),
  ];
}
