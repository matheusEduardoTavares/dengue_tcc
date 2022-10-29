import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_interface.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/buttons/login_button.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/default_sign_page/default_sign_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;

class SignINPage extends StatefulWidget {
  const SignINPage({
    required SignControllerInterface controller,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  final SignControllerInterface _controller;

  @override
  State<SignINPage> createState() => _SignINPageState();
}

class _SignINPageState extends State<SignINPage> {
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _admCodeEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AuthControllerInterface _globalCubit;

  @override
  void initState() {
    super.initState();

    _globalCubit = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultSignPage(
      loginEC: _loginEC,
      passwordEC: _passwordEC,
      admCodeEC: _admCodeEC,
      formKey: _formKey,
      errorCallbackState: () {
        widget._controller.setErrorSignINState();
      },
      successCallbackState: (state) async {
        await _globalCubit.updateUserModel(
          UserModel(
            login: state.email,
            password: state.password,
            isAdm: state.isAdmin,
            authToken: (state as SuccessSignINControllerState)
                .loginResponseModel
                .accessToken,
            refreshToken: null,
            phone: state.loginResponseModel.phone,
            name: state.loginResponseModel.name,
            id: state.loginResponseModel.id,
          ),
        );

        Modular.to.navigate(
          Modular.initialRoute,
        );
      },
      titlePage: 'Login',
      errorState: ErrorSignINControllerState,
      loadingState: LoadingSignINControllerState,
      successState: SuccessSignINControllerState,
      // childAfterForm: TextButton(
      //   onPressed: () {
      //     Modular.to.pushNamed(
      //       ModulesRoute.forgotPasswordModuleNavigate,
      //     );
      //   },
      //   child: Text(
      //     'Esqueci minha senha',
      //     style: context.getDisplaySmall,
      //   ),
      // ),
      confirmButton: LoginButton(
        callback: () {
          if (_formKey.currentState?.validate() ?? false) {
            widget._controller.signIN();
          }
        },
      ),
      controller: widget._controller,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _loginEC.dispose();
    _passwordEC.dispose();
    _admCodeEC.dispose();
  }
}
