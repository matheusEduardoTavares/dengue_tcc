import 'package:dengue_tcc/app/modules/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/sign/controller/sign_controller_interface.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/buttons/signup_button.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/default_sign_page/default_sign_page.dart';
import 'package:dengue_tcc/app/utils/awesome_dialogs_control/awesome_dialogs_control.dart';
import 'package:dengue_tcc/app/utils/input_formatter/input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

class SignUPPage extends StatefulWidget {
  const SignUPPage({
    required SignControllerInterface controller,
    required InputFormatter formatter,
    Key? key,
  })  : _controller = controller,
        _formatter = formatter,
        super(key: key);

  final SignControllerInterface _controller;
  final InputFormatter _formatter;

  @override
  State<SignUPPage> createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _admCodeEC = TextEditingController();
  final _nameEC = TextEditingController();
  final _phoneEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultSignPage(
      loginEC: _loginEC,
      passwordEC: _passwordEC,
      admCodeEC: _admCodeEC,
      formKey: _formKey,
      errorCallbackState: () {
        widget._controller.setErrorSignUPState();
      },
      successCallbackState: (state) async {
        await AwesomeDialogsControl.showAwesomeDialogs(
          message: 'Conta criada com sucesso',
          context: context,
        );

        Modular.to.navigate(
          Modular.initialRoute,
        );
      },
      titlePage: 'Registrar-se',
      errorState: ErrorSignUPControllerState,
      loadingState: LoadingSignUPControllerState,
      successState: SuccessSignUPControllerState,
      confirmButton: SignUPButton(
        callback: () {
          if (_formKey.currentState?.validate() ?? false) {
            widget._controller.signUP();
          }
        },
      ),
      controller: widget._controller,
      otherFormFields: [
        DefaultTextFormField(
          controller: _nameEC,
          hintText: 'Nome',
          onChanged: widget._controller.updateName,
          validator: Validatorless.multiple([
            Validatorless.required('Nome inválido'),
            Validatorless.min(
              4,
              'Mínimo de 4 caracteres',
            ),
          ]),
        ),
        const SizedBox(
          height: 28,
        ),
        DefaultTextFormField(
          inputFormatters: [
            widget._formatter.getInputFormatterPhone(),
          ],
          controller: _phoneEC,
          hintText: 'Telefone',
          onChanged: (value) {
            final formattedPhone = widget._formatter.getPhoneUnmask(value);
            widget._controller.updateCellphone(formattedPhone);
          },
          keyboardType: TextInputType.phone,
          validator: Validatorless.multiple([
            Validatorless.required('Telefone inválido'),
            Validatorless.min(
              15,
              'Mínimo de 11 caracteres',
            ),
            Validatorless.max(
              15,
              'Máximo de 11 caracteres',
            ),
          ]),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    _loginEC.dispose();
    _passwordEC.dispose();
    _admCodeEC.dispose();
    _nameEC.dispose();
    _phoneEC.dispose();
  }
}
