import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/modules/controller/add_next_campaing_controller_cubit.dart';

abstract class AddNextCampaingControllerInterface
    extends Cubit<AddNextCampaingControllerState> {
  AddNextCampaingControllerInterface(
      AddNextCampaingControllerState initialState)
      : super(initialState);

  Future<void> addNextCampaign({
    required String title,
    required String description,
    required String url,
  });
}
