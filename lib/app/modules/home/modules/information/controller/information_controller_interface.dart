import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_cubit.dart';
import 'package:dengue_tcc/app/utils/enums/information_enum/information_enum.dart';

abstract class InformationControllerInterface
    extends Cubit<InformationControllerState> {
  InformationControllerInterface(InformationControllerState initialState)
      : super(initialState);

  void initialize(InformationEnum? type);
  Future<void> getDenunciations();
  Future<void> getNextCampaigns();
}
