import 'package:dengue_tcc/app/modules/core/widgets/custom_appbar/dengue_appbar.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_cubit.dart';
import 'package:dengue_tcc/app/modules/core/widgets/custom_map/controller/custom_map_interface.dart';
import 'package:dengue_tcc/app/modules/sign/view/widgets/sign_background/sign_background.dart';
import 'package:dengue_tcc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;

class MarkersListPage extends StatefulWidget {
  const MarkersListPage({
    required MapController mapController,
    Key? key,
  })  : _mapController = mapController,
        super(key: key);

  final MapController _mapController;

  @override
  State<MarkersListPage> createState() => _MarkersListPageState();
}

class _MarkersListPageState extends State<MarkersListPage> {
  late CustomMapControllerInterface _mapCubit;

  @override
  void initState() {
    super.initState();

    _mapCubit = context.read<CustomMapControllerInterface>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomMapControllerInterface, CustomMapState>(
      bloc: _mapCubit,
      builder: (context, state) {
        const defaultTextStyle = TextStyle(color: Colors.white);
        final defaultBoxDecoration = BoxDecoration(
          color: AppColors.bottomBarBlack,
          borderRadius: BorderRadius.circular(20),
        );
        if ((state as CustomMapStateWithMarkers).markers.isEmpty) {
          return Scaffold(
            appBar: DengueAppbar(),
            body: SignBackground(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Container(
                    decoration: defaultBoxDecoration,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Não há nenhum ponto de foco de dengue',
                      style: defaultTextStyle.copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: DengueAppbar(),
          body: LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              child: SignBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: defaultBoxDecoration,
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Text(
                            'Filtrar pontos de foco de dengue',
                            style: defaultTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                CheckboxListTile(
                                  value: state.showFinishedMarkers,
                                  onChanged: (_) =>
                                      _mapCubit.toggleFinishedMarkers(),
                                  title: Text(
                                    'Finalizados (${_mapCubit.filterFinishedMarkers().length})',
                                    style: defaultTextStyle,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                CheckboxListTile(
                                  value: state.showUnfinishedMarkers,
                                  onChanged: (_) =>
                                      _mapCubit.toggleUnfinishedMarkers(),
                                  title: Text(
                                    'Ativos (${_mapCubit.filterUnfinishedMarkers().length})',
                                    style: defaultTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.getFilteredOrAllMarkers.length,
                            itemBuilder: (_, index) {
                              final currentModel =
                                  state.getFilteredOrAllMarkers[index];
                              return ListTile(
                                leading: Text(
                                  'Ponto #${currentModel.id}',
                                  style: defaultTextStyle,
                                ),
                                title: Text(
                                  currentModel.status.getDescription,
                                  style: defaultTextStyle,
                                ),
                                trailing: TextButton(
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _mapCubit.flyToMarker(
                                      marker: currentModel,
                                      mapController: widget._mapController,
                                      closePage: () {
                                        Modular.to.pop();
                                        Modular.to.pop();
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
