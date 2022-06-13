import 'package:bloc/bloc.dart';
import 'package:dengue_tcc/app/modules/auth/controller/auth_controller_cubit.dart';

abstract class AuthControllerInterface extends Cubit<AuthControllerState> {
  AuthControllerInterface(AuthControllerState initialState) : super(initialState);
  
  Future<void> loadData();
}