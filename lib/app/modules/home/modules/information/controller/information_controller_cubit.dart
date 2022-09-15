import 'package:dengue_tcc/app/modules/core/models/information/information_model.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_interface.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/repositories/information_repository.dart';
import 'package:dengue_tcc/app/utils/enums/information_enum/information_enum.dart';

part 'information_controller_state.dart';

class InformationControllerCubit extends InformationControllerInterface {
  InformationControllerCubit({
    required InformationRepository informationRepository,
  })  : _repository = informationRepository,
        super(InformationControllerState());

  final InformationRepository _repository;

  @override
  Future<void> getInformations() async {
    emit(LoadingInformationControllerState(
      pageType: state.pageType,
    ));

    final either = await _repository.getInformations(state.pageType.endpoint);
    either.fold(
      (errorMessage) => emit(ErrorInformationControllerState(
        pageType: state.pageType,
        errorMessage: errorMessage,
      )),
      (informationModel) => emit(SuccessInformationControllerState(
        pageType: state.pageType,
        model: informationModel,
      )),
    );
  }

  @override
  void initialize(InformationEnum? type) {
    emit(state.copyWith(
      pageType: type,
    ));
  }
}
