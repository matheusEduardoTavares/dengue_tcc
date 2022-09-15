import 'package:dengue_tcc/app/modules/core/widgets/custom_appbar/dengue_appbar.dart';
import 'package:dengue_tcc/app/modules/core/widgets/general_error/general_error_widget.dart';
import 'package:dengue_tcc/app/modules/core/widgets/loading_widget/loading_widget.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_interface.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/view/widgets/information_item_widget.dart';
import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:dengue_tcc/app/utils/app_theme/app_shadows/app_shadows.dart';
import 'package:dengue_tcc/app/utils/enums/information_enum/information_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({
    required InformationControllerInterface controller,
    this.pageType,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  final InformationControllerInterface _controller;
  final InformationEnum? pageType;

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  void initState() {
    super.initState();

    widget._controller
      ..initialize(widget.pageType)
      ..getInformations();
  }

  @override
  Widget build(BuildContext context) {
    //TODO!: ARRUMAR O VISUAL
    return Scaffold(
      appBar: DengueAppbar(),
      body: BlocBuilder<InformationControllerInterface,
          InformationControllerState>(
        bloc: widget._controller,
        builder: (_, state) {
          if (state is LoadingInformationControllerState) {
            return const LoadingWidget();
          }

          if (state is ErrorInformationControllerState) {
            return GeneralErrorWidget(
              retryCallback: () {
                widget._controller.getInformations();
              },
              title: 'Erro ao baixar as informações',
            );
          }

          final model = (state as SuccessInformationControllerState).model;

          return Container(
            decoration: BoxDecoration(boxShadow: [
              AppShadows.informationContentShadow,
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 23,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    state.pageType.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.informations.length,
                      itemBuilder: (context, index) {
                        final message = model.informations[index];

                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 22.0,
                          ),
                          child: InformationItemWidget(
                            message: message,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
