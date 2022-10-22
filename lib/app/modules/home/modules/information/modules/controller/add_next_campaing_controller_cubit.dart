import 'package:dengue_tcc/app/modules/core/models/next_campaigns/next_campaigns_model.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/modules/controller/add_next_campaing_controller_interface.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/repositories/information_repository.dart';
import 'package:dengue_tcc/app/utils/enums/map_marker/map_marker_enum.dart';

part 'add_next_campaing_controller_state.dart';

class AddNextCampaingControllerCubit
    extends AddNextCampaingControllerInterface {
  AddNextCampaingControllerCubit({
    required InformationRepository informationRepository,
  })  : _repository = informationRepository,
        super(AddNextCampaingControllerState());

  final InformationRepository _repository;

  @override
  Future<void> addNextCampaign({
    required String title,
    required String description,
    required String url,
  }) async {
    emit(LoadingAddNextCampaingControllerState());

    final either = await _repository.addNextCampaigns(
      nextCampaignModel: NextCampaignModel(
        description: description,
        title: title,
        date: DateTime.now(),
        status: MapMarkerEnum.active,
      ),
    );
    either.fold(
      (errorMessage) => emit(ErrorAddNextCampaingControllerState(
        errorMessage: errorMessage,
      )),
      (nextCampaignModel) => emit(SuccessAddNextCampaingControllerState(
        model: nextCampaignModel,
      )),
    );
  }
}
