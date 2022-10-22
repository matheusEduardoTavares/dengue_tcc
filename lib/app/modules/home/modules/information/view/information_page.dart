import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_interface.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_appbar/dengue_appbar.dart';
import 'package:dengue_tcc/app/modules/core/widgets/general_error/general_error_widget.dart';
import 'package:dengue_tcc/app/modules/core/widgets/loading_widget/loading_widget.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_cubit.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_interface.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/view/widgets/information_item_widget.dart';
import 'package:dengue_tcc/app/utils/app_theme/app_shadows/app_shadows.dart';
import 'package:dengue_tcc/app/utils/enums/information_enum/information_enum.dart';
import 'package:dengue_tcc/app/utils/modules_route/modules_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;

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
  late AuthControllerInterface _userCubit;

  @override
  void initState() {
    super.initState();

    _userCubit = context.read<AuthControllerInterface>();
    widget._controller.initialize(widget.pageType);

    _executeGetRequests();
  }

  Future<void> _executeGetRequests() {
    if (widget.pageType == InformationEnum.denunciation) {
      return widget._controller.getDenunciations();
    } else {
      return widget._controller.getNextCampaigns();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DengueAppbar(),
      floatingActionButton:
          BlocBuilder<AuthControllerInterface, AuthControllerState>(
        bloc: _userCubit,
        builder: (context, state) {
          if (state.userModel != null && (state.userModel!.isAdm ?? false)) {
            return FloatingActionButton(
              onPressed: () async {
                final isUpdatePage = await Modular.to.pushNamed<bool?>(
                  ModulesRoute.addNextCampaignModuleNavigate,
                );

                if (isUpdatePage == true) {
                  _executeGetRequests();
                }
              },
              child: const Icon(Icons.add),
            );
          }

          return const SizedBox.shrink();
        },
      ),
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
                _executeGetRequests();
              },
              title: state.errorMessage,
            );
          }

          final model = (state as SuccessInformationControllerState).model;

          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(boxShadow: [
              AppShadows.informationContentShadow,
            ]),
            child: model.informations.isEmpty
                ? Center(
                    child: Row(
                      children: const [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 28.0),
                            child: Text(
                              'Não há campanhas disponíveis',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
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
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 22.0,
                                ),
                                child: InformationItemWidget(
                                  model: model.informations[index],
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
