import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/home/modules/information/controller/information_controller_cubit.dart';

abstract class InformationControllerInterface
    extends Cubit<InformationControllerState> {
  InformationControllerInterface(InformationControllerState initialState)
      : super(initialState);
}
