import 'package:dengue_tcc/app/modules/tutorial/controller/tutorial_controller_interface.dart';

part 'tutorial_controller_state.dart';

class TutorialControllerCubit extends TutorialControllerInterface {
  TutorialControllerCubit() : super(TutorialControllerState.initial());

  @override
  void changePage(int newIndex) {
    emit(state.copyWith(selectedBottomNavigatorBarIndex: newIndex));
  }
}
