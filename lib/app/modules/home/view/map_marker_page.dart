import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_cubit.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/modules/core/widgets/default_button/default_button.dart';
import 'package:dengue_tcc/app/modules/core/widgets/default_page_with_scroll/default_page_with_scroll_widget.dart';
import 'package:dengue_tcc/app/modules/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:dengue_tcc/app/modules/core/widgets/loading_widget/loading_widget.dart';
import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:dengue_tcc/app/utils/awesome_dialogs_control/awesome_dialogs_control.dart';
import 'package:dengue_tcc/app/utils/enums/map_marker/map_marker_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class MapMarkerPage extends StatefulWidget {
  const MapMarkerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MapMarkerPage> createState() => _MapMarkerPageState();
}

class _MapMarkerPageState extends State<MapMarkerPage> {
  late CustomMapControllerInterface _controller;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleEC;
  late TextEditingController _descriptionEC;
  late AuthControllerInterface _globalCubit;

  @override
  void initState() {
    super.initState();

    _controller = context.read<CustomMapControllerInterface>();
    _globalCubit = context.read<AuthControllerInterface>();
    final selectedMarker =
        (_controller.state as CustomMapStateWithMarkers).selectedMarker!;
    _titleEC = TextEditingController.fromValue(
      TextEditingValue(
        text: selectedMarker.title ?? '',
      ),
    );
    _descriptionEC = TextEditingController.fromValue(
      TextEditingValue(
        text: selectedMarker.description ?? '',
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
        child: BlocBuilder<AuthControllerInterface, AuthControllerState>(
          builder: (context, globalState) {
            return BlocConsumer<CustomMapControllerInterface, CustomMapState>(
              bloc: _controller,
              listenWhen: (_, currentState) =>
                  currentState is ErrorCustomMapAddingMarkerState ||
                  currentState is CustomMapUpdateMarkerError,
              listener: (_, state) {
                if (state is CustomMapUpdateMarkerError) {
                  AwesomeDialogsControl.showAwesomeDialogs(
                    message: state.errorMessage,
                    context: context,
                    isError: true,
                    btnOkOnPress: () {},
                  );

                  _controller.clearUpdateMarkerOnAPIError();
                } else if (state is ErrorCustomMapAddingMarkerState) {
                  AwesomeDialogsControl.showAwesomeDialogs(
                    message: state.errorMessage,
                    context: context,
                    isError: true,
                    btnOkOnPress: () {},
                  );

                  _controller.clearCreateMarkerOnAPIError();
                }
              },
              builder: (_, state) {
                if (state is LoadingCustomMapAddingMarkerState ||
                    state is CustomMapUpdateMarkerLoading ||
                    (state is CustomMapStateWithMarkers &&
                        state.selectedMarker == null)) {
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
                          onChanged:
                              _controller.updateTemporaryMarkerDescription,
                        ),
                        if ((state as CustomMapStateWithMarkers)
                            .selectedMarker!
                            .isAPIMarker)
                          Padding(
                            padding: const EdgeInsets.only(top: 28),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.buttonBackground,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Quantidade de pontos: ${state.selectedMarker!.counter}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (state.hasIncrementedMarkerCounter ==
                                              null ||
                                          state.hasIncrementedMarkerCounter ==
                                              false) {
                                        _controller
                                            .incrementTemporaryMarkerCounter();
                                      } else {
                                        _controller
                                            .decrementTemporaryMarkerCounter();
                                      }
                                    },
                                    icon: Icon(
                                      (state.hasIncrementedMarkerCounter ==
                                              true)
                                          ? Icons.remove
                                          : Icons.add,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 43,
                    ),
                    DefaultButton(
                      callback: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (state.selectedMarker!.isCreatedMarker) {
                            _controller.updateMarkerOnAPI(
                              title: _titleEC.text,
                              description: _descriptionEC.text,
                            );
                          } else {
                            _controller.createMarkerOnAPI(
                              title: _titleEC.text,
                              description: _descriptionEC.text,
                            );
                          }
                        }
                      },
                      label:
                          '${state.selectedMarker!.isCreatedMarker ? 'Atualizar' : 'Criar'} ponto de dengue',
                    ),
                    if (state.selectedMarker!.isCreatedMarker &&
                        state.selectedMarker!.status == MapMarkerEnum.active &&
                        (globalState.userModel!.isAdm ?? false))
                      Padding(
                        padding: const EdgeInsets.only(top: 43.0),
                        child: DefaultButton(
                          callback: () {
                            _controller
                              ..markSelectedMarkerWithinFinished()
                              ..updateMarkerOnAPI(
                                title: _titleEC.text,
                                description: _descriptionEC.text,
                              );
                          },
                          label: 'Marcar ponto de dengue como finalizado',
                        ),
                      )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.clearSelectedMarkerCounter();
    _titleEC.dispose();
    _descriptionEC.dispose();

    super.dispose();
  }
}
