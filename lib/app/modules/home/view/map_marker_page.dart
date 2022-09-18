import 'package:dengue_tcc/app/modules/core/models/map_marker/map_marker_model.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_cubit.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/modules/core/widgets/default_button/default_button.dart';
import 'package:dengue_tcc/app/modules/core/widgets/default_page_with_scroll/default_page_with_scroll_widget.dart';
import 'package:dengue_tcc/app/modules/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:dengue_tcc/app/modules/core/widgets/loading_widget/loading_widget.dart';
import 'package:dengue_tcc/app/utils/awesome_dialogs_control/awesome_dialogs_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class MapMarkerPage extends StatefulWidget {
  const MapMarkerPage({
    required this.model,
    Key? key,
  }) : super(key: key);

  final MapMarkerModel model;

  @override
  State<MapMarkerPage> createState() => _MapMarkerPageState();
}

class _MapMarkerPageState extends State<MapMarkerPage> {
  late CustomMapControllerInterface _controller;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleEC;
  late TextEditingController _descriptionEC;

  @override
  void initState() {
    super.initState();

    _controller = context.read();
    _titleEC = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.model.title ?? '',
      ),
    );
    _descriptionEC = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.model.description ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageWithScrollWidget(
      formKey: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 31,
        ),
        child: BlocConsumer<CustomMapControllerInterface, CustomMapState>(
          bloc: _controller,
          listenWhen: (_, currentState) =>
              currentState is ErrorCustomMapAddingMarkerState,
          listener: (_, state) {
            AwesomeDialogsControl.showAwesomeDialogs(
              message: 'Erro ao adicionar o novo ponto',
              context: context,
              isError: true,
              btnOkOnPress: () {},
            );
          },
          builder: (_, state) {
            if (state is LoadingCustomMapAddingMarkerState) {
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
                      onChanged: _controller.updateTemporaryMarkerTitle,
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
                      onChanged: _controller.updateTemporaryMarkerDescription,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 43,
                ),
                DefaultButton(
                  callback: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _controller.createMarkerOnAPI(
                        title: _titleEC.text,
                        description: _descriptionEC.text,
                      );
                    }
                  },
                  label: 'Criar ponto de dengue',
                )
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
