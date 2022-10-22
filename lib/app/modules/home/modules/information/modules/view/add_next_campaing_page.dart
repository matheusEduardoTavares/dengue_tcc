import 'package:dengue_tcc/app/modules/core/widgets/default_button/default_button.dart';
import 'package:dengue_tcc/app/modules/core/widgets/default_page_with_scroll/default_page_with_scroll_widget.dart';
import 'package:dengue_tcc/app/modules/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:dengue_tcc/app/modules/core/widgets/loading_widget/loading_widget.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/modules/controller/add_next_campaing_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/modules/controller/add_next_campaing_controller_interface.dart';
import 'package:dengue_tcc/app/utils/awesome_dialogs_control/awesome_dialogs_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;
import 'package:validatorless/validatorless.dart';

class AddNextCampaignPage extends StatefulWidget {
  const AddNextCampaignPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNextCampaignPage> createState() => _AddNextCampaignPageState();
}

class _AddNextCampaignPageState extends State<AddNextCampaignPage> {
  late AddNextCampaingControllerInterface _controller;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleEC;
  late TextEditingController _descriptionEC;

  @override
  void initState() {
    super.initState();

    _controller = context.read<AddNextCampaingControllerInterface>();
    _titleEC = TextEditingController();
    _descriptionEC = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageWithScrollWidget(
      formKey: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 31,
        ),
        child: BlocConsumer<AddNextCampaingControllerInterface,
            AddNextCampaingControllerState>(
          bloc: _controller,
          listenWhen: (_, state) =>
              state is ErrorAddNextCampaingControllerState ||
              state is SuccessAddNextCampaingControllerState,
          listener: (_, state) async {
            if (state is SuccessAddNextCampaingControllerState) {
              await AwesomeDialogsControl.showAwesomeDialogs(
                message: 'Campanha adicionada com sucesso',
                context: context,
                btnOkOnPress: () {},
              );

              Modular.to.pop(true);
            } else {
              await AwesomeDialogsControl.showAwesomeDialogs(
                message:
                    (state as ErrorAddNextCampaingControllerState).errorMessage,
                context: context,
                isError: true,
                btnOkOnPress: () {},
              );
            }
          },
          builder: (_, state) {
            if (state is LoadingAddNextCampaingControllerState) {
              return const LoadingWidget();
            }

            return Column(
              children: [
                const SizedBox(
                  height: 43,
                ),
                Column(
                  children: [
                    DefaultTextFormField(
                      controller: _titleEC,
                      hintText: 'Título',
                      validator: Validatorless.required(
                        'Título inválido',
                      ),
                      onChanged: (_) {},
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    DefaultTextFormField(
                      controller: _descriptionEC,
                      hintText: 'Descrição',
                      validator: Validatorless.required(
                        'Descrição inválida',
                      ),
                      onChanged: (_) {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 43,
                ),
                DefaultButton(
                  callback: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _controller.addNextCampaign(
                        title: _titleEC.text,
                        description: _descriptionEC.text,
                      );
                    }
                  },
                  label: 'Criar nova campanha',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleEC.dispose();
    _descriptionEC.dispose();

    super.dispose();
  }
}
