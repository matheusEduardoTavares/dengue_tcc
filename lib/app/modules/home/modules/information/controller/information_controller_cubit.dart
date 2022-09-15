import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_interface.dart';

part 'information_controller_state.dart';

class InformationControllerCubit extends InformationControllerInterface {
  InformationControllerCubit() : super(InformationControllerState());
}
