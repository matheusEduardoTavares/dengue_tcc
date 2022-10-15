import 'package:dengue_tcc/app/modules/core/widgets/default_page_with_scroll/default_page_with_scroll_widget.dart';
import 'package:dengue_tcc/app/modules/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:dengue_tcc/app/modules/core/widgets/loading_widget/loading_widget.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_interface.dart';
import 'package:dengue_tcc/app/utils/custom_typedefs/custom_typedefs.dart';
import 'package:dengue_tcc/app/utils/extensions/text_extension.dart';
import 'package:dengue_tcc/app/utils/flushbar_control/flushbar_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class DefaultSignPage extends StatelessWidget {
  const DefaultSignPage({
    required this.confirmButton,
    required this.loadingState,
    required this.successCallbackState,
    required this.errorCallbackState,
    required this.errorState,
    required this.successState,
    required this.titlePage,
    required SignControllerInterface controller,
    required TextEditingController loginEC,
    required TextEditingController passwordEC,
    required TextEditingController admCodeEC,
    required GlobalKey<FormState> formKey,
    this.childAfterForm,
    this.otherFormFields,
    Key? key,
  })  : _controller = controller,
        _loginEC = loginEC,
        _passwordEC = passwordEC,
        _admCodeEC = admCodeEC,
        _formKey = formKey,
        super(key: key);

  final SignControllerInterface _controller;
  final TextEditingController _loginEC;
  final TextEditingController _passwordEC;
  final TextEditingController _admCodeEC;
  final GlobalKey<FormState> _formKey;
  final Type errorState;
  final Type successState;
  final Type loadingState;
  final VoidCallback errorCallbackState;
  final SuccessSignCallback successCallbackState;
  final String titlePage;
  final Widget? childAfterForm;
  final Widget confirmButton;
  final List<Widget>? otherFormFields;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _controller.clearState();

        return true;
      },
      child: Scaffold(
        body: DefaultPageWithScrollWidget(
          child:
              BlocConsumer<SignControllerInterface, InitialSignControllerState>(
            bloc: _controller,
            listener: (_, state) async {
              if (state.runtimeType == errorState) {
                FlushbarControl.showFlushbar(
                  message: (state as SignErrorState).errorMessage,
                  context: context,
                );

                errorCallbackState();
              } else if (state.runtimeType == successState) {
                await successCallbackState(state);
              }
            },
            listenWhen: (_, currentState) =>
                currentState.runtimeType == errorState ||
                currentState.runtimeType == successState,
            builder: (context, state) {
              if (state.runtimeType == loadingState ||
                  state.runtimeType == successState) {
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
                              titlePage,
                              style: context.getTitle,
                            ),
                            const SizedBox(
                              height: 43,
                            ),
                            DefaultTextFormField(
                              controller: _loginEC,
                              hintText: 'Login',
                              validator: Validatorless.required(
                                'Login inválido',
                              ),
                              onChanged: _controller.updateEmail,
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            DefaultTextFormField(
                              controller: _passwordEC,
                              hintText: 'Senha',
                              obscureText: true,
                              onChanged: _controller.updatePassword,
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha inválida'),
                                Validatorless.min(
                                  4,
                                  'Mínimo de 4 caracteres',
                                ),
                              ]),
                            ),
                            if (otherFormFields != null) ...[
                              const SizedBox(
                                height: 28,
                              ),
                              ...otherFormFields!,
                            ],
                            if (state.isAdmin)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 28.0,
                                ),
                                child: DefaultTextFormField(
                                  onChanged: _controller.updateAdmCode,
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
                              childAfterForm ?? const SizedBox.shrink(),
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
                                      _controller.updateIsAdmin(
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
                      confirmButton,
                      const SizedBox(
                        height: 43,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
