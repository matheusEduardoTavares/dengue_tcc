import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/home/controller/home_controller_cubit.dart';

abstract class HomeControllerInterface extends Cubit<HomeControllerState> {
  HomeControllerInterface(
    HomeControllerState initialState,
  ) : super(initialState);
}
