import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/modules/core/models/user/user_model.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_appbar/empty_appbar.dart';
import 'package:dengue_tcc/app/modules/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:dengue_tcc/app/modules/core/widgets/loading_widget/loading_widget.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_interface.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/buttons/login_button.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/sign_background/sign_background.dart';
import 'package:dengue_tcc/app/utils/extensions/text_extension.dart';
import 'package:dengue_tcc/app/utils/flushbar_control/flushbar_control.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;
import 'package:validatorless/validatorless.dart';

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
    return WillPopScope(
      onWillPop: () async {
        widget._controller.clearState();

        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: EmptyAppbar(),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: SignBackground(
                child: BlocConsumer<SignControllerInterface,
                    InitialSignControllerState>(
                  bloc: widget._controller,
                  listener: (_, state) {
                    if (state is ErrorSignINControllerState) {
                      FlushbarControl.showFlushbar(
                        message: state.errorMessage,
                        context: context,
                      );
                      widget._controller.errorCallbackState();
                    } else if (state is SuccessSignINControllerState) {
                      _globalCubit.updateUserModel(
                        UserModel(
                          login: state.email,
                          password: state.password,
                          phone: state.phone,
                          name: state.name,
                          isAdm: state.isAdmin,
                          authToken: state.loginResponseModel.accessToken,
                          refreshToken: null,
                        ),
                      );

                      Modular.to.navigate(
                        Modular.initialRoute,
                      );
                    }
                  },
                  listenWhen: (_, currentState) =>
                      currentState is SuccessSignINControllerState ||
                      currentState is ErrorSignINControllerState,
                  builder: (context, state) {
                    if (state is LoadingSignINControllerState ||
                        state is LoadingSignUPControllerState) {
                      return const LoadingWidget();
                    }

                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 31,
                        ),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Login',
                                    style: context.getTitle,
                                  ),
                                  const SizedBox(
                                    height: 43,
                                  ),
                                  DefaultTextFormField(
                                    controller: _loginEC,
                                    hintText: 'Login',
                                    validator: Validatorless.required(
                                        'Login inválido'),
                                    onChanged: widget._controller.updateEmail,
                                  ),
                                  const SizedBox(
                                    height: 28,
                                  ),
                                  DefaultTextFormField(
                                    controller: _passwordEC,
                                    hintText: 'Senha',
                                    obscureText: true,
                                    onChanged:
                                        widget._controller.updatePassword,
                                    validator: Validatorless.multiple([
                                      Validatorless.required('Senha inválida'),
                                      Validatorless.min(
                                        4,
                                        'Mínimo de 4 caracteres',
                                      ),
                                    ]),
                                  ),
                                  if (state.isAdmin)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 28.0,
                                      ),
                                      child: DefaultTextFormField(
                                        onChanged:
                                            widget._controller.updateAdmCode,
                                        controller: _admCodeEC,
                                        obscureText: true,
                                        hintText: 'Código ADM',
                                        validator: Validatorless.required(
                                          'Código inválido',
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Modular.to.pushNamed(
                                          ModulesRoute
                                              .forgotPasswordModuleNavigate,
                                        );
                                      },
                                      child: Text(
                                        'Esqueci minha senha',
                                        style: context.getDisplaySmall,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Sou um Administrador',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Checkbox(
                                          value: state.isAdmin,
                                          onChanged: (isSelected) {
                                            widget._controller.updateIsAdmin(
                                              isSelected ?? false,
                                            );
                                          },
                                          side: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 43,
                            ),
                            LoginButton(
                              callback: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  widget._controller.signIN();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
