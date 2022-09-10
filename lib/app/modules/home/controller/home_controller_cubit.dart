import 'package:dengue_tcc/app/modules/home/controller/home_controller_interface.dart';

part 'home_controller_state.dart';

class HomeControllerCubit extends HomeControllerInterface {
  HomeControllerCubit() : super(HomeControllerState());
}
