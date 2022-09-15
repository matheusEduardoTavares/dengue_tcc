import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/home/modules/tutorial/controller/tutorial_controller_cubit.dart';

abstract class TutorialControllerInterface
    extends Cubit<TutorialControllerState> {
  TutorialControllerInterface(TutorialControllerState initialState)
      : super(initialState);

  void changePage(int newIndex);
}
